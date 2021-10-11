//
//  LocationsVC.swift
//  Shanab
//
//  Created by Macbook on 5/4/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import DropDown
class LocationDetailsVC: UIViewController {
    
    @IBOutlet weak var Lat: CustomTextField!
    
    @IBOutlet weak var Long: CustomTextField!
    
    
    @IBOutlet weak var apartmentTF: UITextField!
    @IBOutlet weak var building: UITextField!
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var floor: UITextField!
    
    @IBOutlet weak var areaBn: UIButton!
    @IBOutlet weak var city: UIButton!
    @IBOutlet weak var country: UIButton!
    
    private let AddAddressVCPresenter = AddAddressPresenter(services: Services())
    
    let CountryDropDown = DropDown()
    let CityDropDown = DropDown()
    let AreaDropDown = DropDown()
    
    var cities = [String]()
    var Countries = [String]()
    var Aries = [String]()
    var cityId = Int()
    var city_id = String()
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 300
    var perviousLocation: CLLocation?
    let geoCoder = CLGeocoder()
    var lat = Double()
    var long = Double()
    var view_controller = String()
    var adressesList = [Country]()
    var countryId = Int()
    var area_id = Int()
    var country_id = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        AddAddressVCPresenter.setAddAddressViewDelegate(AddAddressViewDelegate: self)
        AddAddressVCPresenter.postGetCountries(table: "countries")

        
//        if "lang".localized == "ar" {
//            self.addressTF.textAlignment = .natural
//            self.street.textAlignment = .right
//            self.building.textAlignment = .right
//            self.floor.textAlignment = .right
//            self.apartmentTF.textAlignment = .right
//        } else {
//            self.addressTF.textAlignment = .left
//            self.street.textAlignment = .left
//            self.building.textAlignment = .left
//            self.floor.textAlignment = .left
//            self.apartmentTF.textAlignment = .left
//        }
        
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.addressTF.text = Constants.address
            
        Lat.text = String(Constants.lat)
        Long.text = String(Constants.long)
            
            //UserDefaults.standard.string(forKey: "Address") ?? ""
        
    }
    
    @IBAction func MapButtonPressed(_ sender: Any) {
        guard let sb = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "LocationVC") as? LocationVC else {return}
        self.navigationController?.pushViewController(sb, animated: true)
    }
    
    func SetupCityDropDown() {
        CityDropDown.anchorView = city
        CityDropDown.bottomOffset = CGPoint(x: 0, y: CityDropDown.anchorView?.plainView.bounds.height ?? 0 + 50)
        CityDropDown.dataSource = cities
        CityDropDown.selectionAction = {
            [weak self] (index, item) in
            self?.city.setTitleColor(#colorLiteral(red: 0.8121929765, green: 0.2939046025, blue: 0.2674312294, alpha: 1), for: .normal)
            self?.city.setTitle(item, for: .normal)
            self?.cityId = self?.adressesList[index].id ?? 0
            self?.cities.removeAll()
            self?.AddAddressVCPresenter.postGetAries(table: "areas", condition: "city_id", id: self?.adressesList[index].id ?? 0)
            
            
        }
        
        CityDropDown.direction = .any
        CityDropDown.width = self.view.frame.width * 1
    }
    func SetupAreaDropDown() {
        AreaDropDown.anchorView = areaBn
        AreaDropDown.bottomOffset = CGPoint(x: 0, y: AreaDropDown.anchorView?.plainView.bounds.height ?? 0 + 50)
        AreaDropDown.dataSource = Aries
        AreaDropDown.selectionAction = {
            [weak self] (index, item) in
            self?.areaBn.setTitleColor(#colorLiteral(red: 0.8121929765, green: 0.2939046025, blue: 0.2674312294, alpha: 1), for: .normal)
            self?.areaBn.setTitle(item, for: .normal)
            self?.area_id = self?.adressesList[index].id ?? 0
            
        }
        AreaDropDown.direction = .any
        AreaDropDown.width = self.view.frame.width * 1
    }

    
    func SetupCountryDropDown() {
        CountryDropDown.anchorView = country
        CountryDropDown.bottomOffset = CGPoint(x: 0, y: CountryDropDown.anchorView?.plainView.bounds.height ?? 0 + 50)
        CountryDropDown.dataSource = Countries
        CountryDropDown.selectionAction = {
            [weak self] (index, item) in
            self?.country.setTitleColor(#colorLiteral(red: 0.8121929765, green: 0.2939046025, blue: 0.2674312294, alpha: 1), for: .normal)
            self?.country.setTitle(item, for: .normal)
            self?.countryId = self?.adressesList[index].id ?? 0
            self?.AddAddressVCPresenter.postGetCitiesAndAries(table: "cities", condition: "country_id", id: self?.adressesList[index].id ?? 0)
            
        }
        CountryDropDown.direction = .any
        CountryDropDown.width = self.view.frame.width * 1
    }
    
    
    
    @IBAction func countryBN(_ sender: Any) {
        CountryDropDown.show()
    }
    
    @IBAction func CityBN(_ sender: Any) {
        CityDropDown.show()
    }
    
    @IBAction func AreaBN(_ sender: Any) {
        AreaDropDown.show()
    }
    
    
    @IBAction func cart(_ sender: Any) {

        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    
    
    
    @IBAction func Confirm(_ sender: UIButton) {
        guard self.validate() else {return}
        guard let floor = self.floor.text else {return}
        guard self.apartmentTF.text != nil else {return}
        guard let building = self.building.text else {return}
        AddAddressVCPresenter.showIndicator()
        AddAddressVCPresenter.postAddAddress(lat: lat, long: long, address: addressTF.text ?? "", floor: Int(floor) ?? 0, country_id: countryId, city_id: Int(city_id) ?? 0, area_id: area_id,  building: Int(building) ?? 0 , apartment: Int(apartmentTF.text ?? "") ?? 0)
        
    }
    private func validate() -> Bool {
//        if self.floor.text!.isEmpty {
//            displayMessage(title: "", message: "Floor needed".localized, status: .error, forController: self)
//            return false
//        } else if self.building.text!.isEmpty {
//            displayMessage(title: "", message: "Building needed".localized, status: .error, forController: self)
//            return false
//        }  else if self.apartmentTF.text!.isEmpty {
//            displayMessage(title: "", message: "Apartment needed".localized, status: .error, forController: self)
//            return false
//        } else
        
        if self.Lat.text!.isEmpty {
            
            displayMessage(title: "", message: "Latitude needed".localized, status: .error, forController: self)
            return false
            
        }else if self.Long.text!.isEmpty {
            
            displayMessage(title: "", message: "Longitude needed".localized, status: .error, forController: self)
            return false
            
        } else {
            return true
        }
        
    }
}
extension LocationDetailsVC: AddAddressViewDelegate {
    
    
    func postGetAries(_ error: Error?, _ result: [Country]?) {
        if let aries = result {
            self.adressesList = aries
            for Aries in aries {
                
                
                if "lang".localized == "ar" {

                    self.Aries.append(Aries.nameAr ?? "")

                }else {
                self.Aries.append(Aries.nameEn ?? "")
                }
            }
            SetupAreaDropDown()
        }
    }
    
    func postGetCitiesAndAries(_ error: Error?, _ result: [Country]?) {
        if let Cities = result {
            self.adressesList = Cities
            for cities in Cities {
                
                if "lang".localized == "ar" {
                    
                    self.cities.append(cities.nameAr ?? "")


                } else {
                
                    self.cities.append(cities.nameEn ?? "")
                }
                
            }
            SetupCityDropDown()
        }
    }
    func postGetCountries(_ error: Error?, _ result: [Country]?) {
        if let adds = result {
            self.adressesList = adds
            for countries in adds {
                
                
                if "lang".localized == "ar" {
                    
                    self.Countries.append(countries.nameAr ?? "")

                    
                } else {
                    self.Countries.append(countries.nameEn ?? "")
                    
                }
                
            }
            SetupCountryDropDown()
        }
        
    }
    
    
    func postAddAddress(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "Done", message: resultMsg.successMessage , status: .success, forController: self)
//                guard let sb = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "MyAddressesVC") as? MyAddressesVC else {return}
//                self.navigationController?.pushViewController(sb, animated: true)
                
                guard let window = UIApplication.shared.keyWindow else { return }

                
                guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
                
                details.selectedIndex = 2
                window.rootViewController = details
                
                
            } else if resultMsg.latitude != [""] {
                displayMessage(title: "", message: resultMsg.latitude[0], status: .error, forController: self)
            } else if resultMsg.longitude != [""] {
                displayMessage(title: "", message: resultMsg.longitude[0], status: .error, forController: self)
            } else if resultMsg.address != [""] {
                displayMessage(title: "", message: resultMsg.address[0], status: .error, forController: self)
            } else if resultMsg.city_id != [""] {
                displayMessage(title: "", message: resultMsg.city_id[0], status: .error, forController: self)
            }  else if resultMsg.floor != [""] {
                displayMessage(title: "", message: resultMsg.floor[0], status: .error, forController: self)
            } else if resultMsg.country_id != [""] {
                displayMessage(title: "", message: resultMsg.country_id[0], status: .error, forController: self)
            } else if resultMsg.city_id != [""] {
                displayMessage(title: "", message: resultMsg.city_id[0], status: .error, forController: self)
            } else if resultMsg.apartment != [""] {
                displayMessage(title: "", message: resultMsg.apartment[0], status: .error, forController: self)
            } else if resultMsg.building != [""] {
                displayMessage(title: "", message: resultMsg.building[0], status: .error, forController: self)
            }
        }
    }
}

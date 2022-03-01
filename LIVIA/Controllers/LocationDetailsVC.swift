//
//  LocationDetailsVC.swift
//  Livia
//
//  Created by MAC on 01/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//



import UIKit
import MapKit
import CoreLocation

class LocationDetailsVC: UIViewController {
    
    @IBOutlet weak var Lat: CustomTextField!
    @IBOutlet weak var Long: CustomTextField!
    @IBOutlet weak var apartmentTF: UITextField!
    @IBOutlet weak var building: UITextField!
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var floor: UITextField!
    @IBOutlet weak var areaBn: UITextField!
    @IBOutlet weak var city: UITextField!
    
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 300
    var perviousLocation: CLLocation?
    let geoCoder = CLGeocoder()
    var lat = Double()
    var long = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.areaBn.placeholder = "area".localized
        self.city.placeholder = "city".localized
        self.addressTF.placeholder = "address".localized
        self.building.placeholder = "building".localized
        self.floor.placeholder =  "floor".localized
        self.apartmentTF.placeholder = "falt".localized
    
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.addressTF.text = Constants.address
        Lat.text = String(Constants.lat)
        Long.text = String(Constants.long)
    }
    

    
    @IBAction func cart(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "ScanVc") as? ScanVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
    
    @IBAction func Confirm(_ sender: UIButton) {
       // guard self.validate() else {return}
        guard let floor = self.floor.text else {return}
        guard self.apartmentTF.text != nil else {return}
        guard let building = self.building.text else {return}

        self.navigationController?.popViewController(animated: true)

    }
    private func validate() -> Bool {
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

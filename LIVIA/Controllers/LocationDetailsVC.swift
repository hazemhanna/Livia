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
import RxSwift
import RxCocoa

class LocationDetailsVC: UIViewController {
    
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var building: UITextField!
    @IBOutlet weak var flatTF: UITextField!
    @IBOutlet weak var floor: UITextField!
    @IBOutlet weak var titleLbl  : UILabel!
    @IBOutlet weak var addressBtn : UIButton!

    @IBOutlet weak var phoneLbl : UILabel!
    @IBOutlet weak var addressLbl : UILabel!
    
    var notes: String?

    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.phoneTF.placeholder = "phone".localized
        self.addressTF.placeholder = "address".localized
        phoneLbl.text = "phone".localized
        addressLbl.text = "address".localized
        self.building.placeholder = "building".localized
        self.floor.placeholder =  "floor".localized
        self.flatTF.placeholder = "falt".localized
        self.addressBtn.setTitle("setLocation".localized, for: .normal)
        AuthViewModel.showIndicator()
        getProfile()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.addressTF.text =  Constants.address
    }
    
    @IBAction func cart(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func locationBtn(_ sender: Any) {
        guard let sb = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "LocationVC") as? LocationVC else {return}
        self.navigationController?.pushViewController(sb, animated: true)
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
 
    
    private func validate() ->Bool {
       if self.addressTF.text!.isEmpty {
            displayMessage(title: "", message: "Enter your address".localized, status: .error, forController: self)
            return false
        }else if self.phoneTF.text!.isEmpty {
            displayMessage(title: "", message: "Enter your phone number".localized, status: .error, forController: self)
            return false
        } else {
            return true
        }
    }
    
    
    @IBAction func Confirm(_ sender: UIButton) {
        guard self.validate() else {return}
        guard let sb = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "RequestTypePopUpVC") as? RequestTypePopUpVC else { return }
        sb.notes = notes
        sb.address = (self.addressTF.text ?? "") + (self.building.text ?? "") + (self.floor.text ?? "") + (self.flatTF.text ?? "")
        sb.phone = self.phoneTF.text ?? ""
        self.navigationController?.pushViewController(sb, animated: true)
    }

}

extension LocationDetailsVC {
    
    func getProfile() {
        self.AuthViewModel.getProfile().subscribe(onNext: { (data) in
            self.AuthViewModel.dismissIndicator()
            self.phoneTF.text = data.data?.phone ?? ""
            self.addressTF.text = data.data?.address ?? ""
            }, onError: { (error) in
                self.AuthViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
}

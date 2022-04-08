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
    
    var notes: String?

    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.phoneTF.placeholder = "phone".localized
        self.addressTF.placeholder = "address".localized
        self.building.placeholder = "building".localized
        self.floor.placeholder =  "floor".localized
        self.flatTF.placeholder = "falt".localized
        
        AuthViewModel.showIndicator()
        getProfile()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
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

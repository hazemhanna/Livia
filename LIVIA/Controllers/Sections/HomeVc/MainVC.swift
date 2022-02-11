//
//  MainVC.swift
//  Shanab
//
//  Created by Macbook on 3/22/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import CoreLocation

class MainVC: UIViewController , CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        checklocationAuthorization()
        locationManager.startUpdatingLocation()

        
        
    }
    
    
    func checklocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            
            break
        case .denied:
            locationManager.requestWhenInUseAuthorization()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            break
            
        @unknown default:
            fatalError()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        Constants.lat = locValue.latitude
        Constants.long = locValue.longitude

    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        Constants.lat = locValue.latitude
        Constants.long = locValue.longitude

    }
    
    @IBAction func Browser(_ sender: UIButton) {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
        sb.selectedIndex = 0
        window.rootViewController = sb
        UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
    }
    
    
    @IBAction func sideMenu(_ sender: UIBarButtonItem) {
        self.setupSideMenu()
    }
    
    @IBAction func Login(_ sender: UIButton) {
        guard let sb = UIStoryboard(name: "Authentications", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {return}
        self.navigationController?.pushViewController(sb, animated: true)
    }
    
}

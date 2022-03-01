//
//  OrderReceiptVC.swift
//  Shanab
//
//  Created by Macbook on 3/31/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Cosmos
import MapKit

class OrderReceiptVC: UIViewController {

    @IBOutlet weak var customerPic: UIImageView!
    @IBOutlet weak var MapKit: MKMapView!
    @IBOutlet weak var completedImageStatus: UIImageView!
    @IBOutlet weak var onwayStatusImage: UIImageView!
    @IBOutlet weak var arrivedStatusImage: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var newIStatusmage: UIImageView!
    @IBOutlet weak var viewGrdian: UIView!
    @IBOutlet weak var OnWayStatusLB: UILabel!
    @IBOutlet weak var CompletedStatusLB: UILabel!
    @IBOutlet weak var ArrivedStatusLB: UILabel!
    @IBOutlet weak var OnWayBn: UIButton!
    @IBOutlet weak var arrivedBn: UIButton!
    @IBOutlet weak var completedBn: UIButton!
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var parperStatusBn: UIButton!
    @IBOutlet weak var PerparingStatusLB: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var orderReceiptTableView: UITableView!
    @IBOutlet weak var fees: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var AcceptOrderView: UIView!
    @IBOutlet weak var TaxLb: UILabel!
    @IBOutlet weak var webLink: UILabel!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    @IBOutlet weak var titlewebLink : UILabel!
    @IBOutlet weak var TableHeight: NSLayoutConstraint!
    @IBOutlet weak var ProgressView: UIView!
    @IBOutlet weak var TopToView: NSLayoutConstraint?
    @IBOutlet weak var TopToProgress: NSLayoutConstraint?
    @IBOutlet weak var titleLbl  : UILabel!

    var totalOrderPrice: Double = 0.0
    var vat = ""
    var id = Int()

    fileprivate let cellIdentifier = "OrderReceiptCell"
    var lat , long : Double?
    var restauranlat , restaurantlong : Double?

    
    var status = "new"
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.address.text = UserDefaults.standard.string(forKey: "Address") ?? ""
        self.viewGrdian.setGradientBackground(colorOne: UIColor.red, colorTwo: UIColor.darkText)
        viewGrdian.layer.cornerRadius = 25
        viewGrdian.clipsToBounds = true
        MapKit.layer.cornerRadius = 20
        MapKit.clipsToBounds = true
        orderReceiptTableView.delegate = self
        orderReceiptTableView.dataSource = self
        orderReceiptTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        customerPic.setRounded()
    
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.openWebView(_:)))
        webLink.isUserInteractionEnabled = true
        webLink.addGestureRecognizer(gestureRecognizer)
        titlewebLink.text = "bill".localized
        orderNumber.text = "order Number".localized + ": \(id)"

    }
    
    @objc func openWebView(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: webLink.text ?? "") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
      //  self.address.text = UserDefaults.standard.string(forKey: "Address") ?? ""
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.orderReceiptTableView.layer.removeAllAnimations()
        TableHeight.constant = orderReceiptTableView.contentSize.height

        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
    
    @IBAction func AcceptOrRefuse(_ sender: UIButton) {
        
    }
    
    
    @IBAction func locationMap(_ sender: Any) {
//       let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "GetDirection")
//      //  Details.view_controller = "orderInfo"
//        self.navigationController?.pushViewController(Details, animated: true)
        
        
        UIApplication.shared.open(URL(string: "https://maps.google.com/?saddr=&daddr=\(lat ?? 0.0),\(long ?? 0.0)&directionsmode=driving")!, options: [:], completionHandler: nil)

    }
    
    
    @IBAction func restauranlocationMap(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://maps.google.com/?saddr=&daddr=\(restauranlat ?? 0.0),\(restaurantlong ?? 0.0)&directionsmode=driving")!, options: [:], completionHandler: nil)

    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func cart(_ sender: Any) {
//        guard let window = UIApplication.shared.keyWindow else { return }
//
//        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
//
//        details.selectedIndex = 2
//        window.rootViewController = details
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func newStatusBN(_ sender: Any) {
        
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onWayStatus(_ sender: Any) {
            if status == "preparing" {
            self.OnWayBn.isEnabled = false
            self.parperStatusBn.isEnabled = false
            self.completedBn.isEnabled = false
            self.arrivedBn.isEnabled = true
            
            newIStatusmage.image = #imageLiteral(resourceName: "icons8-ok")
            self.onwayStatusImage.image = #imageLiteral(resourceName: "icons8-sync")
                
        }
    }
    @IBAction func arrivedBN(_ sender: Any) {
        
        if status == "delivering" {
            self.arrivedBn.isEnabled = false
            self.parperStatusBn.isEnabled = false
            self.completedBn.isEnabled = true
            self.OnWayBn.isEnabled = false
            newIStatusmage.image = #imageLiteral(resourceName: "icons8-ok")
            onwayStatusImage.image = #imageLiteral(resourceName: "icons8-ok")
            self.arrivedStatusImage.image = #imageLiteral(resourceName: "icons8-sync")
        }
    }
    @IBAction func completedBN(_ sender: Any) {
        
        if status == "delivered" {

        self.completedBn.isEnabled = false
        self.parperStatusBn.isEnabled = false
        self.completedBn.isEnabled = true
        self.arrivedBn.isEnabled = false
        
        newIStatusmage.image = #imageLiteral(resourceName: "icons8-ok")
        onwayStatusImage.image = #imageLiteral(resourceName: "icons8-ok")
        self.arrivedStatusImage.image = #imageLiteral(resourceName: "icons8-ok")

        self.completedImageStatus.image = #imageLiteral(resourceName: "icons8-sync")
        
        }
    }
    
}
extension OrderReceiptVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? OrderReceiptCell else {return UITableViewCell()}

            return cell
       
    }
}


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
    private let DriverOrderDetailsVCPresenter = DriverOrderDetailsPresenter(services: Services())
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
    
    var totalOrderPrice: Double = 0.0
    var vat = ""
    var id = Int()
    var orderPrices = [Order]()
    fileprivate let cellIdentifier = "OrderReceiptCell"
    var lat , long : Double?
    var restauranlat , restaurantlong : Double?

    
    var status = "new"
    var details = [OrderDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.orderReceiptTableView.reloadData()
            }
        }
    }
    
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
        DriverOrderDetailsVCPresenter.setDriverOrderDetailsViewDelegate(DriverOrderDetailsViewDelegate: self)
        DriverOrderDetailsVCPresenter.getCartItems()
        DriverOrderDetailsVCPresenter.getWebView(order_id : id)

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
        
        DriverOrderDetailsVCPresenter.showIndicator()
        
        if sender.tag == 1 {
            
            DriverOrderDetailsVCPresenter.postWorkerCancelOrder(order_id: id , status: "accepted")
        } else if sender.tag == 0 {
            
            DriverOrderDetailsVCPresenter.postWorkerCancelOrder(order_id: id , status: "refused")

            
        }
        
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
        
        print(details[0].status)
        
        if status == "preparing" {
            DriverOrderDetailsVCPresenter.DriverChangeStatus(id: id , status : "delivering")
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

            DriverOrderDetailsVCPresenter.DriverChangeStatus(id: id , status : "delivered")
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

        DriverOrderDetailsVCPresenter.DriverChangeStatus(id: id , status : "competed")
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
        
        print(details.count)
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? OrderReceiptCell else {return UITableViewCell()}

            return cell
       
    }
}
extension OrderReceiptVC: DriverOrderDetailsViewDelegate {
    
    func getWebView(_ error: Error?, _ result: WebViewModel?) {
        self.webLink.text = result?.link ?? ""
    }
    
    func getCartResult(_ error: Error?, _ result: String?) {
        
        if let vat = result {
            self.vat = vat
            
            self.TaxLb.text = ("The total price includes ".localized + "VAT tax".localized)
        DriverOrderDetailsVCPresenter.getDriverOrderDetails(id: id)

        }
    }
    
    func getDriverProfileResult(_ error: Error?, _ result: User?) {
        if let profile = result {

        }
    }
    
    
    func calculateTotalPrice() {
        var price: Double = 0.0
        self.orderPrices.forEach { (order) in
            price += order.price
            self.orderPrice.text = "\(price)"
            self.fees.text = "\(50)"
            self.total.text = "\(price + 50)"
        }
        print(price)
    }
    
    
    func DriverOrderDetailsResult(_ error: Error?, _ details: [DriverOrder]?) {
        self.orderReceiptTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    func DriverChangeStatusResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let status = result {
            if status.successMessage != "" {
                displayMessage(title: "Done".localized, message:"", status: .success, forController: self)
                TopToProgress?.isActive = true
                TopToView?.isActive = false

                DriverOrderDetailsVCPresenter.getDriverOrderDetails(id: id)

            } else if status.id != [""] {
                displayMessage(title: "", message: status.id[0], status: .error, forController: self)
            }
        }
    }
    
    
    func postDriverRejactOrderResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "", message: "Done".localized, status: .success, forController: self)
                
                guard let window = UIApplication.shared.keyWindow else { return }

                let main = UIStoryboard(name: "Orders", bundle: nil).instantiateViewController(withIdentifier: "DriverProfileNav")
                
              //  main.orderSelected = .completed
                window.rootViewController = main

            } else if resultMsg.order_id != [""] {
                displayMessage(title: "", message: resultMsg.order_id[0], status: .error, forController: self)
            }
        }
    }
    
}

class Order {
    var price: Double
    
    init(price: Double) {
        self.price = price
    }
}

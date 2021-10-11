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
    @IBOutlet weak var cosmos: CosmosView!
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var AcceptOrderView: UIView!
    
    @IBOutlet weak var TaxLb: UILabel!
    
    var totalOrderPrice: Double = 0.0
    var vat = ""

    var id = Int()
    var details = [OrderDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.orderReceiptTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var TopToView: NSLayoutConstraint?
    
    @IBOutlet weak var TopToProgress: NSLayoutConstraint?
    
    var orderPrices = [Order]()
    fileprivate let cellIdentifier = "OrderReceiptCell"
    
    var lat , long : Double?
    
    @IBOutlet weak var TableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var ProgressView: UIView!
    
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
        DriverOrderDetailsVCPresenter.setDriverOrderDetailsViewDelegate(DriverOrderDetailsViewDelegate: self)
        DriverOrderDetailsVCPresenter.getCartItems()
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
        let meal = details[indexPath.row].meal ?? Meal()
        if "lang".localized == "ar"{
            cell.config(name: meal.nameAr ?? "" , number: details[indexPath.row].quantity ?? 0 , price: "\(details[indexPath.row].meal?.price?[0].price?.rounded(toPlaces: 2) ?? 0.0)", options: self.details[indexPath.row].option ?? [Option](), restaurant: meal.restaurant?.nameAr ??    "" )
          
            return cell
        } else {
            cell.config(name: meal.nameEn ?? "" , number: details[indexPath.row].quantity ?? 0 , price: "\(details[indexPath.row].meal?.price?[0].price?.rounded(toPlaces: 2) ?? 0.0)", options: self.details[indexPath.row].option ?? [Option](), restaurant: meal.restaurant?.nameEn ?? "" )
            return cell
        }
    }
}
extension OrderReceiptVC: DriverOrderDetailsViewDelegate {
    func getCartResult(_ error: Error?, _ result: String?) {
        
        if let vat = result {
            self.vat = vat
            
            self.TaxLb.text = ("The total price includes ".localized + "VAT tax".localized)
        DriverOrderDetailsVCPresenter.getDriverOrderDetails(id: id)

        }
    }
    
    func getDriverProfileResult(_ error: Error?, _ result: User?) {
        if let profile = result {
//            self.phone.text = profile.phone ?? ""
//            if "lang".localized == "ar" {
//                self.name.text = profile.nameAr ?? ""
//            } else {
//                self.name.text = profile.nameEn ?? ""
//            }
//
//            if let image = profile.image {
//                guard let url = URL(string: image) else { return }
//                self.customerPic.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo-1"))
//            }
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
        
        
        
        if let detail = details {
            self.details = detail[0].orderDetail ?? [OrderDetail]()
            
            status = detail[0].status ?? "new"
            
            if detail[0].status == "new" {
                                    
                TopToProgress?.isActive = false
                TopToView?.isActive = true

                ProgressView.isHidden = true
                
                if detail[0].approved == 0 {
                    
                    AcceptOrderView.alpha = 1
                } else {
                    
                    AcceptOrderView.alpha = 0

                }
                
            } else if detail[0].status == "preparing" {
                
                TopToProgress?.isActive = true
                TopToView?.isActive = false
                ProgressView.isHidden = false
                self.OnWayBn.isEnabled = true
                
                newIStatusmage.image = #imageLiteral(resourceName: "icons8-sync")
                
            } else if detail[0].status == "delivered" {
                TopToProgress?.isActive = true
                TopToView?.isActive = false
                ProgressView.isHidden = false
                
                newIStatusmage.image = #imageLiteral(resourceName: "icons8-ok")
                onwayStatusImage.image = #imageLiteral(resourceName: "icons8-ok")

                arrivedStatusImage.image = #imageLiteral(resourceName: "icons8-sync")

            } else if detail[0].status == "delivering" {
                
                TopToProgress?.isActive = true
                TopToView?.isActive = false
                ProgressView.isHidden = false


                
                newIStatusmage.image = #imageLiteral(resourceName: "icons8-ok")
                onwayStatusImage.image = #imageLiteral(resourceName: "icons8-sync")

            } else if detail[0].status == "competed" {
                
                TopToProgress?.isActive = true
                TopToView?.isActive = false
                ProgressView.isHidden = false

                
                newIStatusmage.image = #imageLiteral(resourceName: "icons8-ok")
                onwayStatusImage.image = #imageLiteral(resourceName: "icons8-ok")
                arrivedStatusImage.image = #imageLiteral(resourceName: "icons8-ok")
                completedImageStatus.image = #imageLiteral(resourceName: "icons8-ok")

            }
            
            self.name.text = detail[0].client?.user?.name ?? ""
            self.phone.text = detail[0].client?.user?.phone ?? ""
            self.address.text = detail[0].address?.address ?? ""
            self.lat = detail[0].address?.lat
            self.long = detail[0].address?.long
            
//            self.details.forEach {
//                orderPrices.append(Order(price: $0.price ?? -1.0))
//            }
//            self.calculateTotalPrice()
            
            var orderCost = Double()
            var count = 0
            for item in self.details {
                                
                if item.meal?.hasOffer == 1 {
                    
                    var discount = (Double(item.meal?.discount ?? 0))
                    
                    if item.meal?.discountType == "percentage" {
                        
                        discount /= 100
                        discount = ((item.meal?.price?[0].price ?? 0.0) - ((item.meal?.price?[0].price ?? 0.0 ) * Double(discount))).rounded(toPlaces: 2)
                        
                        orderCost = Double(orderCost + (Double(item.quantity ?? 0) * discount)).rounded(toPlaces: 2)

                        
                    } else {
                        
                        discount = ((item.meal?.price?[0].price ?? 0.0) -  Double(discount)).rounded(toPlaces: 2)
                        
                        orderCost = Double(orderCost + (Double(item.quantity ?? 0) * discount)).rounded(toPlaces: 2)

                    }
                    
                    self.details[count].meal?.price?[0].price = discount
                    print(self.details[count].meal?.price?[0].price)
                    
                } else {
                    
                    orderCost = Double(orderCost + (Double(item.quantity ?? 0) * (item.meal?.price?[0].price ?? 0.0))).rounded(toPlaces: 2)

                }
                
                for options in (item.option ?? []) {
                    
                    orderCost = Double(orderCost + ((options.price ?? 0.0))).rounded(toPlaces: 2)
                    
                }
        
                count += 1
            }
            
            let vatD = Double((Double(vat)?.rounded(toPlaces: 2) ?? 0.0)/100).rounded(toPlaces:2)
            
            print(vatD)
            let orderCostWithVat = orderCost + (orderCost * vatD)
           // orderPrice.text = "\(orderCost)"

            orderPrice.text = "\(orderCost.rounded(toPlaces:2))"
            
            total.text = "\(detail[0].total?.rounded(toPlaces: 2) ?? 0.0)"
            
            
            print(detail[0].total , "\n" , orderCostWithVat , "\n" , orderCost )

            let feesCalcoulation = Double(((detail[0].total ?? 0.0) - orderCostWithVat)).rounded(toPlaces: 1)
            
            if detail[0].type != "sfry" {
                
                fees.text = "\(feesCalcoulation)"

            } else {
                
                fees.text = "0.0"

            }
            
        }
        
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

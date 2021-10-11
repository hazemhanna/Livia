//
//  UserOrderDetailsVC.swift
//  Shanab
//
//  Created by Macbook on 7/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
class UserOrderDetailsVC: UIViewController {
    private let UserOrderDetailsVCPresenter = UserOrderDetailsPresenter(services: Services())
    @IBOutlet weak var totalPriceLB: UILabel!
    @IBOutlet weak var fees: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    
    @IBOutlet weak var TaxLb: UILabel!
    @IBOutlet weak var detailsTableView: UITableView!
    
    
    fileprivate let cellIdentifier = "OrderReceiptCell"
    var status = String()
    var order_id = Int()
    var id = Int()
    var vat = ""
    var details = [OrderDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.detailsTableView.reloadData()
              //  self.detailsTableView.scrollToRow(at: IndexPath(row: self.details.count - 1 , section: 0), at: .middle, animated: true)

            }
        }
    }
    
    @IBOutlet weak var TableHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        

        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.estimatedRowHeight = 120

        
        
        UserOrderDetailsVCPresenter.setUserOrderDetailsViewDelegate(UserOrderDetailsViewDelegate: self)
        UserOrderDetailsVCPresenter.showIndicator()
        UserOrderDetailsVCPresenter.getCartItems()
        
        
        
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.detailsTableView.layer.removeAllAnimations()
        TableHeight.constant = detailsTableView.contentSize.height

        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
    
//    override func updateViewConstraints() {
//
//
//        print(self.detailsTableView.contentSize.height)
//
//
//        if self.detailsTableView.contentSize.height < 200.0 {
//
//            self.TableHeight.constant = self.detailsTableView.contentSize.height
//
//            self.view.layoutIfNeeded()
//
//        }
//
//        super.updateViewConstraints()
//
//
//    }
    
    @IBAction func Dismiss(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension UserOrderDetailsVC: UserOrderDetailsViewDelegate {
    func getCartResult(_ error: Error?, _ result: String?) {
        
        if let error = error {
            
            displayMessage(title: "", message: error.localizedDescription, status: .error, forController: self)
        } else {
            
            self.vat = result ?? "0"
            self.TaxLb.text = ("The total price includes ".localized + "VAT tax".localized)
            self.UserOrderDetailsVCPresenter.postUserOrderDetails(id: id, status: status)
        }
    }
    
    func UserOrderDetailsResult(_ error: Error?, _ result: [DriverOrder]?) {
        if let detail = result {
            self.details = detail[0].orderDetail ?? [OrderDetail]()
            var orderCost = Double()
            var count = 0
            for item in details {
                
                
                
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
            
            totalPriceLB.text = "\(result?[0].total?.rounded(toPlaces: 2) ?? 0.0)"
            
            
            print(result?[0].total , "\n" , orderCostWithVat , "\n" , orderCost )

            let feesCalcoulation = Double(((result?[0].total ?? 0.0) - orderCostWithVat)).rounded(toPlaces: 1)
            
            if result?[0].type != "sfry" {
                
                fees.text = "\(feesCalcoulation)"

            } else {
                
                fees.text = "0.0"

            }
            
            
            
//            self.totalPriceLB.text
//            self.fees.text
//            self.orderPrice.text = details.
            self.detailsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)

        }
        
    }
    
    
}
extension UserOrderDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? OrderReceiptCell else {return UITableViewCell()}
        let meal = details[indexPath.row].meal ?? Meal()
        let name = "lang".localized == "ar" ? meal.nameAr : meal.nameEn
        let restaurant = "lang".localized == "ar" ? meal.restaurant?.nameAr : meal.restaurant?.nameEn
        cell.config(name: name ?? "" , number: details[indexPath.row].quantity ?? 0 , price: "\(details[indexPath.row].meal?.price?[0].price?.rounded(toPlaces: 2) ?? 0.0)" , options: self.details[indexPath.row].option ?? [Option](), restaurant: restaurant ?? "" )
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        detailsTableView.scrollToRow(at: IndexPath(item: details.count - 1 , section: 0), at: .middle, animated: true)

       // self.viewWillLayoutSubviews()
    }
}

//
//  OrderDetailsVC.swift
//  Livia
//
//  Created by MAC on 20/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import Foundation
import UIKit

class OrderDetailsVC : UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var TableHeight: NSLayoutConstraint!
    @IBOutlet weak var discreption: UITextField!
    @IBOutlet weak var titleLbl  : UILabel!
    @IBOutlet weak var deliveryLbl   : UILabel!
    @IBOutlet weak var totalLbl  : UILabel!

    fileprivate let cellIdentifier = "FoodPackgeCell"
    var order: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        titleLbl.text = "Order List".localized
        cartTableView.delegate = self
        cartTableView.dataSource = self
       cartTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
                               
    }
    
    override func viewWillAppear(_ animated: Bool) {
        TableHeight.constant = CGFloat(120 * (order?.orderItems?.count ?? 0))
        cartTableView.reloadData()
        discreption.text = order?.notes
        
        var total = 10
        for t in  self.order?.orderItems ?? [] {
            let price = Double(t.price ?? "") ?? 0.0
            total +=  Int(price) * (t.quantity ?? 0)
        }
        
        self.totalLbl.text = "total cost".localized + " " + String(total) + " " + "EGP".localized
        self.deliveryLbl.text = "delivery fees".localized + " " + String(10) + " " + "EGP".localized

    }
                                       
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func cancelButton(_ sender: Any) {
        guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "CancelOrder") as? CancelOrder else { return }
        self.navigationController?.pushViewController(Details, animated: true)
    }
    
    @IBAction func followButton(_ sender: Any) {
        guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "OrderFollowingVC") as? OrderFollowingVC else { return }
        self.navigationController?.pushViewController(Details, animated: true)
    }
    
    
    @IBAction func showBillButton(_ sender: Any) {
        guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "UserOrderDetailsVC") as? UserOrderDetailsVC else { return }
        Details.order = order
        self.navigationController?.pushViewController(Details, animated: true)
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "ScanVc") as? ScanVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
}

extension OrderDetailsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order?.orderItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FoodPackgeCell else {return UITableViewCell()}
        let item = order?.orderItems?[indexPath.row]
        
        if "lang".localized == "ar" {
            cell.config(imagePath: item?.product?.images?[0].image ?? "" , date: "", price: item?.price ?? "" , time: item?.product?.title?.ar ?? "", pakageName: item?.product?.desc?.ar ?? "")
        }else{
            cell.config(imagePath: item?.product?.images?[0].image ?? "" , date: "", price: item?.price ?? "" , time: item?.product?.title?.en ?? "", pakageName: item?.product?.desc?.en ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

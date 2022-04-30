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
    @IBOutlet weak var canceBtn  : UIButton!
    
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
        
        var total = 0
        for t in  self.order?.orderItems ?? [] {
            let price = Double(t.price ?? "") ?? 0.0
            total +=  Int(price) * (t.quantity ?? 0)
        }
        
        if order?.order_place == 1{
            self.totalLbl.text = "total cost".localized + " " + String(total + 10) + " " + "EGP".localized
            self.deliveryLbl.text = "delivery fees".localized + " " + String(10) + " " + "EGP".localized
            deliveryLbl.isHidden = false
        }else{
            self.totalLbl.text = "total cost".localized + " " + String(total) + " " + "EGP".localized
            deliveryLbl.isHidden = true
        }
    
        if(getDateTimeDiff(dateStr: order?.created_at ?? "" )){
            canceBtn.isHidden = false
        }else{
            canceBtn.isHidden = true
        }
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
        Details.order = order
        self.navigationController?.pushViewController(Details, animated: true)
    }
    
    
    @IBAction func showBillButton(_ sender: Any) {
        guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "UserOrderDetailsVC") as? UserOrderDetailsVC else { return }
        Details.order = order
        self.navigationController?.pushViewController(Details, animated: true)
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    

    func getDateTimeDiff(dateStr:String) -> Bool {
        
        let formatter : DateFormatter = DateFormatter()
        formatter.timeZone = NSTimeZone.local
        formatter.dateFormat = "HH:mm"
        
        let now = formatter.string(from: NSDate() as Date)
        let startDate = formatter.date(from: dateStr)
        let endDate = formatter.date(from: now)
        
        // *** create calendar object ***
        var calendar = NSCalendar.current
        
        // *** Get components using current Local & Timezone ***
        print(calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: startDate!))
        
        // *** define calendar components to use as well Timezone to UTC ***
        let unitFlags = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second])
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let dateComponents = calendar.dateComponents(unitFlags, from: startDate!, to: endDate!)
        
        // *** Get Individual components from date ***
        let years = dateComponents.year!
        let months = dateComponents.month!
        let days = dateComponents.day!
        let hours = dateComponents.hour!
        let minutes = dateComponents.minute!
        let seconds = dateComponents.second!
        
        var timeAgo = false
        
        if (seconds > 0){
            if seconds < 2 {
                timeAgo = true
            }
            else{
                timeAgo = true
            }
        }
        
        if (minutes > 0){
            if minutes < 15 {
                timeAgo = true
            }
            else{
                timeAgo = false
            }
        }
        
        if(hours > 0){
            if hours < 2 {
                timeAgo = false
            }
            else{
                timeAgo = false
            }
        }
        
        if (days > 0) {
            if days < 2 {
                timeAgo = false
            }
            else{
                timeAgo = false
            }
        }
        
        if(months > 0){
            if months < 2 {
                timeAgo = false
            }
            else{
                timeAgo = false
            }
        }
        
        if(years > 0){
            if years < 2 {
                timeAgo = false
            }
            else{
                timeAgo = false
            }
        }
      
        return timeAgo
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


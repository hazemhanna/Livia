//
//  NotificationsVC.swift
//  Shanab
//
//  Created by Macbook on 3/29/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class NotificationsVC: UIViewController {
    @IBOutlet weak var notificationsTableView: UITableView!
    var NotificationArr = [Notifications]()
    @IBOutlet weak var profileCollectionView: UICollectionView!
    fileprivate let cellIdentifier = "NotificationsCell"
    
    private let  ProileVCPresenter = DriverProfilePresenter(services: Services())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProileVCPresenter.setDriverProfileViewDelegate(DriverProfileViewDelegate: self)

        notificationsTableView.delegate = self
        notificationsTableView.dataSource = self
        notificationsTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        ProileVCPresenter.getNotifications()
       
    }
    
    @IBAction func cart(_ sender: Any) {
       
        guard let window = UIApplication.shared.keyWindow else { return }

        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
        
        details.selectedIndex = 2
        window.rootViewController = details
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    

}
extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotificationArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? NotificationsCell else {return UITableViewCell()}
        
        let data = NotificationArr[indexPath.row]
        cell.config(name: "\(data.itemID ?? 0)", status: data.body ?? "")
//        cell.config(name: "" , status: "")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "OrderReceiptVC") as? OrderReceiptVC else { return }
        Details.id = self.NotificationArr[indexPath.row].itemID ?? 0
        self.navigationController?.pushViewController(Details, animated: true)
    }
    
    
}

extension NotificationsVC : DriverProfileViewDelegate {
    func DriverChangeImageResult(_ error: Error?, _ result: SuccessError_Model?) {
        print("")
    }
    
    func DriverIsAvaliableChangeResult(_ error: Error?, _ result: SuccessError_Model?) {
        print("")
    }
    
    func DriverOrderListResult(_ error: Error?, _ list: OrderListPagination?, _ orderErrors: OrdersErrors?) {
        print("")
    }
    
    func getDriverProfileResult(_ error: Error?, _ result: User?) {
        print("")
    }
    
    func postEditDriverProfileResult(_ error: Error?, _ result: SuccessError_Model?) {
        print("")

    }
    
    func getDeleteImage(_ error: Error?, _ result: SuccessError_Model?) {
        print("")

    }
    
    
    func getNotifications(_ error: Error?, _ notifications: [Notifications]?) {
        
        NotificationArr = notifications?.reversed() ?? []
        self.notificationsTableView.reloadData()
    }
}

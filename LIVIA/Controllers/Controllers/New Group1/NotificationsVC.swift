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

    
  //  var NotificationArr = [Notifications]()
    
    fileprivate let cellIdentifier = "NotificationsCell"
    let user = Helper.getUserRole() ?? ""


    var paid = false
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationsTableView.delegate = self
        notificationsTableView.dataSource = self
        notificationsTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    

}
extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? NotificationsCell else {return UITableViewCell()}
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

//
//  OrderList.swift
//  Shanab
//
//  Created by Macbook on 3/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import DropDown
import Cosmos
class OrderListVC : UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    

    fileprivate let cellIdentifier = "ListCell"
    
    
//    var list = [orderList](){
//        didSet {
//            DispatchQueue.main.async {
//                self.listTableView.reloadData()
//            }
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // if  Helper.getApiToken() == "" || Helper.getApiToken() == nil {
         //   displayMessage(title: "", message: "You should login first".localized, status:.warning, forController: self)
     //   } else {
            listTableView.delegate = self
            listTableView.dataSource = self
            listTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        //}
        
    }
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }

    
}
extension OrderListVC: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ListCell else { return UITableViewCell()}
        cell.goToDetails = {
            guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "UserOrderDetailsVC") as? UserOrderDetailsVC else { return }
            self.navigationController?.pushViewController(Details, animated: true)
            
        }
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "UserOrderDetailsVC") as? UserOrderDetailsVC else { return }
        self.navigationController?.pushViewController(Details, animated: true)
        
    }
    
  
    
}

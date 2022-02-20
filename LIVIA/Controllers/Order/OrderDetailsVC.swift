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
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var noProduct: UILabel!
    @IBOutlet weak var TableHeight: NSLayoutConstraint!
    @IBOutlet weak var discreption: UITextField!
    
    fileprivate let cellIdentifier = "FoodPackgeCell"
    
//    var CartIems = [onlineCart]() {
//        didSet {
//            self.cartTableView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableHeight.constant = (120 * 3)
    }
    
    override func viewWillAppear(_ animated: Bool) {

            cartTableView.delegate = self
            cartTableView.dataSource = self
            cartTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    
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
        self.navigationController?.pushViewController(Details, animated: true)
    }
    
}

extension OrderDetailsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FoodPackgeCell else {return UITableViewCell()}
        cell.config(imagePath: "", date: "اضافة جبنة وزيتون", price: 40.0 , time: "ييتزا", pakageName: "بيتزا سي فود")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

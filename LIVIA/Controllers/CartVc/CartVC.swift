//
//  File.swift
//  Livia
//
//  Created by MAC on 18/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation
import UIKit

class CartVC: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var noProduct: UILabel!
    @IBOutlet weak var TableHeight: NSLayoutConstraint!
    @IBOutlet weak var discreption: UITextField!
    
    fileprivate let cellIdentifier = "ValiableResturantCell"
    var productCounter = Int()

//    var CartIems = [onlineCart]() {
//        didSet {
//            self.cartTableView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableHeight.constant = (150 * 4)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if  Helper.getApiToken() == "" || Helper.getApiToken() == nil {
//            displayMessage(title: "", message: "You should login first".localized, status:.warning, forController: self)
//            noProduct.text = "You should login first".localized
//        } else {
            cartTableView.delegate = self
            cartTableView.dataSource = self
            cartTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
            noProduct.text = "emptyCart".localized
      //  }
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func confirmBtn(_ sender: Any) {
        guard let details = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "OrderConfirmationPopUp") as? OrderConfirmationPopUp else { return }
        self.navigationController?.present(details, animated: true, completion: nil)
        
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ValiableResturantCell else {return UITableViewCell()}
        cell.FavoriteBN.setImage(UIImage(named: "remove"), for: .normal)
        
        cell.increase = {
            self.productCounter += 1
            cell.quantityTF.text = "\(self.productCounter)"
        }
        
        cell.decrease = {
            if self.productCounter > 1 {
                self.productCounter -= 1
                cell.quantityTF.text = "\(self.productCounter)"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

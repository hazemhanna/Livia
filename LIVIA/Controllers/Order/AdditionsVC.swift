//
//  MakeOrderVC.swift
//  Shanab
//
//  Created by Macbook on 3/26/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import DLRadioButton
class ProductDetails: UIViewController {
    @IBOutlet weak var AdditionTableView: UITableView!
    @IBOutlet weak var quantityTF: UILabel!
    @IBOutlet weak var stackViewST: UIStackView!
    @IBOutlet weak var mealNameLB: UILabel!
    @IBOutlet weak var notesTF: UITextField!
    @IBOutlet weak var oneImageView: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var RestaurantName: UILabel!
    
    fileprivate let cellIdentifier = "AdditionsCell"
    fileprivate let HeaderIdentifier = "HeaderCell"
    
    
    @IBOutlet weak var OptionTableHeight: NSLayoutConstraint!
    
    var restaurant_id = Int()
    var productCounter = Int()

    
  
    override func viewDidLoad() {
        super.viewDidLoad()

//
//        AdditionTableView.delegate = self
//        AdditionTableView.dataSource = self
//        AdditionTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
//        AdditionTableView.register(UINib(nibName: HeaderIdentifier, bundle: nil), forCellReuseIdentifier: HeaderIdentifier)
//
//
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.AdditionTableView.layer.removeAllAnimations()
        OptionTableHeight.constant = AdditionTableView.contentSize.height

        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cart(_ sender: Any) {

        setupSideMenu()
        
    }
    @IBAction func Increase(_ sender: UIButton) {
        self.productCounter += 1
        self.quantityTF.text = "\(self.productCounter)"
        
    }

    @IBAction func decreaseBN(_ sender: UIButton) {
        if productCounter > 1 {
            self.productCounter -= 1
            self.quantityTF.text = "\(self.productCounter)"
        }
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        
        if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
            
            displayMessage(title: "", message: "You should login first".localized, status:.warning, forController: self)
        } else {
   
            
        }
    }
}
//extension ProductDetails: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:
//            indexPath) as? AdditionsCell else {return UITableViewCell()}
//        
//        return cell
//
//        
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderIdentifier) as? HeaderCell else {return UITableViewCell()}
//            return cell
//    }
//    
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return 50
//    }
//}

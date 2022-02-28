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


    var meals = [RestaurantMeal]() {
        didSet{
            DispatchQueue.main.async { [self] in
                self.cartTableView.reloadData()
                self.TableHeight.constant = CGFloat((150 * self.meals.count))

            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meals.append(RestaurantMeal(nameAr: "سلطة خضراء", image: #imageLiteral(resourceName: "taylor-kiser-EvoIiaIVRzU-unsplash-1"), descriptionAr: "سلطة"))
        meals.append(RestaurantMeal(nameAr: "بيتزا سي فود", image: #imageLiteral(resourceName: "food-1"), descriptionAr: "بيتزا"))
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
    
    func show () {
        if meals.count > 0 {
            cartTableView.isHidden = false
            self.emptyView.isHidden = true
        }else{
            cartTableView.isHidden = true
            self.emptyView.isHidden = false
        }
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func confirmBtn(_ sender: Any) {
        self.meals.removeAll()
        self.emptyView.isHidden = false
        cartTableView.reloadData()
        guard let details = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "OrderConfirmationPopUp") as? OrderConfirmationPopUp else { return }
        details.modalPresentationStyle =  .fullScreen
        self.navigationController?.present(details, animated: true, completion: nil)
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "ScanVc") as? ScanVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    

    @IBAction func searchButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }

    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ValiableResturantCell else {return UITableViewCell()}
        cell.FavoriteBN.setImage(UIImage(named: "remove"), for: .normal)
        
        
        cell.config(name: meals[indexPath.row].nameAr ?? "",price: 12.2, imagePath: meals[indexPath.row].image  , type: meals[indexPath.row].descriptionAr ?? "")

        
         cell.goToFavorites = {
            self.meals.remove(at: indexPath.row)
             self.show()
        }
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

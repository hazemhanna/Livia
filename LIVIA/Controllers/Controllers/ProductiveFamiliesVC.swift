//
//  ProductiveFamiliesVC.swift
//  Shanab
//
//  Created by Macbook on 3/31/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
class ProductiveFamiliesVC: UIViewController {
    fileprivate let cellIdentifier = "ProductiveFamiliesCell"
    @IBOutlet weak var FamiliesTableView: UITableView!
    //    var type = "family"
    private let RestaurantsVCPresenter = RestaurantsPresenter(services: Services())
    var restaurants_list = [Restaurant]()
    {
        didSet {
            DispatchQueue.main.async {
                self.FamiliesTableView.reloadData()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FamiliesTableView.delegate = self
        FamiliesTableView.dataSource = self
        FamiliesTableView.tableFooterView = UIView()
        //        FamiliesTableView.rowHeight = UITableView.automaticDimension
        //               FamiliesTableView.estimatedRowHeight = UITableView.automaticDimension
        FamiliesTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        FamiliesTableView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        FamiliesTableView.layer.cornerRadius = 25
        FamiliesTableView.layer.borderWidth = 1
        RestaurantsVCPresenter.setRestaurantsViewDelegate(RestaurantsViewDelegate: self)
        RestaurantsVCPresenter.showIndicator()
        RestaurantsVCPresenter.getAllRestaurants(type: ["family"])
        
    }
    @IBAction func cart(_ sender: Any) {
//        guard let details = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "CartVC") as? CartVC else { return }
//        self.navigationController?.pushViewController(details, animated: true)
        
//        guard let window = UIApplication.shared.keyWindow else { return }
//
//        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
//
//        details.selectedIndex = 2
//        window.rootViewController = details
        
        setupSideMenu()
    }
    
    @IBAction func backButton(_ sender: Any) {
//        guard let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as? MainVC else {return}
//        self.navigationController?.pushViewController(sb, animated: true)
        
        self.navigationController?.popViewController(animated: true)
    }
}
extension ProductiveFamiliesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProductiveFamiliesCell else { return UITableViewCell()}
        
        if Helper.getApiToken() != "" || Helper.getApiToken() != nil {

        
        if restaurants_list[indexPath.row].favorite?.count == 0 {
            
            cell.FavoriteBN.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
            cell.isFavourite = false
        } else {
            
            
            cell.FavoriteBN.setImage(#imageLiteral(resourceName: "heart 2-1"), for: .normal)
            cell.isFavourite = true


        }
        }
        
        cell.addToFavorite = {

        if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
            
            displayMessage(title: "Add favourite".localized, message: "You should login first".localized, status:.warning, forController: self)
        } else {
            
            self.RestaurantsVCPresenter.showIndicator()
            
            if cell.FavoriteBN.image(for: .normal) == #imageLiteral(resourceName: "heart") {
            self.RestaurantsVCPresenter.postCreateFavorite(item_id: self.restaurants_list[indexPath.row].id ?? 0, item_type: "meal")
                cell.FavoriteBN.setImage(#imageLiteral(resourceName: "heart 2-1"), for: .normal)

            } else {
            self.RestaurantsVCPresenter.postRemoveFavorite(item_id: self.restaurants_list[indexPath.row].id ?? 0, item_type: "meal")
                cell.FavoriteBN.setImage(#imageLiteral(resourceName: "heart"), for: .normal)

            
            }
        }
    }
        
        if "lang".localized == "ar" {
            cell.config(familyName: restaurants_list[indexPath.row].nameAr ?? "", time: restaurants_list[indexPath.row].deliveryTime ?? 0 , imagePath: restaurants_list[indexPath.row].image ?? "", productName: restaurants_list[indexPath.row].type ?? "", price: Double(restaurants_list[indexPath.row].deliveryFee ?? 0), rate: Double(restaurants_list[indexPath.row].rate ?? 0))
            return cell
        } else {
            cell.config(familyName: restaurants_list[indexPath.row].nameEn ?? "", time: restaurants_list[indexPath.row].deliveryTime ?? 0 , imagePath: restaurants_list[indexPath.row].image ?? "", productName: restaurants_list[indexPath.row].type ?? "", price: Double(restaurants_list[indexPath.row].deliveryFee ?? 0), rate: Double(restaurants_list[indexPath.row].rate ?? 0))
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
    }
    
    
}
extension ProductiveFamiliesVC: RestaurantsViewDelegate {
    func FavoriteResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                if "lang".localized == "en" {
                    displayMessage(title: "Saved At Favorite List", message: resultMsg.successMessage, status: .success, forController: self)
                }  else {
                        displayMessage(title: "تمت الاضافة الي المفضلة", message: "", status: .success, forController: self)
                }
            } else if resultMsg.item_id != [""] {
                displayMessage(title: "", message: resultMsg.item_id[0], status: .error, forController: self)
            } else if resultMsg.item_type != [""] {
                displayMessage(title: "", message: resultMsg.item_type[0], status: .error, forController: self)
            }
      }
    }
    
    func RemoveFavorite(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                if "lang".localized == "en" {
                        displayMessage(title: "Remove from Favorite List", message: "", status: .success, forController: self)
                } else {
                        displayMessage(title: "تم الحذف من المفضلة", message: "", status: .success, forController: self)
                }
            } else if resultMsg.item_id != [""] {
                displayMessage(title: "", message: resultMsg.item_id[0], status: .error, forController: self)
            } else if resultMsg.item_type != [""] {
                displayMessage(title: "", message: resultMsg.item_type[0], status: .error, forController: self)
            }
        }
    }
    
    
    func getAllRestaurantsResult(_ error: Error?, _ restaurants: [Restaurant]?) {
        if let restaurantList = restaurants {
            self.restaurants_list = restaurantList
            
        }
    }
    
}

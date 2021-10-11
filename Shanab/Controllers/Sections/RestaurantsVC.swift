//
//  RestaurantsVC.swift
//  Shanab
//
//  Created by Macbook on 3/31/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
class RestaurantsVC: UIViewController {
    private let RestaurantsVCPresenter = RestaurantsPresenter(services: Services())
    @IBOutlet weak var search: UISearchBar!
    var type = ["restaurant"]
    fileprivate let cellIdentifier = "ProductiveFamiliesCell"
    @IBOutlet weak var restaurantsTableView: UITableView!
    var restaurant_id = Int()
    var restaurants_list = [Restaurant]() {
        didSet {
            DispatchQueue.main.async {
                self.restaurantsTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantsTableView.delegate = self
        restaurantsTableView.dataSource = self
        restaurantsTableView.tableFooterView = UIView()
        //        restaurantsTableView.rowHeight = UITableView.automaticDimension
        //               restaurantsTableView.estimatedRowHeight = UITableView.automaticDimension
        restaurantsTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        restaurantsTableView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        restaurantsTableView.layer.cornerRadius = 25
        restaurantsTableView.layer.borderWidth = 1
        RestaurantsVCPresenter.setRestaurantsViewDelegate(RestaurantsViewDelegate: self)
        RestaurantsVCPresenter.showIndicator()
        RestaurantsVCPresenter.getAllRestaurants(type: ["restaurant"])
        
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
extension RestaurantsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as?
            ProductiveFamiliesCell else { return UITableViewCell()}
        
        
        cell.addToFavorite = {

        if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
            
            displayMessage(title: "Add favourite".localized, message: "You should login first".localized, status:.warning, forController: self)
        } else {
            
            
            self.RestaurantsVCPresenter.showIndicator()
            self.RestaurantsVCPresenter.postCreateFavorite(item_id: self.restaurants_list[indexPath.row].id ?? 0, item_type: self.restaurants_list[indexPath.row].type ?? "")
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
        150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "RestaurantDetailsVC") as? RestaurantDetailsVC else { return }
        details.restaurant_id = restaurants_list[indexPath.row].id ?? 0
        details.image = restaurants_list[indexPath.row].image ?? ""
        details.name = restaurants_list[indexPath.row].nameEn ?? ""
               if "lang".localized == "en" {
                             details.name = restaurants_list[indexPath.row].nameEn ?? ""
                        } else {
                             details.name = restaurants_list[indexPath.row].nameAr ?? ""
                        }
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    
}
extension RestaurantsVC: RestaurantsViewDelegate {
    func FavoriteResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "Done", message: resultMsg.successMessage, status: .success, forController: self)
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
                displayMessage(title: "Removed", message: resultMsg.successMessage, status: .success, forController: self)
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

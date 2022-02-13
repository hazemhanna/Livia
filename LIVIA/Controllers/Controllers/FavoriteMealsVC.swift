//
//  FavoriteMealsVC.swift
//  Shanab
//
//  Created by Macbook on 7/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class FavoriteMealsVC: UIViewController {
    @IBOutlet weak var favoriteMealsTableView: UITableView!
    fileprivate let cellIdentifier = "FavoriteCell"
    var item_type = "meal"
    var deletedIndex: Int = 0
    private let UserFavoritesMealsVCPresenter = UserFavoritesMealsPresenter(services: Services())
    var ClientFavoriteList = [Favorites]() {
        didSet {
            DispatchQueue.main.async {
                self.favoriteMealsTableView.reloadData()
            }
        }
    }
    var total = Double()
    var cartItems = [onlineCart]()
    var currency = String()
    var meal_id = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteMealsTableView.delegate = self
        favoriteMealsTableView.dataSource = self
        favoriteMealsTableView.tableFooterView = UIView()
        favoriteMealsTableView.rowHeight = UITableView.automaticDimension
        favoriteMealsTableView.estimatedRowHeight = UITableView.automaticDimension
        favoriteMealsTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        UserFavoritesMealsVCPresenter.setFavoriteMealsViewDelegate(FavoriteMealsViewDelegate: self)
        UserFavoritesMealsVCPresenter.showIndicator()
        UserFavoritesMealsVCPresenter.postFavoriteGet(item_type: "meal")
        
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
extension FavoriteMealsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClientFavoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavoriteCell else {return UITableViewCell()}
        let item_type = ClientFavoriteList[indexPath.row].meal ?? Meal()
        cell.AddToCart = {
            self.UserFavoritesMealsVCPresenter.showIndicator()
            self.UserFavoritesMealsVCPresenter.postAddToCart(meal_id: self.ClientFavoriteList[indexPath.row].itemID ?? 0  , quantity: 1 , message:  "test one" , options: [])
        }
        cell.RemoveFromeFavorite = {
            self.deletedIndex = indexPath.row
            self.UserFavoritesMealsVCPresenter.showIndicator()
            self.UserFavoritesMealsVCPresenter.postRemoveFavorite(item_id: self.ClientFavoriteList[indexPath.row].itemID ?? 0, item_type: self.ClientFavoriteList[indexPath.row].itemType ?? "")
        }
        if "lang".localized == "ar" {
            cell.config(name: item_type.nameAr ?? "" , details: item_type.descriptionAr ?? "" , imagePath: item_type.image ?? "", price: item_type.price?[0].price ?? 0.0)
        } else {
            cell.config(name: item_type.nameEn ?? "" , details: item_type.descriptionEn ?? "" , imagePath: item_type.image ?? "", price: item_type.price?[0].price ?? 0.0)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    
}
extension FavoriteMealsVC: FavoriteMealsViewDelegate {
    func RemoveFavorite(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                if "lang".localized == "en" {
                        displayMessage(title: "Remove from Favorite List", message: "", status: .success, forController: self)
                } else {
                        displayMessage(title: "تم الحذف من المفضلة", message: "", status: .success, forController: self)
                }
               
                self.ClientFavoriteList.remove(at: deletedIndex)
            } else if resultMsg.item_id != [""] {
                displayMessage(title: "", message: resultMsg.item_id[0], status: .error, forController: self)
            } else if resultMsg.item_type != [""] {
                displayMessage(title: "", message: resultMsg.item_type[0], status: .error, forController: self)
            }
        }
    }
    
    func AddToCartResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let meals = result {
            if meals.successMessage != "" {
                displayMessage(title: "done", message: meals.successMessage, status: .success, forController: self)
             Singletone.instance.cart = cartItems
            } else if meals.meal_id != [""] {
                displayMessage(title: "", message: meals.meal_id[0], status: .error, forController: self)
            } else if meals.quantity != [""] {
                displayMessage(title: "", message: meals.quantity[0], status: .error, forController: self)
            } else if meals.message != [""] {
                displayMessage(title: "", message: meals.message[0], status: .error, forController: self)
            } else if meals.options != [""] {
                displayMessage(title: "", message: meals.options[0], status: .error, forController: self)
            }
        }
    }
    
    func UserFavoriteMealssResult(_ error: Error?, _ favoriteList: [Favorites]?) {
        if let lists = favoriteList{
            self.ClientFavoriteList = lists
            
        }
    }
    
    
    
    
}

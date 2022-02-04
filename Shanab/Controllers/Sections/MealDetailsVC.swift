//
//  MealDetailsVC.swift
//  Shanab
//
//  Created by Macbook on 7/2/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import ImageSlideshow
class MealDetailsVC: UIViewController {
    
    @IBOutlet weak var MealDetailsTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    private let TableCellIdentifier = "BestSellerCell"
    private let CollectinCellIdentifier = "RestaurantDetailsCell"
    private let MealsDetailVCPresenter = MealsDetailPresenter(services: Services())
    var categoriesArr = [Category]()
    var mealId = Int()
    var category_id = Int()
    var image = String()
    var Name = String()
    var cartItems = [onlineCart]()
    var meals = [sectionMeal]() {
        didSet {
            DispatchQueue.main.async {
                self.MealDetailsTableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MealDetailsTableView.delegate = self
        MealDetailsTableView.dataSource = self
        MealDetailsTableView.tableFooterView = UIView()
        MealDetailsTableView.rowHeight = UITableView.automaticDimension
        MealDetailsTableView.estimatedRowHeight = UITableView.automaticDimension
        MealDetailsTableView.register(UINib(nibName: TableCellIdentifier, bundle: nil), forCellReuseIdentifier: TableCellIdentifier)
        MealDetailsTableView.rowHeight = UITableView.automaticDimension
        MealDetailsTableView.estimatedRowHeight = UITableView.automaticDimension
        
        
        MealsDetailVCPresenter.setMealsDetailsViewDelegate(MealsDetailsViewDelegate: self)
        MealsDetailVCPresenter.showIndicator()
        MealsDetailVCPresenter.getSectionDetails(category_id: category_id)
        
    }
    
    
    @IBAction func reservationTablr(_ sender: UIButton) {
    }
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func cartItems(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
//        guard let window = UIApplication.shared.keyWindow else { return }
//
//        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
//
//        details.selectedIndex = 2
//        window.rootViewController = details
    }
}
extension MealDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifier, for: indexPath) as? BestSellerCell else {return UITableViewCell()}
        
        if Helper.getApiToken() != "" || Helper.getApiToken() != nil {

        
            if meals[indexPath.row].favorite?.count == 0 {
                
                cell.FavoriteBN.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
                cell.isFavourite = false
            } else {
                
                
                cell.FavoriteBN.setImage(#imageLiteral(resourceName: "heart 2-1"), for: .normal)
                cell.isFavourite = true


            }
        }
        
        cell.goToFavorites = {
            
            if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
                
                displayMessage(title: "Add favourite".localized, message: "You should login first".localized, status:.warning, forController: self)
            } else {
                
                self.MealsDetailVCPresenter.showIndicator()
                
                if !cell.isFavourite {
                    
                    cell.FavoriteBN.setImage(#imageLiteral(resourceName: "heart 2-1"), for: .normal)

                    self.MealsDetailVCPresenter.postCreateFavorite(item_id: self.meals[indexPath.row].id ?? 0, item_type: "meal")

                    
                } else {
                    cell.FavoriteBN.setImage(#imageLiteral(resourceName: "heart"), for: .normal)

                    self.MealsDetailVCPresenter.postRemoveFavorite(item_id: self.meals[indexPath.row].id ?? 0, item_type: "meal")
                }
                
              
            }
                
                
                      }
        cell.addToCart = {
            
            
            if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
                
                displayMessage(title: "".localized, message: "You should login first".localized, status:.warning, forController: self)
            } else {
                cell.AddToCartBtn.setImage(#imageLiteral(resourceName: "cart (1)"), for: .normal)
                self.MealsDetailVCPresenter.showIndicator()
                self.MealsDetailVCPresenter.postAddToCart(meal_id: self.meals[indexPath.row].id ?? 0  , quantity: 1 , message:  "test one" , options: [])

            }
            
        }
        
        
        if "lang".localized == "ar" {
            cell.config(imagePath: meals[indexPath.row].image ?? "", name: meals[indexPath.row].nameAr ?? "",  mealComponants: meals[indexPath.row].descriptionAr ?? "", price: Double(meals[indexPath.row].price?[0].price?.rounded(toPlaces: 2) ?? 0.0), discount: Double(meals[indexPath.row].discount ?? 0))
            return cell
        } else {
            cell.config(imagePath: meals[indexPath.row].image ?? "", name: meals[indexPath.row].nameEn ?? "",  mealComponants: meals[indexPath.row].descriptionEn ?? "", price: Double(meals[indexPath.row].price?[0].price?.rounded(toPlaces: 2) ?? 0), discount: Double(meals[indexPath.row].discount ?? 0))
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Orders", bundle: nil).instantiateViewController(withIdentifier: "AdditionsVC") as? AdditionsVC else { return }
        
        details.meal_id =  self.meals[indexPath.row].id ?? 0
        details.imagePath = self.meals[indexPath.row].image ?? ""
        details.mealCalory = self.meals[indexPath.row].calories ?? ""
        if "lang".localized == "en" {
            details.mealName = self.meals[indexPath.row].nameEn ?? ""
            details.mealComponents = self.meals[indexPath.row].descriptionEn ?? ""
        } else {
            details.mealName = self.meals[indexPath.row].nameAr ?? ""
            details.mealComponents = self.meals[indexPath.row].descriptionAr ?? ""
        }
        
        self.navigationController?.pushViewController(details, animated: true)
    }
}


extension MealDetailsVC: MealsDetailsViewDelegate {
    func RestaurantMealsResult(_ error: Error?, _ meals: [RestaurantMeal]?) {
        //        if let restaurantMeals = meals {
        //            self.meals = restaurantMeals
        //            if self.meals.count == 0 {
        //                self.emptyView.isHidden = false
        //                self.MealDetailsTableView.isHidden = true
        //            } else {
        //                self.emptyView.isHidden = true
        //                self.MealDetailsTableView.isHidden = false
        //            }
        //
        //        }
        
    }
    
    func CatgeoriesResult(_ error: Error?, _ catgeory: [Category]?) {
        if let catgeoryList = catgeory {
            self.categoriesArr = catgeoryList
        }
    }
    
    func SectionDetails(_ error: Error?, _ result: [sectionMeal]?) {
        if let restaurantMeals = result {
            self.meals = restaurantMeals
            if self.meals.count == 0 {
                self.emptyView.isHidden = false
                self.MealDetailsTableView.isHidden = true
            } else {
                self.emptyView.isHidden = true
                self.MealDetailsTableView.isHidden = false
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
            }else{
                if "lang".localized == "en" {
                displayMessage(title: "", message: "Please Make Your Cart Including Only One Restaurant", status: .error, forController: self)
                }else{
                displayMessage(title: "", message: " يرجى جعل عربة التسوق الخاصة بك تشمل مطعم واحد فقط ", status: .error, forController: self)
                }
            }
        }
    }
    
    func RestaurantDetailsResult(_ error: Error?, _ details: RestaurantDetail?) {
        
    }
    
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
}

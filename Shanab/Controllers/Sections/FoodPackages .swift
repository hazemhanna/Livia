//
//  FoodPackages .swift
//  Shanab
//
//  Created by MAC on 08/10/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//

import Foundation
import UIKit
import ImageSlideshow

class FoodPackages  : UIViewController {
    
    private let vCPresenter = FoodPackegesPresenter(services: Services())
    
    @IBOutlet weak var MealDetailsTableView: UITableView!
    @IBOutlet weak var deliveryDetailsView : UIView!
    @IBOutlet weak var deliveryPriceLbl  : UILabel!
    @IBOutlet weak var deliverytitleLbl  : UILabel!

    @IBOutlet weak var acceptBtn  : UIButton!
    @IBOutlet weak var refuseBtn  : UIButton!

    
    private let TableCellIdentifier = "FoodPackgeCell"
    @IBOutlet weak var titleLbl: UILabel!

    var foodSubscription  = [FoodSubscription]() {
        didSet {
            DispatchQueue.main.async {
                self.MealDetailsTableView.reloadData()
            }
        }
    }
    
    var restaurant_id = Int()
    var food_subscription_id = Int()
    var has_delivery_subscription = Int()
    var delivery_price = Int()
    var food_price = Int()
    var total = Int()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MealDetailsTableView.delegate = self
        MealDetailsTableView.dataSource = self
        MealDetailsTableView.estimatedRowHeight = UITableView.automaticDimension
        MealDetailsTableView.register(UINib(nibName: TableCellIdentifier, bundle: nil), forCellReuseIdentifier: TableCellIdentifier)
        titleLbl.text = "foodPackages".localized
        vCPresenter.showIndicator()
        vCPresenter.setsubscribtionViewDelegate(subscribtionsViewDelegate: self)
        vCPresenter.getFoodSubscription(restaurant_id: restaurant_id)
        

        acceptBtn.setTitle("Accept".localized, for: .normal)
        refuseBtn.setTitle("refuse".localized, for: .normal)
        deliverytitleLbl.text = "delivery".localized
    }
    
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func cartItems(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func acceptBtn (_ sender: Any) {
        if Helper.getApiToken() == nil {
            let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "LoginPopupVC")
            sb.modalPresentationStyle = .overCurrentContext
            sb.modalTransitionStyle = .crossDissolve
            self.present(sb, animated: true, completion: nil)
        }else{
        vCPresenter.showIndicator()
        vCPresenter.addFoodSubToCart(restaurant_id: restaurant_id, food_subscription_id: food_subscription_id, has_delivery_subscription: 1, delivery_price: delivery_price, food_price: food_price, total: total)
        }
    }
    
    @IBAction func refuseBtn (_ sender: Any) {
        deliveryDetailsView.isHidden = true
    }
    
}

extension FoodPackages : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foodSubscription.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifier, for: indexPath) as? FoodPackgeCell else {return UITableViewCell()}
        
        if "lang".localized == "ar" {
            cell.config(imagePath: foodSubscription[indexPath.row].image ?? "" , desc: foodSubscription[indexPath.row].descriptionAr ?? "", deliveryprice: Double(foodSubscription[indexPath.row].subscription?.price ?? 0), pakageTime: foodSubscription[indexPath.row].subscription?.titleAr ?? "", pakageName: foodSubscription[indexPath.row].titleAr ?? "" , PackagePrice: foodSubscription[indexPath.row].price ?? 0 )
        } else {
            cell.config(imagePath: foodSubscription[indexPath.row].image ?? "" , desc: foodSubscription[indexPath.row].descriptionEn ?? "", deliveryprice: Double(foodSubscription[indexPath.row].subscription?.price ?? 0), pakageTime: foodSubscription[indexPath.row].subscription?.titleEn ?? "", pakageName: foodSubscription[indexPath.row].titleEn ?? "" , PackagePrice: foodSubscription[indexPath.row].price ?? 0 )

        }
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deliveryDetailsView.isHidden = false
        
        self.food_subscription_id = foodSubscription[indexPath.row].id ?? 0
        self.delivery_price = foodSubscription[indexPath.row].subscription?.price ?? 0
        self.food_price = foodSubscription[indexPath.row].price ?? 0
        self.total = (foodSubscription[indexPath.row].subscription?.price ?? 0) + (foodSubscription[indexPath.row].price ?? 0)
        
        if "lang".localized == "ar" {
            deliveryPriceLbl.text = "قيمة اشتراك التوصيل \( foodSubscription[indexPath.row].subscription?.price ?? 0 )  ريال سعودي"
        }else{
            deliveryPriceLbl.text = "delivery subscribtion Fee \( foodSubscription[indexPath.row].subscription?.price ?? 0 ) SAR"

        }
    }
    
}

extension FoodPackages : FoodPackegesViewDelegate {
    
    func addFoodSubToCart(_ error: Error?, _ result: AddFoodPackegeToCart?, message : String?) {
        if result != nil {
        guard let sb = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "MYFoodPackagesCartVC") as? MYFoodPackagesCartVC else {return}
            self.navigationController?.pushViewController(sb, animated: true)
            
        }else if let message = message{
            vCPresenter.dismissIndicator()
            displayMessage(title: "", message: message, status: .error, forController: self)
        }
    }
    
    func getFoodSubscription(_ error: Error?, _ result: [FoodSubscription]?) {
            if let sub = result {
            self.foodSubscription = sub
            }
    }
    
    
    func getMyFoodSub(_ error: Error?, _ result: [MyFoodSubscribtion]?) {
        
    }
    
}

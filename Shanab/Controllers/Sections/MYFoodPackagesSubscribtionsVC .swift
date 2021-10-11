//
//  MYFoodPackagesSubscribtionsVC .swift
//  Shanab
//
//  Created by MAC on 09/10/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//



import Foundation
import UIKit
import ImageSlideshow

class MYFoodPackagesSubscribtionsVC : UIViewController {
    
    private let vCPresenter = FoodPackegesPresenter(services: Services())
    
    @IBOutlet weak var MealDetailsTableView: UITableView!
    
    private let TableCellIdentifier = "FoodPackgeCell"
    @IBOutlet weak var titleLbl: UILabel!

    var foodSubscription  = [MyFoodSubscribtion]() {
        didSet {
            DispatchQueue.main.async {
                self.MealDetailsTableView.reloadData()
            }
        }
    }
    var restaurant_id = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MealDetailsTableView.delegate = self
        MealDetailsTableView.dataSource = self
        MealDetailsTableView.estimatedRowHeight = UITableView.automaticDimension
        MealDetailsTableView.register(UINib(nibName: TableCellIdentifier, bundle: nil), forCellReuseIdentifier: TableCellIdentifier)
        titleLbl.text = "foodPackagesSub".localized
        vCPresenter.showIndicator()
        vCPresenter.setsubscribtionViewDelegate(subscribtionsViewDelegate: self)
        vCPresenter.getMyFoodSubscription()
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func cartItems(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension MYFoodPackagesSubscribtionsVC  : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foodSubscription.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifier, for: indexPath) as? FoodPackgeCell else {return UITableViewCell()}
        
        if "lang".localized == "ar" {
            cell.config(imagePath: foodSubscription[indexPath.row].restaurant?.image ?? "" , desc: foodSubscription[indexPath.row].foodSubscription?.descriptionAr ?? "", deliveryprice: Double(foodSubscription[indexPath.row].foodSubscription?.subscription?.price ?? 0), pakageTime: foodSubscription[indexPath.row].foodSubscription?.subscription?.titleAr ?? "", pakageName: foodSubscription[indexPath.row].foodSubscription?.titleAr ?? "" , PackagePrice: foodSubscription[indexPath.row].foodSubscription?.price ?? 0 )
        } else {
            cell.config(imagePath: foodSubscription[indexPath.row].restaurant?.image ?? "" , desc: foodSubscription[indexPath.row].foodSubscription?.descriptionEn ?? "", deliveryprice: Double(foodSubscription[indexPath.row].foodSubscription?.subscription?.price ?? 0), pakageTime: foodSubscription[indexPath.row].foodSubscription?.subscription?.titleEn ?? "", pakageName: foodSubscription[indexPath.row].foodSubscription?.titleEn ?? "" , PackagePrice: foodSubscription[indexPath.row].foodSubscription?.price ?? 0 )

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension MYFoodPackagesSubscribtionsVC  : FoodPackegesViewDelegate {
    func addFoodSubToCart(_ error: Error?, _ result: AddFoodPackegeToCart?,message : String?) {
       
        
    }
    
    func getFoodSubscription(_ error: Error?, _ result: [FoodSubscription]?) {
            
        
    }
    
    func getMyFoodSub(_ error: Error?, _ result: [MyFoodSubscribtion]?) {
            if let sub = result {
            self.foodSubscription = sub
            }
    }
    
    
}

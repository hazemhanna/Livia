//
//  MYFoodPackagesCartVC.swift
//  Livia
//
//  Created by MAC on 27/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import Foundation
import UIKit
import ImageSlideshow


class MYFoodPackagesCartVC  : UIViewController {
    
    @IBOutlet weak var MealDetailsTableView: UITableView!
    private let TableCellIdentifier = "MyFoodCartCell"
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var empyView : UIView!


    
    
    var fees = Double()
    var restaurant_id = Int()
    var food_subscription_id = Int()
    var delivery_price = Int()
    var food_price = Double()
    var total = Int()

    
    var meals = [RestaurantMeal]() {
        didSet{
            DispatchQueue.main.async {
                self.MealDetailsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MealDetailsTableView.delegate = self
        MealDetailsTableView.dataSource = self
        MealDetailsTableView.estimatedRowHeight = UITableView.automaticDimension
        MealDetailsTableView.register(UINib(nibName: TableCellIdentifier, bundle: nil), forCellReuseIdentifier: TableCellIdentifier)
        titleLbl.text = "FoodCart".localized

        meals.append(RestaurantMeal(nameAr: "بيتزا سي فود", image: #imageLiteral(resourceName: "food-1"), descriptionAr: "بيتزا"))

    }
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func cartItems(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func show () {
        if meals.count > 0 {
            MealDetailsTableView.isHidden = false
            self.empyView.isHidden = true
        }else{
            MealDetailsTableView.isHidden = true
            self.empyView.isHidden = false
        }
    }
    
    
    

}

extension MYFoodPackagesCartVC   : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifier, for: indexPath) as? MyFoodCartCell else {return UITableViewCell()}
        
        cell.confirm = {
            let alert = UIAlertController(title: "تاكيد", message: "هل انت متاكد من عملية الشراء", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "نعم", style: UIAlertAction.Style.default, handler: { action in
                          self.meals.remove(at: indexPath.row)
                           self.show() }))
                alert.addAction(UIAlertAction(title: "لا", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            
       }
        
        
        cell.delete = {
            let alert = UIAlertController(title: "تاكيد", message: "هل انت متاكد من عملية الحذف", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "نعم", style: UIAlertAction.Style.default, handler: { action in
                          self.meals.remove(at: indexPath.row)
                           self.show() }))
                alert.addAction(UIAlertAction(title: "لا", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
        
     return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

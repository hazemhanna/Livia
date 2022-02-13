//
//  CartDetailsVC.swift
//  Shanab
//
//  Created by Macbook on 28/07/2020.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
class CartDetailsVC: UIViewController {
    @IBOutlet weak var quantityLB: UILabel!
    @IBOutlet weak var mealComponents: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var additionsLB: UILabel!
    @IBOutlet weak var mealPriceLB: CustomLabel!
    @IBOutlet weak var notes: CustomTextField!
    @IBOutlet weak var mealNameLB: UILabel!
    
    @IBOutlet weak var Restaurant: UILabel!
    
    
    
    var productCounter = 1
    var mealId = Int()
    var mealName = String()
    var imagePath = String()
    var components = String()
    var caloriesNamber = String()
    var quantity = Int()
    var Addition = String()
    var price = Int()
    var details = onlineCart()
    private let CartDetailsVCPresenter = CartDetailsPresenter(services: Services())
    override func viewDidLoad() {
        super.viewDidLoad()
        calories.text = details.meal?.calories
        quantityLB.text = "\(details.quantity ?? 0)"
        var Additional = ""
        for i in details.optionsContainer! {
            
                        
            if "lang".localized == "ar" {

                Additional = Additional + (i.options?.nameAr ?? "")
                Additional = Additional + " : " + "\(i.quantity ?? 0)" + " "
                
            } else {
                 
                Additional = Additional + (i.options?.nameEn ?? "")
                Additional = Additional + " : " + "\(i.quantity ?? 0)" + " "

            }
        }

        additionsLB.text = Additional
        if "lang".localized == "ar" {
             mealPriceLB.text = "\(price) ريال"
            mealComponents.text = details.meal?.descriptionAr
            mealNameLB.text = details.meal?.nameAr
            Restaurant.text = details.meal?.restaurantNameAr


        } else {
             mealPriceLB.text = "\(price) SAR"
            mealComponents.text = details.meal?.descriptionEn
            mealNameLB.text = details.meal?.nameEn
            Restaurant.text = details.meal?.restaurantNameEn

        }
        
        
        print(Restaurant.text)
        notes.text = details.message
        let image = details.meal?.image
        
        if (!(image?.contains("http"))!) {
            guard let imageURL = URL(string: (BASE_URL + "/" + (image ?? "")).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
            print(imageURL)
            self.mealImage.kf.setImage(with: imageURL)
        }  else if image != "" {
            guard let imageURL = URL(string: image ?? "") else { return }
            self.mealImage.kf.setImage(with: imageURL)
        } else {
            self.mealImage.image = #imageLiteral(resourceName: "shanab loading")
        }
        
//        if details.meal?.image != "" {
//            guard let imageURL = URL(string: details.meal?.image ?? "") else { return }
//            self.mealImage.kf.setImage(with: imageURL)
//        } else {
//            self.mealImage.image = #imageLiteral(resourceName: "shanab loading")
//        }
        CartDetailsVCPresenter.setCartDetailsViewDelegate(CartDetailsViewDelegate: self)
        
    }
    
    @IBAction func SideMenu(_ sender: Any) {
        
        
        setupSideMenu()
    }
    
    @IBAction func Back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    @IBAction func CartList(_ sender: Any) {
        guard let window = UIApplication.shared.keyWindow else { return }

        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
        
        details.selectedIndex = 2
        window.rootViewController = details
    }
    @IBAction func decreases(_ sender: UIButton) {
        if productCounter > 1 {
            self.productCounter -= 1
            self.quantityLB.text = "\(self.productCounter)"
        } else {
            self.productCounter = 1
            self.quantityLB.text = "\(self.productCounter)"
        }
    }
    
    @IBAction func AddToCart(_ sender: Any) {
        CartDetailsVCPresenter.showIndicator()
        CartDetailsVCPresenter.postAddToCart(meal_id: details.meal?.id ?? 0, quantity : productCounter , message: notes.text ?? "" , options: [])
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    @IBAction func increase(_ sender: UIButton) {
        self.productCounter += 1
        self.quantityLB.text = "\(self.productCounter)"
    }
    @IBAction func AdditionsButtonPressed(_ sender: UIButton) {
   
    }
}
extension CartDetailsVC: CartDetailsViewDelegate {
    func AddToCartResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let meals = result {
            if meals.successMessage != "" {
                displayMessage(title: "Success", message: meals.successMessage, status: .success, forController: self)
                guard let details = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "MyAddressesVC") as? MyAddressesVC else { return }
                self.navigationController?.pushViewController(details, animated: true)
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
    
    
}

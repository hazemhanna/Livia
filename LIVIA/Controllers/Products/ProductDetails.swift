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
    
    @IBOutlet weak var quantityTF: UILabel!
    @IBOutlet weak var stackViewST: UIStackView!
    @IBOutlet weak var mealNameLB: UILabel!
    @IBOutlet weak var notesTF: UITextField!
    @IBOutlet weak var oneImageView: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var RestaurantName: UILabel!
    @IBOutlet weak var FavoriteBN : UIButton!
    @IBOutlet weak var smallBtN : UIButton!
    @IBOutlet weak var midumBtN : UIButton!
    @IBOutlet weak var largeBtN : UIButton!
    @IBOutlet weak var OptionTableHeight: NSLayoutConstraint!

    var isFavourite = Bool()
    var meals : RestaurantMeal?
    fileprivate let cellIdentifier = "AdditionsCell"
    fileprivate let HeaderIdentifier = "HeaderCell"
    var restaurant_id = Int()
    var productCounter = Int()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealNameLB.text = meals?.nameAr
       // RestaurantName.text = meals?.descriptionAr
        oneImageView.image = meals?.image
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
    

    @IBAction func yesBtn(_ sender: UIButton) {
       if sender.tag == 0 {
           smallBtN.setImage(#imageLiteral(resourceName: "select"), for: .normal)
           midumBtN.setImage(#imageLiteral(resourceName: "check"), for: .normal)
           largeBtN.setImage(#imageLiteral(resourceName: "check"), for: .normal)

       }else if sender.tag == 1{
           smallBtN.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            midumBtN.setImage(#imageLiteral(resourceName: "select"), for: .normal)
            largeBtN.setImage(#imageLiteral(resourceName: "check"), for: .normal)

        }else{
            smallBtN.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            midumBtN.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            largeBtN.setImage(#imageLiteral(resourceName: "select"), for: .normal)
        }
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        
//        if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
//
//            displayMessage(title: "", message: "You should login first".localized, status:.warning, forController: self)
//        } else {
//
//
//        }
        displayMessage(title: "", message: "تم الاضافة الي السلة بنجاح".localized, status:.success, forController: self)
    }
    
    
    @IBAction func favourit(_ sender: UIButton) {
        
//        if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
//            displayMessage(title: "", message: "You should login first".localized, status:.warning, forController: self)
//        } else {
        

            if isFavourite{
                FavoriteBN.setImage(UIImage(named: "heart"), for: .normal)
                isFavourite = false
                displayMessage(title: "", message: "تم المسح من المفضلة بنجاح".localized, status:.success, forController: self)

            }else{
                FavoriteBN.setImage(UIImage(named: "222"), for: .normal)
                isFavourite = true
                displayMessage(title: "", message: "تم الاضافة الي المفضلة بنجاح".localized, status:.success, forController: self)

            }
            
        //}
    }
    
}

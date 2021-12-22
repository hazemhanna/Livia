//
//  MySubscribtionVc.swift
//  Shanab
//
//  Created by MAC on 27/08/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//


import UIKit
import ImageSlideshow

class MySubscribtionVc : UIViewController {
    
    private let SubscribtionsVCPresenter = MySubscribtionsPresenter(services: Services())
    
    @IBOutlet weak var MealDetailsTableView: UITableView!
    private let TableCellIdentifier = "MySbuscribtionsCell"
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var empyView : UIView!

    var subscription  = [SubscriptionElement]() {
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
        MealDetailsTableView.estimatedRowHeight = UITableView.automaticDimension
        MealDetailsTableView.register(UINib(nibName: TableCellIdentifier, bundle: nil), forCellReuseIdentifier: TableCellIdentifier)
        titleLbl.text = "subscriptions".localized
        SubscribtionsVCPresenter.showIndicator()
        SubscribtionsVCPresenter.setsubscribtionViewDelegate(subscribtionsViewDelegate: self)
        SubscribtionsVCPresenter.getSubscribtions()
    }
    
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func cartItems(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension MySubscribtionVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subscription.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifier, for: indexPath) as? MySbuscribtionsCell else {return UITableViewCell()}
        
        if Helper.getApiToken() != "" || Helper.getApiToken() != nil {
            if self.subscription[indexPath.row].restaurant?.favorite == nil {
                cell.favouritBtn.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
                cell.isFavourite = false
            } else {
                cell.favouritBtn.setImage(#imageLiteral(resourceName: "heart 2-1"), for: .normal)
                cell.isFavourite = true
            }
        }
        
        cell.goToFavorites = {
            if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
                displayMessage(title: "Add favourite".localized, message: "You should login first".localized, status:.warning, forController: self)
            } else {
                self.SubscribtionsVCPresenter.showIndicator()
                if cell.isFavourite {
                    cell.favouritBtn.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
                    self.SubscribtionsVCPresenter.postRemoveFavorite(item_id: self.subscription[indexPath.row].restaurant?.id ?? 0, item_type: self.subscription[indexPath.row].restaurant?.type ??  "")
                    cell.isFavourite = false
                } else {
                    cell.favouritBtn.setImage(#imageLiteral(resourceName: "heart 2-1"), for: .normal)
                    self.SubscribtionsVCPresenter.postCreateFavorite(item_id: self.subscription[indexPath.row].restaurant?.id ?? 0, item_type: self.subscription[indexPath.row].restaurant?.type ??  "")
                    cell.isFavourite = true

                }
            }
        }
        
        if "lang".localized == "ar" {
            cell.config(familyName: subscription[indexPath.row].restaurant?.nameAr ?? ""
                        , time: subscription[indexPath.row].subscription?.createdAt ?? ""
                        , productName: subscription[indexPath.row].restaurant?.type?.localized ?? ""
                        , minimum: subscription[indexPath.row].restaurant?.minimum ?? 0
                        , rate: String(subscription[indexPath.row].restaurant?.rate ?? 0)
                        ,pakage: subscription[indexPath.row].subscription?.titleAr ?? ""
                        , PackagePrice: subscription[indexPath.row].subscription?.price ?? 0
                        ,Valid : subscription[indexPath.row].subscription?.available_to ?? "")
        } else {
            cell.config(familyName: subscription[indexPath.row].restaurant?.nameEn ?? ""
                        , time: subscription[indexPath.row].subscription?.createdAt ?? ""
                        , productName: subscription[indexPath.row].restaurant?.type?.localized ?? ""
                        , minimum: subscription[indexPath.row].restaurant?.minimum ?? 0
                        , rate: String(subscription[indexPath.row].restaurant?.rate ?? 0)
                        ,pakage: subscription[indexPath.row].subscription?.titleEn ?? ""
                        , PackagePrice: subscription[indexPath.row].subscription?.price ?? 0
                        ,Valid:subscription[indexPath.row].subscription?.available_to ?? "")
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.MealDetailsTableView.reloadData()
    }
    
}


extension MySubscribtionVc: MySubscribtionsViewDelegate {
    func mySubscribtions(_ error: Error?, _ result: [SubscriptionElement]?) {
        if let sub = result {
            self.subscription = sub
        }
        
        if subscription.count > 0 {
            empyView.isHidden = true
        }else{
            empyView.isHidden = false
        }
        
    }
    
    
    func FavoriteResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                if "lang".localized == "en" {
                    displayMessage(title: "Saved At Favorite List", message: resultMsg.successMessage, status: .success, forController: self)
                }  else {
                        displayMessage(title: "تمت الاضافة الي المفضلة", message: "", status: .success, forController: self)
                }
                
                SubscribtionsVCPresenter.showIndicator()
                SubscribtionsVCPresenter.setsubscribtionViewDelegate(subscribtionsViewDelegate: self)
                SubscribtionsVCPresenter.getSubscribtions()
                
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
                
                SubscribtionsVCPresenter.showIndicator()
                SubscribtionsVCPresenter.setsubscribtionViewDelegate(subscribtionsViewDelegate: self)
                SubscribtionsVCPresenter.getSubscribtions()

            } else if resultMsg.item_id != [""] {
                displayMessage(title: "", message: resultMsg.item_id[0], status: .error, forController: self)
            } else if resultMsg.item_type != [""] {
                displayMessage(title: "", message: resultMsg.item_type[0], status: .error, forController: self)
            }
        }
    }

}

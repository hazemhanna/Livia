//
//  SideMenuVC.swift
//  Shanab
//
//  Created by Macbook on 3/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var SideMenuTableView: UITableView!
    @IBOutlet weak var logoImage : UIImageView!
    @IBOutlet weak var uploadedImage: UIImageView!

    fileprivate let cellIdentifier = "SideMenuCell"
    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    
    var sideMenuArr = [SideMenuModel]() {
        didSet {
            DispatchQueue.main.async {
                self.SideMenuTableView.reloadData()
            }
        }
    }
    
    let token = Helper.getApiToken() ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SideMenuTableView.dataSource = self
        SideMenuTableView.delegate = self
        SideMenuTableView.rowHeight = UITableView.automaticDimension
        SideMenuTableView.estimatedRowHeight = UITableView.automaticDimension
        SideMenuTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
      if token != "" {
        AuthViewModel.showIndicator()
        getProfile()
          logoImage.isHidden = true
          uploadedImage.isHidden = false
      }else{
          logoImage.isHidden = false
          uploadedImage.isHidden = true

      }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if token != "" {
           // walletView.isHidden = false
             self.sideMenuArr = [
            SideMenuModel(name: "Home".localized,id: "home", selected: false,sideImage: #imageLiteral(resourceName: "Group 493")),
            SideMenuModel(name: "Profile".localized, id: "Profile", selected: false,sideImage: #imageLiteral(resourceName: "ic_assignment_ind_24px-1")),
            SideMenuModel(name: "Sections".localized, id: "Sections", selected: false, sideImage: #imageLiteral(resourceName: "burger")),
            SideMenuModel(name: "Cart".localized, id: "Cart", selected: false,sideImage: #imageLiteral(resourceName: "Ellipse 333")),
            SideMenuModel(name: "Reserve Table".localized, id: "ReserveTable", selected: false, sideImage: #imageLiteral(resourceName: "reservation2")),
           // SideMenuModel(name: "Notifications".localized, id: "Notifications", selected: false, sideImage: #imageLiteral(resourceName: "icons8-notification")),
            SideMenuModel(name: "Reservations".localized, id: "Reservations", selected: false, sideImage: #imageLiteral(resourceName: "reservation2")),
            SideMenuModel(name: "Order List".localized, id: "OrderList", selected: false, sideImage: #imageLiteral(resourceName: "order-food-1")),
            //SideMenuModel(name: "subscriptions".localized, id: "subscriptions", selected: false, sideImage: #imageLiteral(resourceName: "NoPath - Copy (10)")),
            //SideMenuModel(name: "foodPackages".localized, id: "foodPackages", selected: false, sideImage: #imageLiteral(resourceName: "NoPath - Copy (10)")),
           // SideMenuModel(name: "FoodCart".localized, id: "FoodCart", selected: false,sideImage: #imageLiteral(resourceName: "cart (1)-1")),
            SideMenuModel(name: "Favorite Meals".localized, id: "FavoriteMeals", selected: false, sideImage: #imageLiteral(resourceName: "favorite (1)")),
            SideMenuModel(name: "Contact Us".localized, id: "Contact Us", selected: false,sideImage: #imageLiteral(resourceName: "contactUs")),
            SideMenuModel(name: "Terms And Conditions".localized, id: "TermsAndConditions", selected: false, sideImage: #imageLiteral(resourceName: "terms")),
            SideMenuModel(name: "Settings".localized, id: "Setting", selected: false, sideImage: #imageLiteral(resourceName: "Screen Shot 2021-12-31 at 6.42.33 PM")),
            SideMenuModel(name: "logOut".localized, id: "logOut", selected: false, sideImage: #imageLiteral(resourceName: "Screen Shot 2021-12-31 at 6.42.33 PM"))]
            } else {
                //walletView.isHidden = true

            self.sideMenuArr = [
             SideMenuModel(name: "Home".localized, id: "home", selected: false, sideImage: #imageLiteral(resourceName: "Group 6")),
            // SideMenuModel(name: "Contact Us".localized, id: "Contact Us", selected: false,sideImage: #imageLiteral(resourceName: "cridateCard")),
             
             SideMenuModel(name: "Terms And Conditions".localized, id: "TermsAndConditions" , selected: false, sideImage: #imageLiteral(resourceName: "terms")),
             SideMenuModel(name: "Settings".localized, id: "Setting", selected: false, sideImage: #imageLiteral(resourceName: "Screen Shot 2021-12-31 at 6.42.33 PM")),
             SideMenuModel(name: "login".localized, id: "login", selected: false, sideImage: #imageLiteral(resourceName: "Screen Shot 2021-12-31 at 6.42.33 PM"))]
                
        }
        
    }
    
    func selectedCell(indexPath: IndexPath) {
        switch sideMenuArr[indexPath.row].sideMenuId {
        case "home":
            guard let window = UIApplication.shared.keyWindow else { return }
            let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
            sb.selectedIndex = 0
            window.rootViewController = sb
            UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
        case "Sections":
            pushSideMenu(StoryboardName: "Orders", ForController: "SectionsPageVC")
        case "Cart":
            pushSideMenu(StoryboardName: "Cart", ForController: "CartVC")
        case "OrderList":
            pushSideMenu(StoryboardName: "Orders", ForController: "OrderListVC")
        case "Profile":
            pushSideMenu(StoryboardName: "Profile", ForController: "MainProfileVC")
        case "foodPackages":
            pushSideMenu(StoryboardName: "Products", ForController: "FoodPackagesVC")
        case "FoodCart":
            pushSideMenu(StoryboardName: "Products",ForController: "MYFoodPackagesCartVC")
        case "subscriptions":
            pushSideMenu(StoryboardName: "Products", ForController: "SubscriptionsVc")
        case "Reservations":
            pushSideMenu(StoryboardName: "Reservation", ForController: "MyReservationsVC")
        case "FavoriteMeals":
            pushSideMenu(StoryboardName: "Orders", ForController: "FavoriteMealsVC")
        case "Contact Us":
            pushSideMenu(StoryboardName: "AboutApp", ForController: "ContactUsVC")
        case "TermsAndConditions":
            pushSideMenu(StoryboardName: "AboutApp", ForController: "TermsAndConditionsVC")
        case "Setting":
            pushSideMenu(StoryboardName: "AboutApp", ForController: "SettingVC")
        case "Notifications":
            pushSideMenu(StoryboardName: "Profile", ForController: "NotificationsVC")
        case "ReserveTable":
            pushSideMenu(StoryboardName: "Reservation", ForController: "ReservationRequestVc")
        case "logOut":
            pushSideMenu(StoryboardName: "Authentications", ForController: "LoginVC")
            Helper.LogOutUser()
        case "login":
            pushSideMenu(StoryboardName: "Authentications", ForController: "LoginVC")
        default:
            break
        }
    }
    
    func pushSideMenu(StoryboardName name: String,ForController identifier: String) {
        let main = UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
        self.navigationController!.pushViewController(main, animated: true)
    }
    
}
extension SideMenuVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SideMenuCell else {return UITableViewCell()}

        cell.config(name: sideMenuArr[indexPath.row].sideMenuName, selected: sideMenuArr[indexPath.row].sideMenuSelected)
        cell.selectedBackgroundView?.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<sideMenuArr.count {
            if i == indexPath.row {
                sideMenuArr[i].sideMenuSelected = true
            } else {
                sideMenuArr[i].sideMenuSelected = false
            }
        }
        SideMenuTableView.reloadData()
        selectedCell(indexPath: indexPath)
    }
}

extension SideMenuVC {
    func getProfile() {
        self.AuthViewModel.getProfile().subscribe(onNext: { (data) in
            self.AuthViewModel.dismissIndicator()
            self.name.text = data.data?.name ?? ""
            guard let imageURL = URL(string: (data.data?.avatar ?? "" ).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
              self.uploadedImage.kf.setImage(with: imageURL)
            }, onError: { (error) in
                self.AuthViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
}


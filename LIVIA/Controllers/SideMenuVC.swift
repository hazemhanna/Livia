//
//  SideMenuVC.swift
//  Shanab
//
//  Created by Macbook on 3/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
class SideMenuVC: UIViewController {

    @IBOutlet weak var editBN: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var wallet : UILabel!
    @IBOutlet weak var walletValue : UILabel!
    @IBOutlet weak var StackCenter: NSLayoutConstraint!
    @IBOutlet weak var SideMenuTableView: UITableView!
    @IBOutlet weak var walletView : UIView!
    
    

    fileprivate let cellIdentifier = "SideMenuCell"
    var sideMenuArr = [SideMenuModel]() {
        didSet {
            DispatchQueue.main.async {
                self.SideMenuTableView.reloadData()
            }
        }
    }
    
    let token = Helper.getApiToken() ?? ""
    let user = Helper.getUserRole() ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SideMenuTableView.dataSource = self
        SideMenuTableView.delegate = self
        SideMenuTableView.rowHeight = UITableView.automaticDimension
                      SideMenuTableView.estimatedRowHeight = UITableView.automaticDimension
        SideMenuTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)

        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       // if token != "" {
                self.sideMenuArr = [
                    SideMenuModel(name: "Home".localized,id: "home", selected: false,sideImage: #imageLiteral(resourceName: "home")),
                    SideMenuModel(name: "Profile".localized, id: "Profile", selected: false,sideImage: #imageLiteral(resourceName: "ic_assignment_ind_24px-1")),
                    SideMenuModel(name: "Sections".localized, id: "Sections", selected: false, sideImage: #imageLiteral(resourceName: "burger")),
                    SideMenuModel(name: "Cart".localized, id: "Cart", selected: false,sideImage: #imageLiteral(resourceName: "cart (1)-1")),
                    SideMenuModel(name: "Notifications".localized, id: "Notifications", selected: false, sideImage: #imageLiteral(resourceName: "icons8-notification")),
                    SideMenuModel(name: "Reservations".localized, id: "Reservations", selected: false, sideImage: #imageLiteral(resourceName: "reservation2")),
                    SideMenuModel(name: "Order List".localized, id: "OrderList", selected: false, sideImage: #imageLiteral(resourceName: "order-food-1")),
                    SideMenuModel(name: "foodPackages".localized, id: "foodPackages", selected: false, sideImage: #imageLiteral(resourceName: "NoPath - Copy (10)")),
                    SideMenuModel(name: "Favorite Meals".localized, id: "FavoriteMeals", selected: false, sideImage: #imageLiteral(resourceName: "favorite (1)")),
                    SideMenuModel(name: "Contact Us".localized, id: "Contact Us", selected: false,sideImage: #imageLiteral(resourceName: "contactUs")),
                    SideMenuModel(name: "Terms And Conditions".localized, id: "TermsAndConditions", selected: false, sideImage: #imageLiteral(resourceName: "terms")),
                    SideMenuModel(name: "Settings".localized, id: "Setting", selected: false, sideImage: #imageLiteral(resourceName: "Screen Shot 2021-12-31 at 6.42.33 PM"))
                    
                ]
     
            
//        } else {
//            self.sideMenuArr = [
//                SideMenuModel(name: "Home".localized, id: "home", selected: false, sideImage: #imageLiteral(resourceName: "home")),
//                SideMenuModel(name: "Contact Us".localized, id: "Contact Us", selected: false,sideImage: #imageLiteral(resourceName: "cridateCard")),
//                SideMenuModel(name: "Terms And Conditions".localized, id: "TermsAndConditions" , selected: false, sideImage: #imageLiteral(resourceName: "terms")),
//             SideMenuModel(name: "Settings".localized, id: "Setting", selected: false, sideImage: #imageLiteral(resourceName: "Screen Shot 2021-12-31 at 6.42.33 PM"))]
//        }
        
    }
    
    
    @IBAction func editProfileBn(_ sender: UIButton) {
 
        
    }
    
    @IBAction func LogOut(_ sender: UIButton) {
        
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        let main = UIStoryboard(name: "Authentications", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
        self.navigationController?.pushViewController(main, animated: true)
    }
    
    func selectedCell(indexPath: IndexPath) {
        switch sideMenuArr[indexPath.row].sideMenuId {
        case "home":
            guard let window = UIApplication.shared.keyWindow else { return }
            switch Singletone.instance.appUserType {
            case .Customer:
            let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
            sb.selectedIndex = 0
            window.rootViewController = sb
            UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
            
            case .Driver:
                let sb = UIStoryboard(name: "Orders", bundle: nil).instantiateViewController(withIdentifier: "DriverProfileNav")
                window.rootViewController = sb
                window.makeKeyAndVisible()
                
            default:
                break
            }
            //pushSideMenu(StoryboardName: "Home", ForController: "HomeTabBar")
        case "Sections":
            pushSideMenu(StoryboardName: "Orders", ForController: "SectionsPageVC")
        case "Cart":
            pushSideMenu(StoryboardName: "Cart", ForController: "CartVC")
        case "OrderList":
            pushSideMenu(StoryboardName: "Orders", ForController: "OrderListVC")
        case "Profile":
            pushSideMenu(StoryboardName: "Profile", ForController: "CustomerProfileVC")
        case "subscriptions":
            pushSideMenu(StoryboardName: "Products", ForController: "MySubscribtionVc")
        case "foodPackages":
            pushSideMenu(StoryboardName: "Products", ForController: "MYFoodPackagesSubscribtionsVC")

        case "Reservations":
            pushSideMenu(StoryboardName: "Orders", ForController: "OrderListVC")
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
        let sideImage = sideMenuArr[indexPath.row].sideMenuImage
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




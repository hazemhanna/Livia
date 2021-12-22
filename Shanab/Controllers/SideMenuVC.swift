//
//  SideMenuVC.swift
//  Shanab
//
//  Created by Macbook on 3/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
class SideMenuVC: UIViewController {
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var StatusLB: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var editBN: UIButton!
    var id = Int()
    @IBOutlet weak var SignOut: UIButton!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var wallet : UILabel!
    @IBOutlet weak var walletValue : UILabel!
    @IBOutlet weak var currencyLbl : UILabel!
    @IBOutlet weak var StackCenter: NSLayoutConstraint!
    @IBOutlet weak var StackLeading: NSLayoutConstraint!
    @IBOutlet weak var SideMenuTableView: UITableView!
    
    @IBOutlet weak var walletView : UIView!
     var totalWallet = Int()
    
    private let SideMenuVCPresenter = SideMenuPresenter(services: Services())
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
        profilePic.setRounded()
        super.viewDidLoad()
        
       
        SideMenuTableView.dataSource = self
        SideMenuTableView.delegate = self
        SideMenuTableView.rowHeight = UITableView.automaticDimension
                      SideMenuTableView.estimatedRowHeight = UITableView.automaticDimension
        SideMenuTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        SideMenuTableView.tableFooterView = UIView()
        
        SideMenuVCPresenter.setSideMenuViewDelegate(SideMenuViewDelegate: self)
        if (Helper.getApiToken() ?? "") != "" {
            walletView.isHidden = false
            if user == "driver" {
                
                self.signIn.isHidden = true
                self.StatusLB.isHidden = false
                self.profilePic.isHidden = false
                self.StackLeading.isActive = true
                self.StackCenter.isActive = false
                self.editBN.isHidden = true
                
            } else {
                
                self.signIn.isHidden = true
                self.StatusLB.isHidden = true
                self.profilePic.isHidden = true
                self.StackLeading.isActive = false
                self.StackCenter.isActive = true
                self.editBN.isHidden = false

            }
           
            
        } else {
            walletView.isHidden = true
            self.profilePic.image = #imageLiteral(resourceName: "Group 6")
            if "lang".localized == "en" {
                 self.name.text = "Shnp"
            } else {
                 self.name.text = "شنب"
            }
            self.SignOut.isHidden = true
            editBN.isHidden = true
            
            self.profilePic.isHidden = false
            self.StatusLB.isHidden = true
            self.StackLeading.isActive = true
            self.StackCenter.isActive = false
        
        }
        
        
        wallet.text = "wallet".localized
        currencyLbl.text = "SAR".localized
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if token != "" {
            if user == "customer" {
                SideMenuVCPresenter.getUserProfile()
            } else {
                SideMenuVCPresenter.getDriverProfile()
                
            }
            
            if user == "customer" {
                self.sideMenuArr = [
                    SideMenuModel(name: "Home".localized,id: "home", selected: false,sideImage: #imageLiteral(resourceName: "home")),
                    SideMenuModel(name: "Profile".localized, id: "Profile", selected: false,sideImage: #imageLiteral(resourceName: "ic_assignment_ind_24px-1")),
                    SideMenuModel(name: "Sections".localized, id: "Sections", selected: false, sideImage: #imageLiteral(resourceName: "burger")),
                    SideMenuModel(name: "Cart".localized, id: "Cart", selected: false,sideImage: #imageLiteral(resourceName: "cart (1)-1")),
                    SideMenuModel(name: "Notifications".localized, id: "Notifications", selected: false, sideImage: #imageLiteral(resourceName: "icons8-notification")),
                    SideMenuModel(name: "Reservations".localized, id: "Reservations", selected: false, sideImage: #imageLiteral(resourceName: "reservation2")),
                    SideMenuModel(name: "Order List".localized, id: "OrderList", selected: false, sideImage: #imageLiteral(resourceName: "order-food-1")),
                    SideMenuModel(name: "subscriptions".localized, id: "subscriptions", selected: false, sideImage: #imageLiteral(resourceName: "terms")),
                    SideMenuModel(name: "foodPackages".localized, id: "foodPackages", selected: false, sideImage: #imageLiteral(resourceName: "terms")),
                    SideMenuModel(name: "FoodCart".localized, id: "FoodCart", selected: false,sideImage: #imageLiteral(resourceName: "cart (1)-1")),
                    SideMenuModel(name: "Favorit Restaurants".localized, id: "Favorites", selected: false, sideImage: #imageLiteral(resourceName: "heart")),
                    SideMenuModel(name: "Favorite Meals".localized, id: "FavoriteMeals", selected: false, sideImage: #imageLiteral(resourceName: "heart-1")),
                    SideMenuModel(name: "Contact Us".localized, id: "Contact Us", selected: false,sideImage: #imageLiteral(resourceName: "contactUs")),
                    SideMenuModel(name: "Terms And Conditions".localized, id: "TermsAndConditions", selected: false, sideImage: #imageLiteral(resourceName: "terms")),
                    SideMenuModel(name: "Settings".localized, id: "Setting", selected: false, sideImage: #imageLiteral(resourceName: "burger"))
                    
                ]
            } else {
                self.sideMenuArr = [
                    SideMenuModel(name: "Home".localized,id: "home", selected: false,sideImage: #imageLiteral(resourceName: "home")),
                    SideMenuModel(name: "Pervious List".localized, id: "DriverOrderList", selected: false, sideImage: #imageLiteral(resourceName: "terms")),
                    SideMenuModel(name: "Notifications".localized, id: "Notifications", selected: false, sideImage: #imageLiteral(resourceName: "icons8-notification")),
                    SideMenuModel(name: "Contact Us".localized, id: "Contact Us", selected: false,sideImage: #imageLiteral(resourceName: "contactUs")),
                    SideMenuModel(name: "Terms And Conditions".localized, id: "TermsAndConditions", selected: false, sideImage: #imageLiteral(resourceName: "terms")),
                     SideMenuModel(name: "Settings".localized, id: "Setting", selected: false, sideImage: #imageLiteral(resourceName: "burger")),
                    
                    
                    
                ]
            }
            
        } else {
            self.sideMenuArr = [
                SideMenuModel(name: "Home".localized, id: "home", selected: false, sideImage: #imageLiteral(resourceName: "home")),
                SideMenuModel(name: "Contact Us".localized, id: "Contact Us", selected: false,sideImage: #imageLiteral(resourceName: "cridateCard")),
                SideMenuModel(name: "Terms And Conditions".localized, id: "TermsAndConditions" , selected: false, sideImage: #imageLiteral(resourceName: "terms")),
             SideMenuModel(name: "Settings".localized, id: "Setting", selected: false, sideImage: #imageLiteral(resourceName: "burger"))]
        }
        
    }
    
    
    @IBAction func editProfileBn(_ sender: UIButton) {
        guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "WalletVc") as? WalletVc else {return}
        sb.totalWallet = totalWallet
        self.navigationController?.pushViewController(sb, animated: true)
        
    }
    
    @IBAction func LogOut(_ sender: UIButton) {
        //
        switch Singletone.instance.appUserType {
        case .Customer:
            Services.postUserSetToken(type: "ios", device_token: "") { (error: Error?, result: SuccessError_Model?) in
                if let resultM = result {
                    if resultM.successMessage != "" {
                        displayMessage(title: "", message: "You logged out now".localized, status: .success, forController: self)
                        Helper.LogOutUser()
                        self.pushSideMenu(StoryboardName: "Home", ForController: "HomeVC")
                    }
                }
                
            }
        case .Driver:
            Services.postDriverSetToken(type: "ios", device_token: "") { (error: Error?, result: SuccessError_Model?) in
                if let resultM = result {
                    if resultM.successMessage != "" {
                        displayMessage(title: "", message: "You logged out now".localized, status: .success, forController: self)
                        Helper.LogOutUser()
                        self.pushSideMenu(StoryboardName: "Home", ForController: "HomeVC")
                    }
                }
                
            }
        default:
            break
        }
        
        
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
        case "FoodCart":
            pushSideMenu(StoryboardName: "Products", ForController: "MYFoodPackagesCartVC")
        case "Reservations":
            pushSideMenu(StoryboardName: "Reservation", ForController: "ResevationListVC")
        case "Favorites":
            pushSideMenu(StoryboardName: "Orders", ForController: "FavoritesVC")
        case "FavoriteMeals":
            pushSideMenu(StoryboardName: "Orders", ForController: "FavoriteMealsVC")
        case "Contact Us":
            pushSideMenu(StoryboardName: "AboutApp", ForController: "ContactUsVC")
        case "TermsAndConditions":
            pushSideMenu(StoryboardName: "AboutApp", ForController: "TermsAndConditionsVC")
        case "Setting":
            pushSideMenu(StoryboardName: "AboutApp", ForController: "SettingVC")
        case "DriverOrderList":            
            let main = UIStoryboard(name: "Orders", bundle: nil).instantiateViewController(withIdentifier: "DriverOrderListVC") as! DriverOrderListVC
            
            main.orderSelected = .other
            
            self.navigationController!.pushViewController(main, animated: true)

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
        cell.config(name: sideMenuArr[indexPath.row].sideMenuName, selected: sideMenuArr[indexPath.row].sideMenuSelected, imagePath: sideImage)
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
extension SideMenuVC: SideMenuViewDelegate {
    func getDriverProfileResult(_ error: Error?, _ result: User?) {
        if let profile = result {
            self.name.text = profile.nameAr ?? ""
            if profile.is_available == 0 {
                self.StatusLB.text = "Unavailable".localized
            } else {
                self.StatusLB.text = "Available".localized
            }
//            self.StatusLB.text = profile.status
            if let image = profile.image {
                guard let url = URL(string: BASE_URL + "/" + image) else { return }
                self.profilePic.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "shanab loading"))
            }
        }
    }
    
    func getProfileResult(_ error: Error?, _ result: User?) {
        if user == "customer" {
            if let profile = result {
                self.name.text = profile.nameAr ?? ""
                self.walletValue.text = String(profile.total_wallet?.rounded(toPlaces: 2) ?? 0 )
                self.totalWallet = Int(profile.total_wallet?.rounded(toPlaces: 2) ?? 0 )
                if let image = profile.image {
                    guard let url = URL(string: BASE_URL + "/" + image) else { return }
                    self.profilePic.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "shanab loading"))
                    self.StatusLB.isHidden = true
                }
            } else {
                if let profile = result {
                    self.name.text = profile.nameAr ?? ""
                    self.walletValue.text = String(profile.total_wallet?.rounded(toPlaces: 2) ?? 0 )
                    self.StatusLB.text = "\(profile.is_available ?? 0)"
                    self.editBN.isHidden = true
                    
                    if let image = profile.image {
                        guard let url = URL(string: BASE_URL + "/" + image) else { return }
                        self.profilePic.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo-1"))
                    }
                }
            }
        }
    }
}



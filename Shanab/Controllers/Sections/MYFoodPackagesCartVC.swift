//
//  MYFoodPackagesVC .swift
//  Shanab
//
//  Created by MAC on 09/10/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//




import Foundation
import UIKit
import ImageSlideshow
import Urway


class MYFoodPackagesCartVC  : UIViewController {
    
    private let vCPresenter = CartFoodPackegesPresenter(services: Services())
    var paymentController: UIViewController? = nil

    @IBOutlet weak var MealDetailsTableView: UITableView!
    private let TableCellIdentifier = "MyFoodCartCell"
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var empyView : UIView!

    var fees = Double()

    var foodCart  = [FoodCart]() {
        didSet {
            DispatchQueue.main.async {
                self.MealDetailsTableView.reloadData()
            }
        }
    }

    
    var restaurant_id = Int()
    var food_subscription_id = Int()
    var delivery_price = Int()
    var food_price = Double()
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
        vCPresenter.getFoodCart()
        
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func cartItems(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension MYFoodPackagesCartVC   : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foodCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifier, for: indexPath) as? MyFoodCartCell else {return UITableViewCell()}
        
        
        if "lang".localized == "ar" {
            cell.config(imagePath: foodCart[indexPath.row].restaurant?.image ?? ""
                        , desc: foodCart[indexPath.row].foodSubscription?.descriptionAr ?? ""
                        , deliveryprice: Double(foodCart[indexPath.row].deliveryPrice ?? 0)
                        , pakageTime: foodCart[indexPath.row].foodSubscription?.subscription?.titleAr ?? ""
                        , pakageName: foodCart[indexPath.row].foodSubscription?.titleAr ?? ""
                        , PackagePrice: Int(foodCart[indexPath.row].foodPrice ?? 0)
                        ,total: foodCart[indexPath.row].total ?? 0 )
        } else {
            cell.config(imagePath: foodCart[indexPath.row].restaurant?.image ?? ""
                        , desc: foodCart[indexPath.row].foodSubscription?.descriptionEn ?? ""
                        , deliveryprice: Double(foodCart[indexPath.row].deliveryPrice ?? 0)
                        , pakageTime: foodCart[indexPath.row].foodSubscription?.subscription?.titleEn ?? ""
                        , pakageName: foodCart[indexPath.row].foodSubscription?.titleEn ?? ""
                        , PackagePrice: Int(foodCart[indexPath.row].foodPrice ?? 0)
                        ,total: foodCart[indexPath.row].total ?? 0 )

        }
        cell.delete = {
            self.vCPresenter.showIndicator()
            self.vCPresenter.setsubscribtionViewDelegate(subscribtionsViewDelegate: self)
            self.vCPresenter.deletegCart(id: self.foodCart[indexPath.row].id ?? 0 )
            
        }
        
        cell.confirm = {
            self.restaurant_id = self.foodCart[indexPath.row].restaurant?.id ?? 0
            self.food_subscription_id = self.foodCart[indexPath.row].foodSubscription?.id ?? 0
            self.delivery_price = self.foodCart[indexPath.row].deliveryPrice ?? 0
            self.food_price = self.foodCart[indexPath.row].foodPrice ?? 0.0
            self.total = Int(self.foodCart[indexPath.row].total ?? 0)
            self.fees = self.foodCart[indexPath.row].total ?? 0
            
            if Helper.getApiToken() == nil {
                let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "LoginPopupVC")
                sb.modalPresentationStyle = .overCurrentContext
                sb.modalTransitionStyle = .crossDissolve
                self.present(sb, animated: true, completion: nil)
            } else {
                 UWInitialization(self) { (controller , result) in
                     self.paymentController = controller
                     guard let nonNilController = self.paymentController else {
                         self.presentAlert(resut: result)
                         return
                     }
                     self.present(nonNilController, animated: true, completion: nil)
                 }
             }
        }
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension MYFoodPackagesCartVC   : CartFoodPackegesViewDelegate {
    func getFoodSubCart(_ error: Error?, _ result: [FoodCart]?) {
        if let cart = result {
            foodCart = cart
        }
        if foodCart.count > 0 {
            empyView.isHidden = true
        }else{
            empyView.isHidden = false
        }
    }
    
    func deleteFoodSubCart(_ error: Error?, _ result: OrderPaymentModelJSON?){
        displayMessage(title: "", message: "Done".localized , status: .success, forController: self)
        vCPresenter.showIndicator()
        vCPresenter.getFoodCart()
    }
    
    func applyFoodSub(_ error: Error?, _ result: ApplyFoodPackege?) {
        if result != nil {
                displayMessage(title: "", message: "Done".localized , status: .success, forController: self)
                guard let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "ConfirmationPopup") as? ConfirmationPopup else {return}
                       sb.modalPresentationStyle = .overFullScreen
                       self.present(sb, animated: true, completion: nil)
        }
    }
    
}

extension MYFoodPackagesCartVC {
    func presentAlert(resut: paymentResult) {
        var displayTitle: String = ""
        var key: mandatoryEnum = .amount
        
        switch resut {
        case .mandatory(let fields):
            key = fields
        default:
            break
        }
        
        switch  key {
        case .amount:
            displayTitle = "Amount"
        case.country:
            displayTitle = "Country"
        case.action_code:
            displayTitle = "Action Code"
        case.currency:
            displayTitle = "Currency"
        case.email:
            displayTitle = "Email"
        case.trackId:
            displayTitle = "TrackID"
        case .tokenID:
            displayTitle = "TockenID"
        case .cardOperation:
            print("")
        }
        
        let alert = UIAlertController(title: "Alert", message: "Check \(displayTitle) Field", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension MYFoodPackagesCartVC : Initializer {
    
    func didPaymentResult(result: paymentResult, error: Error?, model: PaymentResultData?) {
        switch result {
        case .sucess:
            print("PAYMENT SUCESS")
            DispatchQueue.main.async {
                self.vCPresenter.showIndicator()
                self.vCPresenter.applyFoodSub(restaurant_id: self.restaurant_id, food_subscription_id: self.food_subscription_id, has_delivery_subscription: 1, delivery_price: Double(self.delivery_price), food_price: self.food_price, total: self.total)
            }
            
        case.failure:
            print("PAYMENT FAILURE")
            DispatchQueue.main.async {
                displayMessage(title: "", message: "PAYMENT FAILURE", status: .error, forController: self)
                self.navigateTOReceptPage(model: model)
            }
        case .mandatory(let fieldName):
            print(fieldName)
            break
        }
        
        
    }
    
    
    func prepareModel() -> UWInitializer {
        let model = UWInitializer.init(amount: "\(self.fees)",
            email: "mahmoud.dtag2020@gmail.com",
            currency: "SAR",
            country: "SA" ,
            actionCode: "1",
            trackIdCode: "1233",createTokenIsEnabled : false,merchantIP : "10.10.10.10" , cardOper: "", tokenizationType: "0")
        return model
    }
    
    func navigateTOReceptPage(model: PaymentResultData?) {
        
        
        print(model?.result.debugDescription)
//        self.paymentController?.navigationController?.popViewController(animated: true)
        
        guard let window = UIApplication.shared.keyWindow else { return }
        let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
        sb.selectedIndex = 0
        window.rootViewController = sb
        UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
        
//        let controller = ReceptConfiguration.setup()
//        controller.model = model
//        controller.modalPresentationStyle = .overFullScreen
//        self.present(controller, animated: true, completion: nil)
    }
    
}

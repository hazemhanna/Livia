//
//  RequestTypePopUpVC.swift
//  Shanab
//
//  Created by Macbook on 5/6/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import DLRadioButton
import Urway

enum PayType {
    
    case visa , cash,wallet
}

enum orderType {
    
    case sefry , delivery , basherly
}

class RequestTypePopUpVC: UIViewController {
    @IBOutlet weak var local: DLRadioButton!
    @IBOutlet weak var pasherlyBN: DLRadioButton!
    @IBOutlet weak var radioButton: DLRadioButton!
    
    @IBOutlet weak var visa: DLRadioButton!
    @IBOutlet weak var cach: DLRadioButton!
    @IBOutlet weak var wallet: DLRadioButton!
    @IBOutlet weak var walletStack : UIStackView!

    @IBOutlet weak var Cash: UIStackView!
    @IBOutlet weak var VisaStack: UIStackView!
    var pay : PayType?
    var OrderType : orderType = .sefry
    let UserCreateOrderVCPresenter = UserCreateOrderPresenter(services: Services())

    var vat = 0.0
    var fee = 0.0
    var totalWallet = Double()
    var CartIems = [onlineCart]()
    var quantity_cart = Int()
    var total = Double()
    var address_id = Int()
    var carruncy = String()
    var deletedIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RadioButtonAction(radioButton)
        radioButton.icon = #imageLiteral(resourceName: "checked-green")
        pay = nil
        UserCreateOrderVCPresenter.setCreateViewDelegate(CreateOrderViewDelegate: self)
        UserCreateOrderVCPresenter.getUserProfile()

    }
    
    @IBAction func RadioButtonAction(_ sender: DLRadioButton) {
        switch sender.tag {
        case 1:
            Cash.isHidden = true
            VisaStack.isHidden = false
            radioButton.icon = #imageLiteral(resourceName: "checked")
            OrderType = .sefry
            
        case 2:
            Cash.isHidden = true
            VisaStack.isHidden = false
            OrderType = .delivery
            radioButton.icon = #imageLiteral(resourceName: "checked")

        case 3:
            Cash.isHidden = true
            VisaStack.isHidden = false
            OrderType = .basherly
            radioButton.icon = #imageLiteral(resourceName: "checked")

        default:
            break
        }
    }
    
    @IBAction func PaymentRadioButtonAction(_ sender: DLRadioButton) {
        switch sender.tag {
        case 1:
            pay = .cash
            visa.icon = #imageLiteral(resourceName: "checked")

        case 2:
            pay = .visa
            visa.icon = #imageLiteral(resourceName: "checked-green")

        case 3:
            pay = .wallet
            visa.icon = #imageLiteral(resourceName: "checked")

        default:
            break
        }
    }
    
    @IBAction func confirm(_ sender: Any) {
        if pay == nil  {
            displayMessage(title: "", message: "Choose payment method".localized, status: .error, forController: self)
        } else {
            CreateOrder()
        }
       }
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func CreateOrder() {
        var payment = ""
        var OrderT = ""
        var orderCost = Double()

                let longitude = Constants.long
                let latitude = Constants.lat
                let createOrderCart  = Singletone.instance.cart.map { (onLineCart) -> createOrderModel in
                    let items = mealItems(meal_id: onLineCart.mealID ?? 0, quantity: onLineCart.quantity ?? 0, message: onLineCart.message ?? "")
                    
                    let options = onLineCart.optionsContainer?.map({ (option) -> optionsInOrder in
                        print(option)
                        return optionsInOrder(option_id: option.options?.id ?? 0, quntity: option.quantity ?? 0)
                        
                    })
                    return createOrderModel(order: items, option: options ?? [])
                }
        
        print(createOrderCart)
        
        switch OrderType {
        case .sefry:
            OrderT = "sfry"
            self.total  += 0
        case .delivery:
            OrderT = "delivery"
            self.total  += fee
        case .basherly:
            OrderT = "basherly"
            self.total  += fee

        default:
            break
        }
        
        switch pay {
        case .cash:
            payment = "cash"
        case .visa:
            payment = "visa"
        case .wallet :
            payment = "wallet"

        default:
            break
            
        }
        
        print(createOrderCart)
        self.UserCreateOrderVCPresenter.postUserCreateOrder(lat: latitude, long: longitude, currency: "sr", quantity: quantity_cart, total:self.total,cartItems: createOrderCart, message: "", address_id: address_id, payment: payment, type: OrderT)
    }
    
    
    func navigateTOReceptPage(model: PaymentResultData?) {
    guard let window = UIApplication.shared.keyWindow else { return }
        let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
        sb.selectedIndex = 0
        window.rootViewController = sb
        UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
    }
    
}

extension RequestTypePopUpVC : CreateOrderViewDelegate {
    func getProfileResult(_ error: Error?, _ result: User?) {
        self.totalWallet = (result?.total_wallet?.rounded(toPlaces: 2) ?? 0 )
        
        if  self.totalWallet == 0 {
            walletStack.isHidden = true
        }else{
            walletStack.isHidden = false

        }
    }
    
   
    func paidOrder(_ error: Error?, _ result: OrderPaymentModelJSON?) {
        
    }
    
    func postDeleteCart(_ error: Error?, _ result: SuccessError_Model?) {
        
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                self.navigateTOReceptPage(model: nil)
            }
        }
    }
    
    func CreateOrderResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "", message: "Done".localized , status: .success, forController: self)
                UserCreateOrderVCPresenter.postDeleteCart(condition: "all", id: nil)
            } else if resultMsg.latitude != [""] {
                displayMessage(title: "", message: resultMsg.latitude[0], status: .error, forController: self)
            } else if resultMsg.longitude != [""] {
                displayMessage(title: "", message: resultMsg.longitude[0], status: .error, forController: self)
            } else if resultMsg.quantity != [""] {
                displayMessage(title: "", message: resultMsg.currency[0], status: .error, forController: self)
            } else if resultMsg.quantity != [""] {
                displayMessage(title: "", message: resultMsg.quantity[0], status: .error, forController: self)
            } else if resultMsg.total != [""] {
                displayMessage(title: "", message: resultMsg.total[0], status: .error, forController: self)
            } else if resultMsg.message != [""] {
                displayMessage(title: "", message: resultMsg.message[0], status: .error, forController: self)
            } else if resultMsg.cartItems != [""] {
                displayMessage(title: "", message: resultMsg.cartItems[0], status: .error, forController: self)
            }
        }
    }
    
}



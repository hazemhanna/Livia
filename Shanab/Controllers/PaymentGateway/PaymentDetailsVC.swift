//
//  PaymentDetailsVC.swift
//  Shanab
//
//  Created by Macbook on 5/6/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Urway
import PassKit

class PaymentDetailsVC: UIViewController , PKPaymentAuthorizationViewControllerDelegate {
    
    var paymentController: UIViewController? = nil

    
    @IBOutlet weak var ShippingSt: UIStackView!
    
    @IBOutlet weak var OrderCost: UILabel!
    
    @IBOutlet weak var Shipping: UILabel!
    
    @IBOutlet weak var Tax: UILabel!
    
    @IBOutlet weak var Total: UILabel!
    
    let UserCreateOrderVCPresenter = UserCreateOrderPresenter(services: Services())
    

    @IBOutlet weak var ApplePayST: UIStackView!
    
    let applePayBtn = PKPaymentButton(paymentButtonType: .plain, paymentButtonStyle: .black)
    
    var paymentString: NSString = ""

    var isApplePay = false
    
    var orderCost = 0.0
    var fee = 0.0
    var tax = 0.0

    var OrderType : orderType?
    var pay : PayType?
    var quantity_cart = 0
    var address_id = 0
    
    
    var paymentRequest:PKPaymentRequest = {
    let request = PKPaymentRequest()
    request.merchantIdentifier = "merchant.com.Dtag.Shanab"
        request.supportedNetworks = [.quicPay, .masterCard, .visa, .amex, .discover, .mada]
                  request.merchantCapabilities = .capability3DS
                  request.countryCode = "SA"
                  request.currencyCode = "SAR"
        
        return request
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        applePayBtn.cornerRadius = 10
        applePayBtn.addTarget(self, action: #selector(payWithApple), for: .touchUpInside)
        
        ApplePayST.addArrangedSubview(applePayBtn)
        
        
        UserCreateOrderVCPresenter.setCreateViewDelegate(CreateOrderViewDelegate: self)
        
        
        switch OrderType {
        case .sefry:
            
            ShippingSt.isHidden = true
            fee = 0
            
        case .delivery:
            ShippingSt.isHidden = false
            Shipping.text = "\(fee)"

            
        case .basherly:
            ShippingSt.isHidden = false
            Shipping.text = "\(fee)"

            
        default:
            break
        }
        
        OrderCost.text = "\(orderCost)"
        
        print(fee)
        Shipping.text = "\(fee)"
        let taxValue = orderCost * (tax / 100)
        Tax.text = "\(taxValue.rounded(toPlaces: 2))"
        Total.text = "\((orderCost + fee + taxValue).rounded(toPlaces: 2))"
        
        
        switch pay {
        
        
        case .cash:
            applePayBtn.isHidden = true
        case .visa:
            applePayBtn.isHidden = false
        default:
            break
            
        }
    }
    
    func CreateOrder() {
        
        var payment = ""
        var OrderT = ""
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
        case .delivery:
            OrderT = "delivery"
        case .basherly:
            OrderT = "basherly"
        default:
            break
        }
        
        switch pay {
        
        
        case .cash:
            payment = "cash"
        case .visa:
            payment = "visa"
        default:
            break
            
        }
        
        print(createOrderCart)
        self.UserCreateOrderVCPresenter.postUserCreateOrder(lat: latitude, long: longitude, currency: "sr", quantity: quantity_cart, total: Double(Total.text ?? "0.0") ?? 0.0, cartItems: createOrderCart, message: "", address_id: address_id, payment: payment, type: OrderT)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func payWithApple() {
        
        isApplePay = true
        paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "shnp order",
                                                                   amount: NSDecimalNumber(floatLiteral: Double(Total.text ?? "0") ?? 0.0) )]

        
        guard let controller = PKPaymentAuthorizationViewController(paymentRequest: self.paymentRequest) else {
            
            return     }
        
        
        
        controller.delegate = self

        
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func ApplePay(_ sender: CustomButtons) {
        
        
      
            
    
    }
    
    @IBAction func conffirm(_ sender: Any) {
        
        switch pay {
        case .cash:
            
            CreateOrder()
            
            
        case .visa:
            initializeSDK()
            
        default:
            break
        }
        
    }
    
    func initializeSDK() {
        
        
        UWInitialization(self) { (controller , result) in
            
            
            self.paymentController = controller
            guard let nonNilController = self.paymentController else {
                self.presentAlert(resut: result)
                return
            }
            
            self.present(nonNilController, animated: true, completion: nil)

//        self.navigationController?.pushViewController(nonNilController, animated: true)
     
        }
        
     

    }
}


extension PaymentDetailsVC {
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
            displayTitle = "cardOperation"
        }
        
        let alert = UIAlertController(title: "Alert", message: "Check \(displayTitle) Field", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
          controller.dismiss(animated: true, completion: nil)
        UWInitialization(self) { (controller , result) in
            
            
            self.paymentController = controller
            guard let nonNilController = self.paymentController else {
                self.presentAlert(resut: result)
                return
            }
            
            self.present(nonNilController, animated: true, completion: nil)

//            self.navigationController?.pushViewController(nonNilController, animated: true)
     
        }
//            self.initializeSDK()
//          isSucessStatus ? self.initializeSDK() : nil
      }
      
      func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
          self.paymentString = UWInitializer.generatePaymentKey(payment: payment)
        print(self.paymentString)
          completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
      }
    
}

extension PaymentDetailsVC : Initializer {
    
    func didPaymentResult(result: paymentResult, error: Error?, model: PaymentResultData?) {
        
        
        
        switch result {
        case .sucess:
            print("PAYMENT SUCESS")
                
                self.CreateOrder()
        
        case.failure:
            
            DispatchQueue.main.async {
                
                displayMessage(title: "", message: "PAYMENT FAILURE", status: .error, forController: self)
                print("PAYMENT FAILURE")
                    self.navigateTOReceptPage(model: model)

            }
            
        case .mandatory(let fieldName):
            print(fieldName)
            break
        }
        
        
    }
    
    
    func prepareModel() -> UWInitializer {
        let model = UWInitializer.init(amount: Total.text ?? "",
            email: "mahmoud.dtag2020@gmail.com",
            currency: "SAR",
            country: "SA" ,
            actionCode: "1",
            trackIdCode: "1233",
            udf4:isApplePay ? "ApplePay" : "",
            udf5:isApplePay ? paymentString : "",
            createTokenIsEnabled : false,merchantIP : "10.10.10.10"
            , merchantidentifier: paymentRequest.merchantIdentifier,
            tokenizationType: "0")
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

extension PaymentDetailsVC : CreateOrderViewDelegate {
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
//                let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "OrderConfirmationPopUp")
//                sb.modalPresentationStyle = .overCurrentContext
//                sb.modalTransitionStyle = .crossDissolve
//                self.present(sb, animated: true, completion: nil)
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

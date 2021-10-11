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
    
    case visa , cash
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
    
    @IBOutlet weak var Cash: UIStackView!
    @IBOutlet weak var VisaStack: UIStackView!
    var pay : PayType?
    var OrderType : orderType = .sefry
    
    var vat = 0.0
    var fee = 0.0
    
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
        
    }
    
    @IBAction func RadioButtonAction(_ sender: DLRadioButton) {
        switch sender.tag {
        case 1:
            Cash.isHidden = true
            VisaStack.isHidden = false
            radioButton.icon = #imageLiteral(resourceName: "checked")
            visa.icon = #imageLiteral(resourceName: "checked-green")
            PaymentRadioButtonAction(visa)

            pay = .visa
            OrderType = .sefry
            
        case 2:
            Cash.isHidden = true
            VisaStack.isHidden = false
            PaymentRadioButtonAction(visa)
            radioButton.icon = #imageLiteral(resourceName: "checked")

            visa.icon = #imageLiteral(resourceName: "checked-green")
            pay = .visa          //  pay = nil
            OrderType = .delivery
            
        case 3:
            Cash.isHidden = true
            VisaStack.isHidden = false
            PaymentRadioButtonAction(visa)
            radioButton.icon = #imageLiteral(resourceName: "checked")

            visa.icon = #imageLiteral(resourceName: "checked-green")
            pay = .visa
            OrderType = .basherly
            
        default:
            break
        }
    }
    @IBAction func PaymentRadioButtonAction(_ sender: DLRadioButton) {
        switch sender.tag {
        case 1:
            
            pay = .cash
        case 2:

            pay = .visa
        default:
            break
        }
    }
    @IBAction func confirm(_ sender: Any) {
        
        if pay == nil  {
            
            displayMessage(title: "", message: "Choose payment method".localized, status: .error, forController: self)
        } else {
        let vc = UIStoryboard(name:"PaymentGetWay", bundle: nil).instantiateViewController(withIdentifier: "PaymentDetailsVC") as! PaymentDetailsVC
            print(total)
            vc.orderCost = total
            vc.fee = fee
            vc.tax = vat
            vc.OrderType = OrderType
            vc.pay = pay
            vc.quantity_cart = quantity_cart
            vc.address_id = address_id
        
        
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
       
            
        }
        
        
     
    
    
    @IBAction func Back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}






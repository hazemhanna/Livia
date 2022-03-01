//
//  File.swift
//  Livia
//
//  Created by MAC on 01/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import UIKit

enum PayType {
    case visa,cash,wallet
}

enum orderType {
    case sefry,delivery
}

class RequestTypePopUpVC: UIViewController {
    
    @IBOutlet weak var safarytBN: UIButton!
    @IBOutlet weak var deliveryButton: UIButton!
    @IBOutlet weak var visa: UIButton!
    @IBOutlet weak var cach: UIButton!
    @IBOutlet weak var wallet: UIButton!
    
    
    var pay : PayType?
    var OrderType : orderType = .sefry

   
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func RadioButtonAction(_ sender:UIButton) {
        switch sender.tag {
        case 0:
            OrderType = .sefry
            safarytBN.setImage(#imageLiteral(resourceName: "checked-green"), for: .normal)
            deliveryButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        case 1:
            OrderType = .delivery
            deliveryButton.setImage(#imageLiteral(resourceName: "checked-green"), for: .normal)
            safarytBN.setImage(#imageLiteral(resourceName: "checked"), for: .normal)

        default:
            break
        }
    }
    
    @IBAction func PaymentRadioButtonAction(_ sender:UIButton) {
        switch sender.tag {
        case 0:
            pay = .cash
            cach.setImage(#imageLiteral(resourceName: "checked-green"), for: .normal)
            visa.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            wallet.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        case 1:
            pay = .visa
            visa.setImage(#imageLiteral(resourceName: "checked-green"), for: .normal)
            cach.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            wallet.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        case 2:
            pay = .wallet
            wallet.setImage(#imageLiteral(resourceName: "checked-green"), for: .normal)
            cach.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            visa.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
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
    
  

    func CreateOrder() {
       navigateTOReceptPage()
    }
    
    
    func navigateTOReceptPage() {
    guard let window = UIApplication.shared.keyWindow else { return }
        let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
        sb.selectedIndex = 0
        window.rootViewController = sb
        UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
    }
    
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    
}




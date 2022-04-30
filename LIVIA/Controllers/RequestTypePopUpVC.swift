//
//  File.swift
//  Livia
//
//  Created by MAC on 01/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


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
    @IBOutlet weak var titleLbl  : UILabel!

    var notes: String?
    var phone: String?
    var address: String?
    var order_place = 2

    private let cartViewModel = CartViewModel()
    var disposeBag = DisposeBag()
    var pay : PayType?
    var OrderType : orderType = .sefry
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = "Payment".localized
    }
    
    @IBAction func RadioButtonAction(_ sender:UIButton) {
        switch sender.tag {
        case 0:
            OrderType = .sefry
            safarytBN.setImage(#imageLiteral(resourceName: "checked-green"), for: .normal)
            deliveryButton.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            self.order_place = 2
        case 1:
            OrderType = .delivery
            deliveryButton.setImage(#imageLiteral(resourceName: "checked-green"), for: .normal)
            safarytBN.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            self.order_place = 1
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
            displayMessage(title: "", message: "not valid now".localized, status: .error, forController: self)
            //visa.setImage(#imageLiteral(resourceName: "checked-green"), for: .normal)
           // cach.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            //wallet.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        case 2:
            pay = .wallet
            displayMessage(title: "", message: "not valid now".localized, status: .error, forController: self)
            //wallet.setImage(#imageLiteral(resourceName: "checked-green"), for: .normal)
            //cach.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            //visa.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        default:
            break
        }
    }
    
    @IBAction func confirm(_ sender: Any) {
        self.cartViewModel.showIndicator()
        createOrder(phoneNumber: self.phone ?? "" , address: self.address ?? "" , notes: notes ?? "" , order_place: order_place)
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
    
    func createOrder(phoneNumber : String,address : String,notes : String,order_place : Int) {
        self.cartViewModel.createOrder(phoneNumber: phoneNumber, address: address, notes: notes, order_place: order_place).subscribe(onNext: { (data) in
            self.cartViewModel.dismissIndicator()
                if data.value ?? false {
                    self.navigateTOReceptPage()
                }
            }, onError: { (error) in
                self.cartViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
     }
}




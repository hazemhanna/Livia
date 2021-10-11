//
//  RatingVC.swift
//  Shanab
//
//  Created by Macbook on 4/12/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Cosmos
class RatingVC: UIViewController {
    @IBOutlet weak var OrderRate: CosmosView!
    @IBOutlet weak var agentRate: CosmosView!
    var rate = 0.5
    var DriverRate = 0.5
    var order_id = Int()
    @IBOutlet weak var discreption: UITextField!
    private let OrderRateVCPresenter = orderRatePresenter(services: Services())
    override func viewDidLoad() {
        super.viewDidLoad()
        OrderRateVCPresenter.setOrderRateViewDelegate(OrderRateViewDelegate: self)
        //OrderRate.rating = rate
        OrderRate.didTouchCosmos = { (rate) in
            self.rate = rate
            print(rate)
        }
        
        agentRate.didTouchCosmos = { (rate) in
            
            self.DriverRate = rate
            print(rate)

        }
    }
    
    
    @IBAction func confirm(_ sender: UIButton) {
        OrderRateVCPresenter.showIndicator()
        OrderRateVCPresenter.postRateOrder(order_id: order_id,rate: rate, driver_rate : DriverRate , comment : (discreption.text ?? "No comment"))
        //rate_id must passing From Previous controller
//        guard let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else {return}
//        self.navigationController?.pushViewController(sb, animated: true)
    }
    @IBAction func dismiss(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
}
extension RatingVC: OrderRateViewDelegate  {
    func postRateDriverResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let rating = result {
            if rating.successMessage != "" {
                displayMessage(title: "Done".localized, message: rating.successMessage, status: .success, forController: self)
                print("done")
                self.dismiss(animated: true, completion: nil)
            } else if rating.comment != [""] {
                displayMessage(title: "", message: rating.comment[0], status: .error, forController: self)
            } else if rating.rate != [""] {
                displayMessage(title: "", message: rating.rate[0], status: .error, forController: self)
            }
        }
    }
    
    func postCommentRateResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let rating = result {
            if rating.successMessage != "" {
                displayMessage(title: "Done", message: rating.successMessage, status: .success, forController: self)
                print("done")
                self.dismiss(animated: true, completion: nil)
            } else if rating.comment != [""] {
                displayMessage(title: "", message: rating.comment[0], status: .error, forController: self)
            } else if rating.rate != [""] {
                displayMessage(title: "", message: rating.rate[0], status: .error, forController: self)
            }
        }
    }
    
    func postRateResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let rating = result {
            if rating.successMessage != "" {
                displayMessage(title: "Done".localized, message: "Order rated".localized, status: .success, forController: self)
                dismiss(animated: true, completion: nil)

                print("done")
                self.dismiss(animated: true, completion: nil)
            } else if rating.comment != [""] {
                displayMessage(title: "", message: rating.comment[0], status: .error, forController: self)
            } else if rating.rate != [""] {
                displayMessage(title: "", message: rating.rate[0], status: .error, forController: self)
            }
        }
    }
    
    
}

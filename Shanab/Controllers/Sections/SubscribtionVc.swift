//
//  MealDetailsVC.swift
//  Shanab
//
//  Created by Macbook on 7/2/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Urway


class SubscribtionVc: UIViewController {
    
    var paymentController: UIViewController? = nil

    
    
    private let SubscribtionsVCPresenter = SubscribtionsPresenter(services: Services())
    @IBOutlet weak var MealDetailsTableView: UITableView!
    @IBOutlet weak var tableViewHieght: NSLayoutConstraint!
    
    @IBOutlet weak var confitmBtn : UIButton!
    @IBOutlet weak var empyView : UIView!

    private let TableCellIdentifier = "SubscriptionCell"
    @IBOutlet weak var titleLbl: UILabel!
    var selectedIndex = -1
    var restaurant_id = Int()
    var fees = Double()
    var subscribtionId = Int()
    var subscription  = [Subscription]() {
        didSet {
            DispatchQueue.main.async {
                self.tableViewHieght.constant = CGFloat(80 * self.subscription.count)
                self.MealDetailsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MealDetailsTableView.delegate = self
        MealDetailsTableView.dataSource = self
        MealDetailsTableView.estimatedRowHeight = UITableView.automaticDimension
        MealDetailsTableView.register(UINib(nibName: TableCellIdentifier, bundle: nil), forCellReuseIdentifier: TableCellIdentifier)
        titleLbl.text = "subscriptions".localized
        SubscribtionsVCPresenter.showIndicator()
        SubscribtionsVCPresenter.setsubscribtionViewDelegate(subscribtionsViewDelegate: self)
        SubscribtionsVCPresenter.getSubscribtions(restaurant_id: restaurant_id)
        confitmBtn.setTitle("Confirm".localized, for: .normal)
    }
    
    @IBAction func reservationTablr(_ sender: UIButton) {
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
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func cartItems(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension SubscribtionVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subscription.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifier, for: indexPath) as? SubscriptionCell else {return UITableViewCell()}
        
        if "lang".localized == "en"{
            cell.confic(price: String(self.subscription[indexPath.row].price ?? 0), title: self.subscription[indexPath.row].titleEn ?? "")
        }else{
            cell.confic(price: String(self.subscription[indexPath.row].price ?? 0), title: self.subscription[indexPath.row].titleAr ?? "")
       }
        
        if self.selectedIndex == indexPath.row {
            cell.mainView.backgroundColor = #colorLiteral(red: 1, green: 0.1647058824, blue: 0.1490196078, alpha: 1)
         }else{
            cell.mainView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.fees = Double(self.subscription[indexPath.row].price ?? 0)
        self.subscribtionId = self.subscription[indexPath.row].id ?? 0
        self.MealDetailsTableView.reloadData()
    }
    
}


extension SubscribtionVc: SubscribtionsViewDelegate {
    func ApplyingSubscribtion(_ error: Error?, _ result: ApplyingSubscribtion?) {
        
        if let resultMsg = result {
                displayMessage(title: "", message: "Done".localized , status: .success, forController: self)
                guard let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "ConfirmationPopup") as? ConfirmationPopup else {return}
                       sb.modalPresentationStyle = .overFullScreen
                      // sb.modalTransitionStyle = .crossDissolve
                       self.present(sb, animated: true, completion: nil)
        }
    }
    
    func subscribtions(_ error: Error?, _ result: [Subscription]?) {
        if let sub = result {
            self.subscription = sub
            if subscription.count > 0 {
                empyView.isHidden = true
            }else{
                empyView.isHidden = false
            }
            
        }
    }
    
}

extension SubscribtionVc {
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
extension SubscribtionVc : Initializer {
    
    func didPaymentResult(result: paymentResult, error: Error?, model: PaymentResultData?) {
        switch result {
        case .sucess:
            print("PAYMENT SUCESS")
            DispatchQueue.main.async {
                self.SubscribtionsVCPresenter.showIndicator()
                self.SubscribtionsVCPresenter.ApplyingSubscribtion(restaurant_id: self.restaurant_id,subscribtionId: self.subscribtionId)
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

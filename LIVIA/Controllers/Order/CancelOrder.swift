//
//  CancelOrder.swift
//  Livia
//
//  Created by MAC on 20/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

class CancelOrder : UIViewController {
    @IBOutlet weak var titleLbl  : UILabel!
    let orderViewModel  = OrderViewModel()
    var disposeBag = DisposeBag()
    var orderId = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func Confirm(_ sender: UIButton) {
        orderViewModel.showIndicator()
        CancelOrder(order_id: orderId)
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "ScanVc") as? ScanVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
    func navigateTOReceptPage() {
    guard let window = UIApplication.shared.keyWindow else { return }
        let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
        sb.selectedIndex = 0
        window.rootViewController = sb
        UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
    }
    
}

extension CancelOrder {
    
    func CancelOrder(order_id : Int) {
        self.orderViewModel.cancelOrder(order_id: order_id).subscribe(onNext: { (data) in
          self.orderViewModel.dismissIndicator()
            if data.value ?? false{
                displayMessage(title: "", message: "ordercancel".localized, status:.success, forController: self)
            }else{
                displayMessage(title: "", message: data.msg ?? "" .localized, status: .error, forController: self)
            }
            self.navigateTOReceptPage()
        }, onError: { (error) in
          self.orderViewModel.dismissIndicator()
         }).disposed(by: disposeBag)
    }
    
}

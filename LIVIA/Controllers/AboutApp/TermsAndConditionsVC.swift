//
//  TermsAndConditionsVC.swift
//  Shanab
//
//  Created by Macbook on 6/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa


class TermsAndConditionsVC: UIViewController {
    
    @IBOutlet weak var TermsAndCond: UITextView!
    
    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AuthViewModel.showIndicator()
        getSetting()
        
        if "lang".localized == "ar" {
            TermsAndCond.textAlignment = .right
        }else{
            TermsAndCond.textAlignment = .left
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func Menu(_ sender: Any) {
        setupSideMenu()
    }


    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "ScanVc") as? ScanVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
}


extension TermsAndConditionsVC {
    func getSetting() {
        self.AuthViewModel.getSetting().subscribe(onNext: { (data) in
            self.AuthViewModel.dismissIndicator()
            
            if "lang".localized == "ar" {
              self.TermsAndCond.text = data.data.settings.terms?.ar
            }else{
              self.TermsAndCond.text = data.data.settings.terms?.en
            }
            
         }, onError: { (error) in
                self.AuthViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
     }
    
}

//
//  MailTempaltePresenter.swift
//  Shanab
//
//  Created by Macbook on 5/27/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol MailTempalteViewDelegate: class {
    func mailTempalteResult(_ error: Error?, _ result: [Tempalte]?)
    func SupprortingResult(_ error: Error?, _ result: [Setting]?)
    func CreateEmail(_ error: Error? , _ result : SuccessError_Model?)
    
}
class MailTempaltePresenter {
    private let services: Services
    private weak var MailTempalteViewDelegate: MailTempalteViewDelegate?
    init(services: Services) {
        self.services = services
    }
    func setMailTempalteViewDelegate(MailTempalteViewDelegate: MailTempalteViewDelegate) {
        self.MailTempalteViewDelegate = MailTempalteViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func getmailTemalte(type: String) {
        services.GetmailTemplate(type: type) {[weak self] (_ error: Error?, _ result: [Tempalte]?) in
            self?.MailTempalteViewDelegate?.mailTempalteResult(error, result)
            self?.dismissIndicator()
        }
    }
    func getSettings() {
           services.getSetting {[weak self] (error: Error?, result: [Setting]?) in
               self?.MailTempalteViewDelegate?.SupprortingResult(error, result)
               self?.dismissIndicator()
           }
       }
    
    func SendEmail(email:String , phone : String , name : String , type : String , kind : String , message : String ) {
        
        services.CreateEmail(message: message, name: name, phone: phone, email: email, kind: kind, Mailtype: type) {[weak self] (error, result) in
            
            
            self?.dismissIndicator()
            self?.MailTempalteViewDelegate?.CreateEmail(error, result)
        }
    }
    
}

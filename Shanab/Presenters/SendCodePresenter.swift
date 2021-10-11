//
//  SendCodePresenter.swift
//  Shanab
//
//  Created by mahmoud helmy on 11/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation


protocol SendCodeView  : class {
    
    func showIndicator()
    func dismissIndicator()
    func UserVerified(_ error : Error? , _ success : SuccessError_Model?)
    func DriverVerified(_ error : Error? , _ success : SuccessError_Model?)

    
}

class SendCodePresenter {
    
    
    private weak var view :SendCodeView?
    private var service = Services()
    
    
    init(view : SendCodeView) {
        
        self.view = view
    }
    
    func sendCode(code : String , userType : userType) {
        
        
        self.view?.showIndicator()
        if userType == .agent {
            
            service.DriverCode(code: code) { (error, success) in
                
                self.view?.DriverVerified(error, success)
                self.view?.dismissIndicator()
            }
        } else {
            
            service.UserCode(code: code) { (error, success) in
                
                self.view?.UserVerified(error, success)
                self.view?.dismissIndicator()
            }
        }
        
    }
    
}

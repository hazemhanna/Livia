//
//  VerifyPresenter.swift
//  Shanab
//
//  Created by mahmoud helmy on 11/22/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation

protocol VerifyView : class {
    
    func showIndicator()
    func dismissIndicator()
    func UserEmailVerified(_ error : Error? , _ success : SuccessError_Model?)
    func DriverEmailVerified(_ error : Error? , _ success : SuccessError_Model?)

}

class VerifyPresenter {
    
    private weak var view : VerifyView?
    private var service = Services()
    
    
    init(view : VerifyView) {
        
        self.view = view
        
    }
    
    func verifyEmail(email : String  , usertype : userType) {
        
        view?.showIndicator()
        
        
        if usertype == .user {
        service.VerifyUserEmail(email: email) { (error, success) in
            
            self.view?.dismissIndicator()
            
            
            self.view?.UserEmailVerified(error, success)
        }
        } else {
            
            service.VerifyDriverEmail(email: email) { (error, success) in
                
                self.view?.dismissIndicator()
                                
                self.view?.UserEmailVerified(error, success)

            }
        }
    }
}

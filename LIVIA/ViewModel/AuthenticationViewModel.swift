//
//  AuthenticationViewModel.swift
//  Livia
//
//  Created by MAC on 22/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation
import RxSwift
import SVProgressHUD

struct AuthenticationViewModel {
    
    var email = BehaviorSubject<String>(value: "")
    var password = BehaviorSubject<String>(value: "")
    var confirm_password = BehaviorSubject<String>(value: "")
    var oldPassword = BehaviorSubject<String>(value: "")
    var name = BehaviorSubject<String>(value: "")
    var address = BehaviorSubject<String>(value: "")
    var phone = BehaviorSubject<String>(value: "")
    var message = BehaviorSubject<String>(value: "")

    func showIndicator() {
        SVProgressHUD.show()
    }
    
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
  
    
    func attemptToLogin() -> Observable<LoginModel> {
        let bindedEmail = try? email.value()
        let bindedPassword = try? password.value()
        let params: [String: Any] = [
            "email": bindedEmail ?? "",
            "password":bindedPassword ?? ""
            ]
        let observer = Authentication.shared.postLogin(params: params)
        return observer
    }
    
 // MARK:- Attempt to register
    func attemptToRegister() -> Observable<RegisterModel> {
        let bindedName = (try? self.name.value()) ?? ""
        let address = (try? self.address.value()) ?? ""
        let bindedEmail = (try? self.email.value()) ?? ""
        let bindedPhone = (try? self.phone.value()) ?? ""
        let password = (try? self.password.value()) ?? ""

        let params: [String: Any] = [
            "email": bindedEmail,
            "name": bindedName ,
            "password": password,
            "password_confirmation": password ,
            "address": address ,
            "phone": bindedPhone]
        
        let observer = Authentication.shared.postRegister(params: params)
        return observer
    }
    
    func getProfile() -> Observable<ProfileModel> {
          let observer = GetServices.shared.getProfile()
         return observer
     }
    
    
    func updateProfile() -> Observable<ProfileModel> {
        let bindedName = (try? self.name.value()) ?? ""
        let address = (try? self.address.value()) ?? ""
        let bindedPhone = (try? self.phone.value()) ?? ""

        let params: [String: Any] = [
            "name": bindedName ,
            "address": address ,
            "phone": bindedPhone]
        
        let observer = Authentication.shared.updateProfile(params: params)
        return observer
    }


    func POSTChangePassowrd() -> Observable<BaseModel> {
        
        let binedOldPass = (try? self.oldPassword.value()) ?? ""
        let bindedPassword = (try? self.password.value()) ?? ""
        let bindedConfirm_password = (try? self.confirm_password.value()) ?? ""

         let params: [String: Any] = [
            "password": bindedPassword,
            "old_password": binedOldPass,
            "password_confirmation": bindedConfirm_password
        ]
        let observer = Authentication.shared.postChangePassword(params: params)
        return observer
    }
    
    func contactUs(subject : String) -> Observable<BaseModel> {
        let bindedName = (try? self.name.value()) ?? ""
        let message = (try? self.message.value()) ?? ""
        let bindedEmail = (try? self.email.value()) ?? ""
        let bindedPhone = (try? self.phone.value()) ?? ""

        let params: [String: Any] = [
            "name": bindedName ,
            "email": bindedEmail,
            "message": message,
            "subject": subject ,
            "phone": bindedPhone]
        let observer = AddServices.shared.contacUS(params: params)
        return observer
    }
    
    func getSetting() -> Observable<SettingModelJson> {
          let observer = GetServices.shared.getSetting()
         return observer
     }
    
    
    func updateAvatar(image : UIImage) -> Observable<BaseModel> {
       let observer = Authentication.shared.updateAvatar(image: image)
        return observer
    }
}

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
    var name = BehaviorSubject<String>(value: "")
    var address = BehaviorSubject<String>(value: "")
    var phone = BehaviorSubject<String>(value: "")
   

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
    func attemptToRegister() -> Observable<ProfileModel> {
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
    
    
//    func validatePass() -> Observable<String> {
//        return Observable.create({ (observer) -> Disposable in
//            let bindedPassword = (try? self.password.value()) ?? ""
//            let bindedConfirm_password = (try? self.confirm_password.value()) ?? ""
//            if bindedPassword.isEmpty {
//                if "lang".localized == "ar" {
//                observer.onNext("من فضلك ادخل  كلمة المرور")
//                }else{
//                    observer.onNext("Please Enter Your Password")
//                }
//            } else if bindedConfirm_password.isEmpty {
//                if "lang".localized == "ar" {
//                observer.onNext("من فضلك فم بتاكيد كلمة المرور")
//                }else{
//                observer.onNext("Please Enter Your Password Confirmation")
//                }
//            } else if bindedPassword != bindedConfirm_password {
//                if "lang".localized == "ar" {
//                observer.onNext("كلمة المرور غير متطابقة")
//                }else{
//                observer.onNext("Password & Password confirmation not matched")
//                }
//            }else if bindedPassword.isPasswordValid() != true{
//                if "lang".localized == "ar" {
//                    observer.onNext("كلمة المرور غير صالحة")
//                } else {
//                    observer.onNext("your password not Valid")
//              }
//            }else{
//                observer.onNext("")
//            }
//            return Disposables.create()
//        })
//    }
//
//    func validateChangePass() -> Observable<String> {
//        return Observable.create({ (observer) -> Disposable in
//            let bindedPassword = (try? self.password.value()) ?? ""
//            let bindedConfirm_password = (try? self.confirm_password.value()) ?? ""
//            let binedOldPass = (try? self.oldPass.value()) ?? ""
//
//            if binedOldPass.isEmpty {
//                if "lang".localized == "ar" {
//                observer.onNext("من فضلك ادخل  كلمة المرور الحالية")
//                }else{
//                    observer.onNext("Please Enter Your current Password")
//                }
//            }else if bindedPassword.isEmpty {
//                if "lang".localized == "ar" {
//                observer.onNext("من فضلك ادخل  كلمة المرور الجدة")
//                }else{
//                    observer.onNext("Please Enter Your new Password")
//                }
//            } else if bindedConfirm_password.isEmpty {
//                if "lang".localized == "ar" {
//                observer.onNext("من فضلك فم بتاكيد كلمة المرور")
//                }else{
//                observer.onNext("Please Enter Your Password Confirmation")
//                }
//            } else if bindedPassword != bindedConfirm_password {
//                if "lang".localized == "ar" {
//                observer.onNext("كلمة المرور غير متطابقة")
//                }else{
//                observer.onNext("Password & Password confirmation not matched")
//                }
//            }else if bindedPassword.isPasswordValid() != true{
//                if "lang".localized == "ar" {
//                    observer.onNext("كلمة المرور غير صالحة")
//                } else {
//                    observer.onNext("your password not Valid")
//              }
//            }else{
//                observer.onNext("")
//            }
//            return Disposables.create()
//        })
//    }
//

//    func POSTSendCode(email : String) -> Observable<PasswordJSONModel> {
//        let params: [String: Any] = [
//            "email": email
//        ]
//        let observer = Authentication.shared.resendRegisterCode(params: params)
//        return observer
//    }
//
//    func getActiveAcount(code: String) -> Observable<PasswordJSONModel> {
//        let observer = Authentication.shared.getActiveAcount(code: code)
//        return observer
//    }
//
//    func GETCheckForgetPasswordCode(code: String) -> Observable<PasswordJSONModel> {
//           let observer = Authentication.shared.getCheckPassCode(code: code)
//           return observer
//       }
//
//    func POSTUpdatePassowrd(code:String) -> Observable<PasswordUpdatJSONModel> {
//        let bindedPhone = try? email.value()
//        let bindedPassword = try? password.value()
//
//         let params: [String: Any] = [
//            "password": bindedPassword?.arToEnDigits ?? "",
//            "email": bindedPhone ?? "",
//            "code": code
//        ]
//
//        let observer = Authentication.shared.postUpdatePassword(params: params)
//        return observer
//    }
//
//    func POSTChangePassowrd() -> Observable<ChangePasswordModel> {
//        let bindedPassword = try? self.password.value()
//        let bindedConfirm_password = try? self.confirm_password.value()
//        let binedOldPass = try? self.oldPass.value()
//
//         let params: [String: Any] = [
//            "current_password": binedOldPass?.arToEnDigits ?? "",
//            "new_password": bindedPassword?.arToEnDigits ?? "",
//            "password_confirmation": bindedConfirm_password?.arToEnDigits ?? ""
//        ]
//        let observer = Authentication.shared.postChangePassword(params: params)
//        return observer
//    }
//
//    func attemptToEditProfile(gender: String,avatar : UIImage) -> Observable<ProfileModelJSON> {
//            let bindedEmail = try? email.value()
//            let bindedFirstName = try? first_name.value()
//            let bindedLastName = try? last_name.value()
//            let bindedIdNumber = try? id_number.value()
//            let bindedMedicalNumber = try? medical_number.value()
//            let bindedPhone = try? phone.value()
//            let params: [String: Any] = [
//                "email": bindedEmail ?? "",
//                "first_name": bindedFirstName ?? "",
//                "last_name": bindedLastName ?? "",
//                "id_number": (bindedIdNumber ?? "").arToEnDigits,
//                "medical_number": (bindedMedicalNumber ?? "").arToEnDigits,
//                "phone": (bindedPhone ?? "").arToEnDigits,
//                "gender": gender,
//                ]
//        let observer = Authentication.shared.postEditProfile(image: avatar, params: params)
//            return observer
//        }
//
//       func getProfile() -> Observable<ProfileModelJSON> {
//           let params: [String: Any] = [
//               "email": Helper.getUserEmail() ?? ""
//           ]
//           let observer = Authentication.shared.getProfile(params: params)
//           return observer
//       }
//
//    func getCategories() -> Observable<CategoriesModel> {
//         let observer = GetServices.shared.getAllCategories()
//         return observer
//     }
}

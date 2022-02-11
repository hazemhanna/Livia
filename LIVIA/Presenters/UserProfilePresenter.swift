//
//  UserProfilePresenter.swift
//  Shanab
//
//  Created by Macbook on 5/3/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol UserProfileViewDelegate: class {
    func UserChangeProfileResult(_ error: Error?, _ result: SuccessError_Model?)
    func getUserProfileResult(_ error: Error?  , _ result: User?)
    func UserProfileChangePasswordResult(_ error: Error?, _ result: SuccessError_Model?)
    func getchingAllData(_ profile: User?, _ restaurants: [Restaurant]?)
    func getNotifications(_ error : Error? ,_ notifications:[Notifications]?)
    func getUserProfileUpdated(_ error: Error? ,_ message: SuccessError_Model?, _ result: User?)

    
}
class UserProfilePresenter {
    private let services: Services
    private weak var UserProfileViewDelegate: UserProfileViewDelegate?
    
    private var profile: User?
    private var restaurants: [Restaurant]?
    private var result: SuccessError_Model?
    
    init(services: Services) {
        self.services = services
    }
    
    func viewDidLoad() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        services.getProfile {[weak self] (error: Error?, result: User?) in
            self?.profile = result
            dispatchGroup.leave()
//            self?.UserProfileViewDelegate?.getUserProfileResult(error, result)
//            self?.dismissIndicator()
        }
        
        dispatchGroup.enter()
        services.getAllRestaurants(type: ["truck"]) { (error: Error?, result: [Restaurant]?) in
            self.restaurants = result
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            // hide loading
            self.UserProfileViewDelegate?.getchingAllData(self.profile, self.restaurants)
        }
    }
    
    func setUserProfileViewDelegate( UserProfileViewDelegate: UserProfileViewDelegate) {
        self.UserProfileViewDelegate = UserProfileViewDelegate
    }
    func showIndicator() {
        SVProgressHUD.show()
    }
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    func postUserChangeProfileImage(image: UIImage) {
        services.UserChangeProfileImage(image: image) {[weak self] (_ error: Error?, _ result: SuccessError_Model?, _ progress: Progress?) in
            self?.UserProfileViewDelegate?.UserChangeProfileResult(error, result)
            self?.dismissIndicator()
        }
    }
    func getUserProfile() {
        services.getProfile {[weak self] (error: Error?, result: User?) in
            self?.UserProfileViewDelegate?.getUserProfileResult(error, result)
            self?.dismissIndicator()
        }
    }
    func postUserProfileChangePassword(password: String, old_password: String, password_confirmation: String) {
        services.postUserProfileChangePassword(password: password, old_password: old_password, password_confirmation: password_confirmation) {[weak self] (_ error: Error?, _ result: SuccessError_Model?) in
            self?.UserProfileViewDelegate?.UserProfileChangePasswordResult(error, result)
            self?.dismissIndicator()
        }
    }
    
    func getNotifications() {
        
        self.showIndicator()
        services.getNotifications { [weak self](error, notification) in
            self?.UserProfileViewDelegate?.getNotifications(error, notification)
            self?.dismissIndicator()
        }
    }
    
    func Editprofile(name:String , phone: String , address : String , email : String) {
        
        self.showIndicator()
        services.postUserEditProfile(phone: phone, name_ar: name, email: email, address: address) { [weak self] (error, message, user) in
            
            self?.UserProfileViewDelegate?.getUserProfileUpdated(error, message, user)
            self?.dismissIndicator()
            
        }
        
        
    }
}

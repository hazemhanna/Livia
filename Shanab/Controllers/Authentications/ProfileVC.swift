//
//  ProfileVC.swift
//  Shanab
//
//  Created by mac on 2/5/1442 AH.
//  Copyright © 1442 AH Dtag. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    private let UserProfileVCPresenter = UserProfilePresenter(services: Services())
    var profile = [User]()
    lazy var subViewControllers: [UIViewController] = {
        return [
            UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(identifier: "ProfileVC") as! ProfileVC, UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(identifier: "NotificationsVC") as! NotificationsVC,
            UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(identifier: "UserProfileChangePasswordVC") as! UserProfileChangePasswordVC
        ]
    } ()
     override func viewDidLoad() {
        super.viewDidLoad()
//        dataSource = self
//        delegate = self
        //setViewControllerFromIndex(index: 0)
        UserProfileVCPresenter.setUserProfileViewDelegate(UserProfileViewDelegate: self)
        UserProfileVCPresenter.showIndicator()
        UserProfileVCPresenter.getUserProfile()
    }
    
    
    
}
extension ProfileVC: UserProfileViewDelegate {
    func getUserProfileResult(_ error: Error?, _ result: User?) {
        if let profile = result {
            let personal = profile.personal ?? Personal()
            self.email.text = personal.email ?? ""
            if "lang".localized == "ar" {
                self.name.text = profile.nameAr ?? ""
            } else {
                self.name.text = profile.nameEn ?? ""
            }
            self.phone.text = profile.phone ?? ""
            self.address.text = profile.address ?? ""
            //            if let image = profile.image {
            //                guard let url = URL(string: BASE_URL + "/" + image) else { return }
            //                self.profilePic.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "logo-2"))
            //            }
        }
    }
    
    func UserChangeProfileResult(_ error: Error?, _ result: SuccessError_Model?) {
        
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "done", message: resultMsg.successMessage, status: .success, forController: self)
                UserProfileVCPresenter.dismissIndicator()
            } else if resultMsg.image != [""] {
                displayMessage(title: "try agine", message: resultMsg.image[0], status: .error, forController: self)
                
            }
        }
    }
//    func setViewControllerFromIndex(index: Int) {
//        self.showDetailViewControllers(pageViewController(<#T##pageViewController: UIPageViewController##UIPageViewController#>, viewControllerAfter: <#T##UIViewController#>)
//    }
//
}
//extension ProfileVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        return subViewControllers.count
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        let currentIndex: Int = subViewControllers.index(after: viewController) ?? 0
//        if currentIndex <= 0 {
//            return nil
//        }
//        return subViewControllers[currentIndex-1]
//    }
//
//
//
//}

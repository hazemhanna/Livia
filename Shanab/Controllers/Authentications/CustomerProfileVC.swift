//
//  CustomerProfileVC.swift
//  Shanab
//
//  Created by Macbook on 3/29/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class CustomerProfileVC: UIViewController {
    @IBOutlet weak var ProfileCollectionView: UICollectionView!
    //    let picker = UIImagePickerController()
    @IBOutlet weak var ProfileTableView: UITableView! {
        didSet {
            DispatchQueue.main.async {
                self.ProfileTableView.reloadData()
            }
        }
    }
    private let  ProileVCPresenter = UserProfilePresenter(services: Services())
    //    var profile = [User]()
    fileprivate let cellIdentifier = "ProfileCell"
    fileprivate let  CustomerProfileCellIdentifier = "CustomerProfileCell"
    private let PasswordIdentifier = "PasswordCell"
    private let NotificationIdentifier = "NotificationsCell"
    var SelectedItem = 0
    var profileArr = [ProfileModel]() {
        didSet {
            DispatchQueue.main.async {
                self.ProfileCollectionView.reloadData()
            }
        }
    }
    
    private var profile: User?
    var NotificationArr = [Notifications]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProileVCPresenter.setUserProfileViewDelegate(UserProfileViewDelegate: self)
        ProileVCPresenter.viewDidLoad()
        ProfileCollectionView.delegate = self
        ProfileCollectionView.dataSource = self
        ProfileTableView.delegate = self
        ProfileTableView.dataSource = self
        ProfileCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        ProfileTableView.register(UINib(nibName: CustomerProfileCellIdentifier, bundle: nil), forCellReuseIdentifier: CustomerProfileCellIdentifier)
        ProfileTableView.register(UINib(nibName: PasswordIdentifier, bundle: nil), forCellReuseIdentifier: PasswordIdentifier)
        ProfileTableView.register(UINib(nibName: NotificationIdentifier, bundle: nil), forCellReuseIdentifier: NotificationIdentifier)
        ProfileTableView.tableFooterView = UIView()
        if "lang".localized == "en" {
            self.profileArr = [ ProfileModel(name: "Profile", id: "profile", selected: false, profileImage: #imageLiteral(resourceName: "ic_person_24px")), ProfileModel(name: "ChangePassword", id: "ChangePassword", selected: false, profileImage: #imageLiteral(resourceName: "password")), ProfileModel(name: "Notifications", id: "Notifications", selected: false, profileImage: #imageLiteral(resourceName: "turn-notifications-on-button"))
            ]
        } else {
            self.profileArr = [ ProfileModel(name: "الملف الشخصي", id: "profile", selected: false, profileImage: #imageLiteral(resourceName: "ic_person_24px")), ProfileModel(name: "الباسورد", id: "ChangePassword", selected: false, profileImage: #imageLiteral(resourceName: "password")), ProfileModel(name: "الاشعارات", id: "Notifications", selected: false, profileImage: #imageLiteral(resourceName: "turn-notifications-on-button"))
            ]
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ProfileTableView.reloadData()
    }
    
    @IBAction func menu(_ sender: Any) {
        
        self.setupSideMenu()
    }
    @IBAction func cart(_ sender: Any) {
        guard let window = UIApplication.shared.keyWindow else { return }

        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
        
        details.selectedIndex = 2
        window.rootViewController = details    }
    private  func validate(newPassword: String, oldPassword: String, passwordConfirmation: String) -> Bool {
        
        if newPassword.isEmpty {
            displayMessage(title: "", message: "", status: .error, forController: self)
            return false
        } else if passwordConfirmation.isEmpty {
            displayMessage(title: "", message: "", status: .error, forController: self)
            return false
        } else if oldPassword.isEmpty {
            displayMessage(title: "", message: "", status: .error, forController: self)
            return false
        } else {
            return true
        }
    }
    
    
    
    
    func SelectionAction(indexPath: IndexPath) {
        switch profileArr[indexPath.row].profileId {
        case "profile":
            guard let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as? CustomerProfileVC else { return }
            
            self.navigationController?.pushViewController(vc, animated: true)
        case "ChangePassword":
            guard UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "PasswordCell") is PasswordCell else { return }
        case "Notifications":
            guard let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
            
            self.navigationController?.pushViewController(vc, animated: true)
        case "TermsAndConditions": break
        default:
            break
        }
        
    }
    func pushProfile(StoryboardName name: String,ForController identifier: String) {
        let main = UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
        
        self.navigationController?.pushViewController(main, animated: true)
    }
    func selectedCell(index: IndexPath) {
        switch profileArr[index.row].profileId  {
        case "Profile":
            pushProfile(StoryboardName: "Profile", ForController: "CustomerProfileVC")
        case "Notifications":
            pushProfile(StoryboardName: "Profile", ForController: "NotificationsVC")
        case "ChangePassword":
            pushProfile(StoryboardName: "Profile", ForController: "UserProfileChangePasswordVC")
        default:
            break
        }
    }
    
    
}

extension CustomerProfileVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ProfileCell else {return UICollectionViewCell()}
        let profileImage = profileArr[indexPath.row].profileImage
        cell.config(name: profileArr[indexPath.row].ProfileName, selected: profileArr[indexPath.row].ProfileSelected, imagePath: profileImage)
        cell.selectedBackgroundView?.backgroundColor = .clear
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SelectedItem = indexPath.item
        if indexPath.row == 2 {
            
            self.ProileVCPresenter.getNotifications()
        }
        self.ProfileTableView.reloadData()
        //        for i in 0...profileArr
        //            .count - 1 {
        //            if i == indexPath.row  {
        //                profileArr[i].ProfileSelected = true
        //            } else {
        //                profileArr[i].ProfileSelected = false
        //            }
        //        }
        //        ProfileCollectionView.reloadData()
        //        selectedCell(index: indexPath)
    }
    
    
}



extension CustomerProfileVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width + space) / 3.1
        return CGSize(width: size  , height: size )
    }
    
}




extension CustomerProfileVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if SelectedItem == 0 {
            let cell = ProfileTableView.dequeueReusableCell(withIdentifier: "CustomerProfileCell", for: indexPath) as! CustomerProfileCell
            cell.config(name: profile?.nameAr ?? "", email: profile?.personal?.email ?? "", address: Constants.address ?? "", phone: profile?.phone ?? "")
            cell.profile = profile
            cell.Save = {
                
                self.ProileVCPresenter.Editprofile(name: cell.Name.text ?? "", phone: cell.Phone.text ?? "", address: cell.Address.title(for: .normal) ?? "", email: cell.Email.text ?? "")
                
            }
            
            cell.AddressMap = {
                
                guard let sb = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "LocationVC") as? LocationVC else {return}
                self.navigationController?.pushViewController(sb, animated: true)
            }
            
            return cell
        } else if SelectedItem == 1 {
            let cell = ProfileTableView.dequeueReusableCell(withIdentifier: "PasswordCell", for: indexPath) as? PasswordCell
            cell?.config(oldPassword: "", newPassword: "", confirmationPassword: "")
            cell?.strongPassword = {
                let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "StrongPasswordPopupVC")
                sb.modalPresentationStyle = .overCurrentContext
                sb.modalTransitionStyle = .crossDissolve
                self.present(sb, animated: true, completion: nil)
                
            }
            cell?.Save = {
                let password = cell?.newPasswordTF.text
                let oldPassword = cell?.oldPasswordTF.text
                let confirmationPassword = cell?.newPasswordConfirmationTF.text
                guard self.validate(newPassword: password ?? "", oldPassword: oldPassword ?? "", passwordConfirmation: confirmationPassword ?? "") else { return }
                self.ProileVCPresenter.showIndicator()
                self.ProileVCPresenter.postUserProfileChangePassword(password: password ?? "", old_password: oldPassword ?? "", password_confirmation: confirmationPassword ?? "")
                
            }
            
            return cell!
        } else  if SelectedItem == 2 {
            let cell = ProfileTableView.dequeueReusableCell(withIdentifier: "NotificationsCell", for: indexPath) as! NotificationsCell
            
            let data = NotificationArr[indexPath.row]
            cell.config(name: data.title ?? "", status: data.body ?? "")
            return cell
        } else {return UITableViewCell()}
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if SelectedItem == 0 {
            return 400
        } else if SelectedItem == 1 {
            return 350
        } else {
            return 90
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if SelectedItem == 0 {
            return 1
        } else if SelectedItem == 1{
            return 1
        } else {
            return NotificationArr.count
        }
    }
}


extension CustomerProfileVC: UserProfileViewDelegate {
    
    
    func getUserProfileUpdated(_ error: Error?, _ message: SuccessError_Model?, _ result: User?) {
        
        if let Msg = message {
            
            if Msg.name != [""] {
                displayMessage(title: "", message: Msg.name[0], status: .error, forController: self)
            } else if Msg.address != [""] {
                displayMessage(title: "", message: Msg.address[0], status: .error, forController: self)
            } else if Msg.email != [""] {
                displayMessage(title: "", message: Msg.email[0], status: .error, forController: self)
            }
        } else if let err = error {
            displayMessage(title: "", message: err.localizedDescription, status: .error, forController: self)
        } else if let res = result {
            self.profile = res
            Constants.address = profile?.address ?? "No address for this user".localized
            ProfileTableView.reloadData()
        }
    }
    
    func getNotifications(_ error: Error?, _ notifications: [Notifications]?) {
        
        NotificationArr = notifications ?? []
        self.ProfileTableView.reloadData()
    }
    
    func UserProfileChangePasswordResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "", message: "", status: .success, forController: self)
            } else if resultMsg.old_password != [""] {
                displayMessage(title: "", message: "", status: .error, forController: self)
            } else if resultMsg.password != [""] {
                displayMessage(title: "", message: "", status: .error, forController: self)
            } else if resultMsg.password_confirmation != [""] {
                displayMessage(title: "", message: "", status: .error, forController: self)
            }
        }
    }
    
    func getchingAllData(_ profile: User?, _ restaurants: [Restaurant]?) {
        self.profile = profile
        Constants.address = profile?.address ?? "No address for this user".localized
        
        ProfileTableView.reloadData()
        
        
    }
    
    func UserChangeProfileResult(_ error: Error?, _ result: SuccessError_Model?) {
        
    }
    
    func getUserProfileResult(_ error: Error?, _ result: User?) {
        
    }
    
    
    
    
}

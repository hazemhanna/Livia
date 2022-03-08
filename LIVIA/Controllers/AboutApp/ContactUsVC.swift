//
//  ContactUsVC.swift
//  Shanab
//
//  Created by Macbook on 3/25/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import DropDown
import MessageUI
class ContactUsVC: UIViewController {
    
    @IBOutlet weak var socialMediaCollectionView: UICollectionView!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var messageDetails: UITextField!
    @IBOutlet weak var messageAddress: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    
    
    fileprivate let  cellIdentifeir = "SettingCell"
    let TypeArr = ["Complain".localized, "Proposal".localized]
    var MailType = ""
    var UserType = ""
    var id = Int()
    var selections = [String]()

    let MessageTypeDropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupMessageTypeDropDown()
        socialMediaCollectionView.delegate = self
        socialMediaCollectionView.dataSource = self
        socialMediaCollectionView.register(UINib(nibName: cellIdentifeir, bundle: nil), forCellWithReuseIdentifier: cellIdentifeir)
      
    }
    func SetupMessageTypeDropDown() {
        MessageTypeDropDown.anchorView = messageAddress
        MessageTypeDropDown.bottomOffset = CGPoint(x: 0, y: MessageTypeDropDown.anchorView?.plainView.bounds.height ?? 0 + 50)
        MessageTypeDropDown.dataSource = TypeArr
        MessageTypeDropDown.selectionAction = {
            [weak self] (index, item) in
            self?.messageAddress.setTitleColor(#colorLiteral(red: 0.9195484519, green: 0.2682709396, blue: 0.21753335, alpha: 1), for: .normal)
            self?.messageAddress.setTitle(item, for: .normal)
            if index == 0 {
                self?.MailType = "complain"
            } else if index == 1 {
                
                self?.MailType = "proposal"

            }
            
        }
        MessageTypeDropDown.direction = .any
        MessageTypeDropDown.width = self.view.frame.width * 1
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
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func cart(_ sender: Any) {
        guard let window = UIApplication.shared.keyWindow else { return }

        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
        
        details.selectedIndex = 2
        window.rootViewController = details
        
    }
    
    @IBAction func send(_ sender: Any) {
        
        
         print(email.text?.isValidEmail())
        
        if email.text == "" {
            
            displayMessage(title: "", message: "Enter Your Email".localized, status: .error, forController: self)
        } else if email.text?.isValidEmail() == false {
            
            displayMessage(title: "", message: "Email is invalid".localized, status: .error, forController: self)

            
        } else if phone.text == "" {
            
            displayMessage(title: "", message: "Enter Your phone number".localized, status: .error, forController: self)
        } else if name.text == "" {
            
            displayMessage(title: "", message: "Enter Your name".localized, status: .error, forController: self)
        } else if MailType == "" {
            
            displayMessage(title: "", message: "Choose the message address".localized, status: .error, forController: self)
        } else if messageDetails.text == ""{
            
            displayMessage(title: "", message: "Enter message".localized, status: .error, forController: self)
            
            
        } else if (Helper.getApiToken() ?? "") == "" {
            displayMessage(title: "", message: "You should login first".localized, status: .error, forController: self)
            
            
        }else{
            
        }
        
    }
    
    @IBAction func messageType(_ sender: UIButton) {
        MessageTypeDropDown.show()
    }
    
    func sendEmail(email: String) {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setMessageBody("", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
            displayMessage(title: "", message: "Please Add your an Email to your device first", status: .error, forController: self)
            print("Please check the email.")
        }
    }
}

extension ContactUsVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error{
            print("error \(error.localizedDescription)")
            controller.dismiss(animated: true)
        }
        switch result {
        case .cancelled:
            print("cancelled")
        case .sent:
            print("sent")
            if "lang".localized == "ar" {
                displayMessage(title: "", message: "تم الإرسال", status: .success, forController: self)
            } else {
                displayMessage(title: "", message: "Message Sent", status: .success, forController: self)
            }
            
        case .failed:
            print("faild")
            if "lang".localized == "ar" {
                displayMessage(title: "", message: "فشل الإرسال", status: .error, forController: self)
            } else {
                displayMessage(title: "", message: "Message Failed To Send", status: .error, forController: self)
            }
            
        case .saved:
            print("saved")
            if "lang".localized == "ar" {
                displayMessage(title: "", message: "تم حفظ الرسالة", status: .success, forController: self)
            } else {
                displayMessage(title: "", message: "Message Saved", status: .success, forController: self)
            }
            
        @unknown default:
            fatalError()
        }
        controller.dismiss(animated: true)
        
    }
}
extension ContactUsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifeir, for: indexPath) as? SettingCell else {return UICollectionViewCell()}
        
        if indexPath.row == 0{
            cell.config(imagePath: #imageLiteral(resourceName: "facebook"))
        }else if indexPath.row == 1{
            cell.config(imagePath: #imageLiteral(resourceName: "facebook (-1"))
        }else if indexPath.row == 2{
            cell.config(imagePath: #imageLiteral(resourceName: "Insta"))
        }else if indexPath.row == 3{
            cell.config(imagePath: #imageLiteral(resourceName: "snapchat (2)"))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ContactUsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 4.2
        return CGSize(width: size, height: 70)
    }
    
}




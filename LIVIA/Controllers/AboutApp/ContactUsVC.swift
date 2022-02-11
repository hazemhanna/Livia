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
    private let MailTemplateVCPresenter = MailTempaltePresenter(services: Services())
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
    var mailTempalte = [Tempalte]()
    var sectionArr = [Setting]() {
        didSet {
            DispatchQueue.main.async {
                self.socialMediaCollectionView.reloadData()
                
            }
        }
    }
    let MessageTypeDropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupMessageTypeDropDown()
        socialMediaCollectionView.delegate = self
        socialMediaCollectionView.dataSource = self
        socialMediaCollectionView.register(UINib(nibName: cellIdentifeir, bundle: nil), forCellWithReuseIdentifier: cellIdentifeir)
        MailTemplateVCPresenter.setMailTempalteViewDelegate(MailTempalteViewDelegate: self)
        MailTemplateVCPresenter.showIndicator()
        sectionArr.removeAll()
        MailTemplateVCPresenter.getSettings()
        MailTemplateVCPresenter.getUserProfile()

        let customer_type = Helper.getUserRole()
        //email.isEnabled = false
        //email.text = Helper.getemail()
        
        if customer_type == "customer" {
            
            UserType = "client"
        } else {
            
            UserType = "driver"
        }
        
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
    func SelectionAction(index: Int) {
        switch sectionArr[index].key  {
        case "twitter":
            let userName = sectionArr[index].valueAr ?? ""
            
            let appURL = URL(string: "twitter:///\(userName)")!
            let webURL = URL(string: "https://twitter.com/\(userName)")!
            if UIApplication.shared.canOpenURL(appURL as URL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            } else {
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(webURL)
                } else {
                    UIApplication.shared.openURL(webURL)
                }
            }
        case "facebook":
            let facebook = sectionArr[index].valueAr ?? ""
            let urlFacebook = "https://wa.me/\(facebook)"
            if let urlString = urlFacebook.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
                if let facebookURL = URL(string: urlString) {
                    if UIApplication.shared.canOpenURL(facebookURL){
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(facebookURL, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(facebookURL)
                        }
                    }
                    else {
                        displayMessage(title: "", message: "Install Facebook First", status: .info, forController: self)
                    }
                }
            }
        case "instagram":
            let instagram = sectionArr[index].valueAr ?? ""
            let urlinstagram = "https://wa.me/\(instagram)"
            if let urlString = urlinstagram.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
                if let instgramURL = URL(string: urlString) {
                    if UIApplication.shared.canOpenURL(instgramURL){
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(instgramURL, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(instgramURL)
                        }
                    }
                    else {
                        displayMessage(title: "", message: "Install Instagram First", status: .info, forController: self)
                    }
                }
            }
            
        default:
            print("Default")
            break
            
        }
    }
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func cart(_ sender: Any) {
        guard let window = UIApplication.shared.keyWindow else { return }

        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
        
        details.selectedIndex = 2
        window.rootViewController = details    }
    
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
            
            
        } else {
            
            
            MailTemplateVCPresenter.showIndicator()
            
            MailTemplateVCPresenter.SendEmail(email: email.text!, phone: phone.text!, name: name.text!, type: MailType, kind: UserType, message: messageDetails.text!)
        }
        
        
        //MailTemplateVCPresenter.getmailTemalte(type: "client")
        
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
        return sectionArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifeir, for: indexPath) as? SettingCell else {return UICollectionViewCell()}
        
        print(sectionArr[indexPath.row].SettingImage)
        
        if let img = sectionArr[indexPath.row].SettingImage {
        
            cell.config(imagePath: UIImage(data: img) ?? #imageLiteral(resourceName: "shanab loading"))
        }
        cell.selectionAction = {
            self.SelectionAction(index: indexPath.row)
        }
        
        return cell
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SelectionAction(index: indexPath.row)
    }
    
    
}
extension ContactUsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 5
        return CGSize(width: size, height: size)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      

        let CellWidth = CGFloat((collectionView.frame.size.width - 20) / 5)
            
        
        let totalCellWidth = CellWidth * CGFloat(sectionArr.count)
        let totalSpacingWidth = 10 * CGFloat(sectionArr.count - 1)

        let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
}


extension ContactUsVC: MailTempalteViewDelegate {
    
    func getProfileResult(_ error: Error?, _ result: User?) {
        if Helper.getUserRole() == "customer" {
            if let profile = result {
                self.name.text = profile.nameAr ?? ""
                self.email.text = profile.personal?.email ?? ""
                self.phone.text = profile.phone ?? ""
            } else {
                if let profile = result {
                    self.name.text = profile.nameAr ?? ""
                    self.email.text = profile.personal?.email ?? ""
                    self.phone.text = profile.phone ?? ""
                }
            }
        }
    }
    
    func CreateEmail(_ error: Error?, _ result: SuccessError_Model?) {
        
        if result?.successMessage != "" {
            
            displayMessage(title: "", message: "Your message was sent".localized, status: .success, forController: self)
            
            self.name.text = ""
            self.messageDetails.text = ""
            self.email.text = ""
            self.SetupMessageTypeDropDown()
            self.MailType = ""
            self.phone.text = ""
            
        } else {
            
            displayMessage(title: "", message: result?.errorMessage ?? "", status: .error, forController: self)
        }
        
        
        
        self.viewDidLoad()
    }
    
   
    
    func SupprortingResult(_ error: Error?, _ result: [Setting]?) {
        guard var settings = result else{ return }
        
        for i in 0..<settings.count {
            switch settings[i].key {
            case "facebook":
                settings[i].SettingImage = #imageLiteral(resourceName: "facebook").pngData()
            case "twitter":
                settings[i].SettingImage = #imageLiteral(resourceName: "twitter").pngData()
            case "instagram":
                settings[i].SettingImage = #imageLiteral(resourceName: "Insta").pngData()
            default:
                    break
            }
        }
        
        for i in 0..<settings.count {
            
            if settings[i].SettingImage != nil {
                
                self.sectionArr.append(settings[i])
            }
        }
        self.socialMediaCollectionView.reloadData()
    }
    
    func mailTempalteResult(_ error: Error?, _ result: [Tempalte]?) {
        //        if let lists = result {
        //            self.mailTempalte = lists[0].inputType ?? ""
        //        }
    }
}


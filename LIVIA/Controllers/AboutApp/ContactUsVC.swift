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
import RxSwift
import RxCocoa

class ContactUsVC: UIViewController {
    
    @IBOutlet weak var socialMediaCollectionView: UICollectionView!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var messageDetails: UITextField!
    @IBOutlet weak var messageAddress: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    
    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    
    fileprivate let  cellIdentifeir = "SettingCell"
    let TypeArr = ["Complain".localized, "Proposal".localized]
    var MailType = ""
    
    var facebook  = ""
    var whatsapp  = ""
    var twitter  = ""
    var snapchat  = ""
    
    let MessageTypeDropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupMessageTypeDropDown()
        socialMediaCollectionView.delegate = self
        socialMediaCollectionView.dataSource = self
        socialMediaCollectionView.register(UINib(nibName: cellIdentifeir, bundle: nil), forCellWithReuseIdentifier: cellIdentifeir)
        getProfile()
    }
    
    func SetupMessageTypeDropDown() {
        MessageTypeDropDown.anchorView = messageAddress
        MessageTypeDropDown.bottomOffset = CGPoint(x: 0, y: MessageTypeDropDown.anchorView?.plainView.bounds.height ?? 0 + 50)
        MessageTypeDropDown.dataSource = TypeArr
        MessageTypeDropDown.selectionAction = {[weak self] (index, item) in
            self?.messageAddress.setTitle(item, for: .normal)
            if index == 0 {
                self?.MailType = "problem"
            }else{
                self?.MailType = "suggestion"
            }
        }
        MessageTypeDropDown.direction = .any
        MessageTypeDropDown.width = 200
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
    
    @IBAction func send(_ sender: Any) {
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
            self.AuthViewModel.showIndicator()
            self.contactUs(subject: MailType)
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
    
    func DataBinding() {
        _ = name.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.name).disposed(by: disposeBag)
        _ = email.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.email).disposed(by: disposeBag)
        _ = messageDetails.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.message).disposed(by: disposeBag)
        _ = phone.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.phone).disposed(by: disposeBag)
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
    
    func openlink (link : String){
        guard let url = URL(string: link) else {return}
        UIApplication.shared.open(url)
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
            cell.config(imagePath: #imageLiteral(resourceName: "whatsapp"))
        }else if indexPath.row == 2{
            cell.config(imagePath: #imageLiteral(resourceName: "twitter (2)"))
        }else if indexPath.row == 3{
            cell.config(imagePath: #imageLiteral(resourceName: "snapchat (2)"))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            self.openlink(link: self.facebook)
        }else if indexPath.row == 1{
            self.openlink(link: self.whatsapp)
        }else if indexPath.row == 2{
            self.openlink(link: self.twitter)
        }else if indexPath.row == 3{
            self.openlink(link: self.snapchat)
        }
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

extension ContactUsVC {
    func getProfile() {
        self.AuthViewModel.getProfile().subscribe(onNext: { (data) in
            self.AuthViewModel.dismissIndicator()
            self.getSetting()
            self.name.text = data.data?.name ?? ""
            self.email.text = data.data?.email ?? ""
            self.phone.text = data.data?.phone ?? ""
            self.DataBinding()

            }, onError: { (error) in
                self.AuthViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
     }
    
    func contactUs(subject : String) {
        self.AuthViewModel.contactUs(subject:subject).subscribe(onNext: { (data) in
            self.AuthViewModel.dismissIndicator()
            if data.value ?? false {
            displayMessage(title: "", message: "Contact Send Done".localized , status: .success, forController: self)
            self.navigationController?.popViewController(animated: true)
            }
            },onError: { (error) in
          self.AuthViewModel.dismissIndicator()
        }).disposed(by: disposeBag)
     }
    
    func getSetting() {
        self.AuthViewModel.getSetting().subscribe(onNext: { (data) in
            
            self.AuthViewModel.dismissIndicator()
            self.whatsapp = data.data.settings.whatsapp ?? ""
            self.facebook = data.data.settings.facebook ?? ""
            self.twitter = data.data.settings.twitter ?? ""
            self.snapchat = data.data.settings.snapshat ?? ""
            
        }, onError: { (error) in
                self.AuthViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
     }
    
}

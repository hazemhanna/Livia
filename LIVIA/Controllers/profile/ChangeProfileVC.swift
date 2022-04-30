//
//  ChangeProfileVC.swift
//  Livia
//
//  Created by MAC on 16/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

class ChangeProfileVC: UIViewController {
    
    @IBOutlet weak var name: CustomTextField!
    @IBOutlet weak var phone: CustomTextField!
    @IBOutlet weak var email: CustomTextField!
    @IBOutlet weak var address: CustomTextField!
    @IBOutlet weak var titleLbl  : UILabel!
    @IBOutlet weak var uploadedImage: UIImageView!
    @IBOutlet weak var profilePicbtn : UIButton!
    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = "changeProfile".localized
        profilePicbtn.setTitle("changeProfilePic".localized, for: .normal)

        AuthViewModel.showIndicator()
        getProfile()
    }
    
    @IBAction func popUpAction(_ sender: UIButton) {
        guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfilePopUp") as? ProfilePopUp else {return}
        sb.goToWallet = {
            guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "WalletVc") as? WalletVc else {return}
            self.navigationController?.pushViewController(sb, animated: true)
        }
        sb.goTochangePassword = {
            guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileChangePasswordVC") as? ProfileChangePasswordVC else {return}
            self.navigationController?.pushViewController(sb, animated: true)
        }
        self.present(sb, animated: true, completion: nil)
     
        sb.goToNotification = {
            guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "notificationProfileVC") as? notificationProfileVC else {return}
            self.navigationController?.pushViewController(sb, animated: true)
        }
        
        sb.goTochangeProfile = {
            guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ChangeProfileVC") as? ChangeProfileVC else {return}
            self.navigationController?.pushViewController(sb, animated: true)
        }
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    func DataBinding() {
        _ = name.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.name).disposed(by: disposeBag)
        _ = email.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.email).disposed(by: disposeBag)
        _ = address.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.address).disposed(by: disposeBag)
        _ = phone.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.phone).disposed(by: disposeBag)
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "ScanVc") as? ScanVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    

    @IBAction func searchButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }

    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
    @IBAction func savePressed(_ sender: Any) {
        self.AuthViewModel.showIndicator()
        updateProfile()
    }
    
    @IBAction func chageProfilePicAction(_ sender: UIButton) {
        showImageActionSheet()
    }
    
}

extension ChangeProfileVC {
    
    func getProfile() {
        self.AuthViewModel.getProfile().subscribe(onNext: { (data) in
            self.AuthViewModel.dismissIndicator()
            self.name.text = data.data?.name ?? ""
            self.phone.text = data.data?.phone ?? ""
            self.email.text = data.data?.email ?? ""
            self.address.text = data.data?.address ?? ""
            guard let imageURL = URL(string: (data.data?.avatar ?? "" ).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
              self.uploadedImage.kf.setImage(with: imageURL)
            
            self.DataBinding()
            }, onError: { (error) in
                self.AuthViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
     }
    
    func updateProfile() {
        self.AuthViewModel.updateProfile().subscribe(onNext: { (data) in
          self.getProfile()
        }, onError: { (error) in
            self.AuthViewModel.dismissIndicator()
        }).disposed(by: disposeBag)
     }
    
    func updateAvatar(image : UIImage) {
        AuthViewModel.showIndicator()
        self.AuthViewModel.updateAvatar(image: image).subscribe(onNext: { (data) in
            self.AuthViewModel.dismissIndicator()
        }, onError: { (error) in
            self.AuthViewModel.dismissIndicator()
        }).disposed(by: disposeBag)
     }
    
}

extension ChangeProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImageActionSheet() {
        let chooseFromLibraryAction = UIAlertAction(title: "Choose from Library", style: .default) { (action) in
                self.showImagePicker(sourceType: .photoLibrary)
            }
            let cameraAction = UIAlertAction(title: "Take a Picture from Camera", style: .default) { (action) in
                self.showImagePicker(sourceType: .camera)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            AlertService.showAlert(style: .actionSheet, title: "Pick Your Picture", message: nil, actions: [chooseFromLibraryAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        imagePickerController.mediaTypes = ["public.image"]
        imagePickerController.view.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            AuthViewModel.showIndicator()
            self.uploadedImage.image = editedImage
            updateAvatar(image: editedImage)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            AuthViewModel.showIndicator()
           self.uploadedImage.image = originalImage
            updateAvatar(image: originalImage)

        }
        dismiss(animated: true, completion: nil)
    }
}





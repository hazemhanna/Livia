//
//  PreviousListVC.swift
//  Shanab
//
//  Created by Macbook on 4/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import DropDown

enum OrdersTypeE {
    
    case completed
    case other
}

class DriverOrderListVC: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var DriverName: UILabel!
    @IBOutlet weak var orderType: UIButton!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var phoneLB: UILabel!
    @IBOutlet weak var orderNumber : UILabel!
    @IBOutlet weak var orderNumber2 : UILabel!
    
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var notificationBtn: UIButton!
    
    @IBOutlet weak var DriverListCollectionView: UICollectionView!
    @IBOutlet weak var PreviousTableView: UITableView!
    @IBOutlet weak var available: UIButton!

    let DriverStatusDropDown = DropDown()
    var orderSelected : OrdersTypeE = .completed
    var ChangeAvailablity = String()
    var isAvailable = Int()
    var type = "new"
    let TypesArr = ["new", "OnWay", "Arrived", "completed"]
    let StatusArr = ["Available".localized, "Unavailable".localized]
    fileprivate let cellIdentifier = "DriverListCell"
    
    var id = Int()
    var homePage = true
    
    private let DriverProfileVCPresenter = DriverProfilePresenter(services: Services())
    let picker = UIImagePickerController()
    var SelectedIndex = -1
    var list = [OrderList]() {
        didSet {
            DispatchQueue.main.async {
              //  self.DriverListCollectionView.reloadData()
            }
        }
    }
    
    var isFatching = false
    var currentPage = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.setRounded()
        DriverProfileVCPresenter.setDriverProfileViewDelegate(DriverProfileViewDelegate: self)
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(ProfileImageView(_:))))
        DriverListCollectionView.delegate = self
        DriverListCollectionView.dataSource = self
        DriverListCollectionView.prefetchDataSource = self
        DriverListCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        DriverProfileVCPresenter.setDriverProfileViewDelegate(DriverProfileViewDelegate: self)
        DriverProfileVCPresenter.showIndicator()
        DriverProfileVCPresenter.getDriverProfile()
        
        
        PreviousTableView.delegate = self
        PreviousTableView.dataSource = self
        PreviousTableView.prefetchDataSource = self
        
        
        PreviousTableView.register(UINib(nibName: "PreviousOrders", bundle: nil), forCellReuseIdentifier: "PreviousOrders")
        PreviousTableView.tableFooterView = UIView()
        
        if orderSelected == .completed {
            
            CompeteView.isHidden = true

            DriverProfileVCPresenter.DriverOrderList(type: ["new" , "delivering" , "delivered" , "preparing"], currentPage: currentPage )

        } else {
            CompeteView.isHidden = false
            DriverProfileVCPresenter.DriverOrderList(type: ["competed"] , currentPage: currentPage )

        }
        SetupDriverStatusDropDown()
        
        if homePage {
            titleLbl.text = "Shanab".localized
            notificationBtn.isHidden = false
        }else{
            titleLbl.text = "privouse Order".localized
            notificationBtn.isHidden = true
        }
        
    }
    
    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
        
    }

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
           if AppDelegate.notification_flag {
           let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "AgentChoicePopUp")
                  sb.modalPresentationStyle = .overCurrentContext
                  sb.modalTransitionStyle = .crossDissolve
                  self.present(sb, animated: true, completion: nil)
                  
        }
    }
    
    @IBAction func StatusBtn(_ sender: Any) {
        
        DriverStatusDropDown.show()
    }
    
    
    func SetupDriverStatusDropDown() {
        DriverStatusDropDown.anchorView = available
       // DriverStatusDropDown.topOffset = CGPoint(x: 0, y: DriverStatusDropDown.anchorView?.plainView.bounds.height ?? 0 + 50)
        DriverStatusDropDown.dataSource = StatusArr
        DriverStatusDropDown.selectionAction = {
            [weak self] (index, item) in
            self?.available.setTitleColor(#colorLiteral(red: 0.9195484519, green: 0.2682709396, blue: 0.21753335, alpha: 1), for: .normal)
            self?.available.setTitle(item.capitalized, for: .normal)
            self?.DriverProfileVCPresenter.showIndicator()
            self?.DriverProfileVCPresenter.getIsAvailableChange()
            
            self?.SelectedIndex = index
//            if self?.type ?? "" == "parpare" {
//                self?.DriverProfileVCPresenter.DriverOrderList(type: [self?.type ?? "parpare", "On Way", "Arrived", "completed"])
//            } else {
//                self?.DriverProfileVCPresenter.DriverOrderList(type: [self?.type ?? "parpare", "On Way", "Arrived", "completed"])
//            }
            
            
        }
        
        
        DriverStatusDropDown.direction = .any
        DriverStatusDropDown.width = self.view.frame.width * 1
    }
    @IBAction func perviousList(_ sender: Any) {
        guard let Details = UIStoryboard(name: "Orders", bundle: nil).instantiateViewController(withIdentifier: "OrderListVC") as? OrderListVC else { return }
                    
                  
                    self.navigationController?.pushViewController(Details, animated: true)
        
    }
    
    
    @IBOutlet weak var CompeteView: UIView!
    
    @IBAction func EditProfile(_ sender: UIButton) {
        guard let name = self.DriverName.text else { return }
//              guard let email = self.Email.text else { return }
              guard let phone = self.phoneLB.text else { return }
       
        DriverProfileVCPresenter.showIndicator()
//        DriverProfileVCPresenter.postEditDriverProfile(phone: phone, email: <#T##String#>, name_ar: name)
              
    }
    func showImagePickerView(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
        
    }
   
    @IBAction func cart(_ sender: Any) {
        guard let window = UIApplication.shared.keyWindow else { return }

        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
        
        details.selectedIndex = 2
        window.rootViewController = details
    }
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage ] as? UIImage
        {
            profileImage.image = editedImage
            DriverProfileVCPresenter.showIndicator()
            DriverProfileVCPresenter.postDriverChangeImage(image: editedImage)
            
        } else if let orignalImage =
            info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = orignalImage
            DriverProfileVCPresenter.showIndicator()
            DriverProfileVCPresenter.postDriverChangeImage(image: orignalImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func ProfileImageView(_ sender: UIButton) {
        showPickerImageControlActionSheet()
    }
    @objc fileprivate func profileImageView_Pressed(_ sender: UITapGestureRecognizer) {
        showPickerImageControlActionSheet()
        
    }
    
    
}

extension DriverOrderListVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showPickerImageControlActionSheet() {
      
            let PhotoLibraryAction = UIAlertAction(title: "Gallrey".localized, style: .default) { (action) in
                self.showImagePickerView(sourceType: .photoLibrary)
            }
            let cameraAction = UIAlertAction(title: "Camera".localized, style: .default) { (action) in
                self.showImagePickerView(sourceType: .camera)
            }
            let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
            
        let Delete = UIAlertAction(title: "Delete image".localized, style: .default) { (action) in
                self.DriverProfileVCPresenter.getDriverDeleteImage()
            }
            
            AlertService.showAlert(style: .actionSheet, title: "".localized, message: nil, actions: [PhotoLibraryAction, cameraAction, Delete ,cancelAction], completion: nil)
        }
}
extension DriverOrderListVC: DriverProfileViewDelegate {
    
    func orderNumber(_ error: Error?, _ order: OrdersNumber?) {
        let newString = order?.message
        let array = newString?.components(separatedBy: ":")
        if "lang".localized == "ar" {
            orderNumber.text = "عدد الطلبات السابقة :" + (array?.last ?? "")
            orderNumber2.text = "عدد الطلبات السابقة :" + (array?.last ?? "")
        }else {
            orderNumber.text = order?.message
            orderNumber2.text = order?.message
        }
    }
    
    
    func checkOrderPayment(_ error: Error?, _ order: OrderPaymentModelJSON?) {
        
    }
    
    
    func getNotifications(_ error: Error?, _ notifications: [Notifications]?) {
            return
    }
    
    func getDeleteImage(_ error: Error?, _ result: SuccessError_Model?) {
      
        
        if let result = result {
            
            displayMessage(title: "", message: "Image Deleted".localized, status: .error, forController: self)
            self.profileImage.image = #imageLiteral(resourceName: "Group 6")
        }
    }
    
    func postEditDriverProfileResult(_ error: Error?, _ result: SuccessError_Model?) {
         if let profile = result {
        if profile.successMessage != "" {
            displayMessage(title: "", message: profile.successMessage, status: .success, forController: self)
        } else if profile.name != [""] {
            displayMessage(title: "", message: profile.name[0], status: .error, forController: self)
        } else if profile.address != [""] {
            displayMessage(title: "", message: profile.address[0], status: .error, forController: self)
        } else if profile.email != [""] {
            displayMessage(title: "", message: profile.email[0], status: .error, forController: self)
            }
        }
    }
    func getDriverProfileResult(_ error: Error?, _ result: User?) {
        if let profile = result {
            DriverProfileVCPresenter.orderNumber(id: profile.id ?? 0)
            self.phoneLB.text = profile.phone ?? ""
            if "lang".localized == "ar" {
                 self.DriverName.text = profile.nameAr ?? ""
            } else {
                 self.DriverName.text = profile.nameEn ?? ""
                
            }
           
            if let image = profile.image {
                
                
                guard let url = URL(string: BASE_URL + "/" + image) else { return }
                self.profileImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "shanab loading"))

//                guard let url = URL(string: image) else { return }
            }
            
            if profile.is_available == 0 {
                
                self.available.setTitle("Unavailable".localized, for: .normal)
                self.available.setTitleColor(#colorLiteral(red: 0.9195484519, green: 0.2682709396, blue: 0.21753335, alpha: 1), for: .normal)
            } else {
                
                self.available.setTitle("Available".localized, for: .normal)
                self.available.setTitleColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), for: .normal)

            }
            
        }
        
    }
    
    func DriverOrderListResult(_ error: Error?, _ list: OrderListPagination?, _ orderErrors: OrdersErrors?) {
        if let lists = list {
            self.list.append(contentsOf: lists.order ?? [])
            if self.list.count == 0 {
                self.emptyView.isHidden = false
                self.DriverListCollectionView.isHidden = true
            } else {
                self.emptyView.isHidden = true
                self.DriverListCollectionView.isHidden = false
            }
            
            if orderSelected == .completed {
                
                DriverListCollectionView.reloadData()
                
                if lists.nextPageURL != nil {
                    
                    isFatching = false
                    currentPage += 1

                }


                
            } else {
                
                PreviousTableView.reloadData()

                if lists.nextPageURL != nil {
                    
                    isFatching = false
                    currentPage += 1

                }
            }
        }
        
    

        
    }
    
    func DriverChangeImageResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "", message: "Done".localized, status: .success, forController: self)
                DriverProfileVCPresenter.dismissIndicator()
                
                self.DriverProfileVCPresenter.getDriverProfile()
            } else if resultMsg.image != [""] {
                displayMessage(title: "try agine", message: resultMsg.image[0], status: .error, forController: self)
            }
        }
    }
    
    func DriverIsAvaliableChangeResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let profile = result {
            
            
            if self.SelectedIndex == 0 {
                
                self.available.setTitleColor(#colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1), for: .normal)

                
                
            } else {
                
                self.available.setTitleColor(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), for: .normal)
                
            }
            
        
        }
    }
}
extension DriverOrderListVC: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//          guard let Details = UIStoryboard(name: "Orders", bundle: nil).instantiateViewController(withIdentifier: "DriverOrderListVC") as? DriverOrderListVC else { return }
//               Details.id = list[indexPath.row].id ?? 0
//             Details.profileImage =  profileImage
//
//              self.navigationController?.pushViewController(Details, animated: true)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? DriverListCell else {return UICollectionViewCell()}
        let client = list[indexPath.row].client ?? Client()
        cell.config(Name: client.nameAr ?? "", imagePath: client.image ?? "", rate: Double(list[indexPath.row].rate ?? 0) , address: client.address ?? "",orderId : list[indexPath.row].id ?? 0 )
        
        cell.goToDetails = {
            guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "OrderReceiptVC") as? OrderReceiptVC else { return }
            Details.id = self.list[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(Details, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width / 2) - 10
        
        return CGSize(width: width, height: 300)
    }
    
    
}

extension DriverOrderListVC : UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        
        for index in indexPaths {
            
            
            
            if index.row >= list.count - 2  && !isFatching {
                
                
                print(index.row , "/////////////" , list.count)
                
                if orderSelected == .completed {
                   
                    isFatching = true
                    DriverProfileVCPresenter.DriverOrderList(type: ["new" , "delivering" , "delivered" , "preparing"], currentPage: currentPage )
                    break
                }
                
            }
        }
    }
    
}

extension DriverOrderListVC : UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for index in indexPaths {
            
            
            
            if index.row >= list.count - 2  && !isFatching {
                
                
                print(index.row , "/////////////" , list.count)
                
                if orderSelected == .completed {
                   
                    isFatching = true
                    DriverProfileVCPresenter.DriverOrderList(type: ["competed"],currentPage: currentPage )
                    break
                }
                
            }
        }

    }
    
    
    
}

extension DriverOrderListVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviousOrders") as! PreviousOrders
        
        let client = list[indexPath.row]
        
        cell.goToDetails = {
            guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "OrderReceiptVC") as? OrderReceiptVC else { return }
            Details.id = self.list[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(Details, animated: true)
        }
        
        cell.Name.text = list[indexPath.row].client?.nameAr
        
        cell.OrderImage.image = #imageLiteral(resourceName: "Group 6")
        
        cell.Date.text = list[indexPath.row].createdAt
        
        cell.Rate.rating = Double(list[indexPath.row].rate ?? 0)
        cell.Price.text = "\( (list[indexPath.row].total ?? 0.0).rounded(toPlaces: 2))" + "S.R".localized
        
     return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 175
    }
}


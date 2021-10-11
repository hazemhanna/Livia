//
//  ReservationRequestVC.swift
//  Shanab
//
//  Created by Macbook on 3/29/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import DropDown
import Urway


class ReservationRequestVC: UIViewController {
    
    var paymentController: UIViewController? = nil

    //    @IBOutlet weak var clock: Clocket!
    @IBOutlet weak var outing: UIButton!
//    @IBOutlet weak var AmOutlet: UIButton!
//    @IBOutlet weak var pmOutlet: UIButton!
    @IBOutlet weak var inDoor: UIButton!
    @IBOutlet weak var sessionLB: UILabel!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var numberCollectionView: UICollectionView!
    @IBOutlet weak var ListOfNumbers: UIButton!
    var resturant_id = Int()
    var fees = Double()
    private var DatePicker: UIDatePicker?
    private var timePicker: UIDatePicker?
    let NmberListDropDown = DropDown()
    var session = "inside"
    fileprivate let cellIdentifier = "ReservationCell"
    var list_type = Int()
    var selectedCount = String()
    let NumbersArr = ["6", "7", "8", "10", "11", "12", "13", "14", "15"]
    private let CreateResevationVCPresenter = CreateReservationPresenter(services: Services())
    var numberArr = [ReservationModel]() {
        didSet {
            DispatchQueue.main.async {
                self.numberCollectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var FeesBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CreateResevationVCPresenter.setCreateReservationViewDelegate(CreateReservationViewDelegate: self)
       
       // let loc = Locale(identifier: "en")
        var timePicker = UIDatePicker()
        timePicker = UIDatePicker()
       // timePicker.locale = loc
        timePicker.datePickerMode = .time
        timeTF.inputView = timePicker
        timePicker.addTarget(self, action: #selector(timeChanged(TimePicker:)), for: .valueChanged)

        if #available(iOS 13.4, *) {
                    timePicker.preferredDatePickerStyle = .wheels
                } else {
                    // Fallback on earlier versions
                }
        numberArr = [
            ReservationModel(number: 1, id: "1", selected: false),
            ReservationModel(number: 2, id: "2", selected: false),
            ReservationModel(number: 3, id: "3", selected: false),
            ReservationModel(number: 4, id: "4", selected: false),
            ReservationModel(number: 5, id: "5", selected: false)
           
        ]
        SetupNmberListDropDown()
        numberCollectionView.delegate = self
        numberCollectionView.dataSource = self
        numberCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        FeesBtn.setTitle("Please enter a deposit of ".localized + "\(fees) " + "S.R to confirm reservation".localized, for: .normal)
        
    }
    func SetupNmberListDropDown() {
        NmberListDropDown.anchorView = ListOfNumbers
        NmberListDropDown.bottomOffset = CGPoint(x: 0, y: NmberListDropDown.anchorView?.plainView.bounds.height ?? 0 + 50)
        NmberListDropDown.dataSource = NumbersArr
        NmberListDropDown.selectionAction = {
            [weak self] (index, item) in
            self?.ListOfNumbers.setTitleColor(#colorLiteral(red: 0.9195484519, green: 0.2682709396, blue: 0.21753335, alpha: 1), for: .normal)
            self?.ListOfNumbers.setTitle(item, for: .normal)
            self?.selectedCount = item
            
        }
        NmberListDropDown.direction = .any
        NmberListDropDown.width = self.view.frame.width * 0.25
    }
    @objc func timeChanged(TimePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")

        dateFormatter.dateFormat = "HH:mm:SS"
        timeTF.text = dateFormatter.string(from: TimePicker.date)
       // timeTF.isEnabled = false
        self.DatePicker?.datePickerMode = .time
        //        view.endEditing(true)
    }
   
    @IBAction func inDoor(_ sender: UIButton) {
        inDoor.backgroundColor = #colorLiteral(red: 0.9195484519, green: 0.2682709396, blue: 0.21753335, alpha: 1)
        outing.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.inDoor.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        self.outing.setTitleColor(#colorLiteral(red: 0.9195484519, green: 0.2682709396, blue: 0.21753335, alpha: 1), for: .normal)
        session = "inside"
    }
    
    @IBAction func session(_ sender: UIButton) {
        outing.backgroundColor = #colorLiteral(red: 0.9195484519, green: 0.2682709396, blue: 0.21753335, alpha: 1)
        inDoor.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.outing.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        self.inDoor.setTitleColor(#colorLiteral(red: 0.9195484519, green: 0.2682709396, blue: 0.21753335, alpha: 1), for: .normal)
        session = "outside"
        
    }
    
//    @IBAction func AmButtonPressed(_ sender: UIButton) {
//        AmOutlet.backgroundColor = #colorLiteral(red: 0.9195484519, green: 0.2682709396, blue: 0.21753335, alpha: 1)
//        pmOutlet.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        self.AmOutlet.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
//        self.AmOutlet.setTitleColor(#colorLiteral(red: 0.9195484519, green: 0.2682709396, blue: 0.21753335, alpha: 1), for: .selected)
//    }
//    
//    @IBAction func pmButtonPressed(_ sender: UIButton) {
//        pmOutlet.backgroundColor = #colorLiteral(red: 0.9195484519, green: 0.2682709396, blue: 0.21753335, alpha: 1)
//        AmOutlet.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        self.pmOutlet.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
//        self.pmOutlet.setTitleColor(#colorLiteral(red: 0.9195484519, green: 0.2682709396, blue: 0.21753335, alpha: 1), for: .selected)
//        
//    }
    
    
    @IBAction func NumberListBN(_ sender: UIButton) {
        NmberListDropDown.show()
    }
    @IBAction func paymentGatewayBn(_ sender: UIButton) {
        guard let sb = UIStoryboard(name: "PaymentGetWay", bundle: nil).instantiateViewController(withIdentifier: "PaymentGatewayVC") as? NumberListPopUp else {return}
        sb.modalPresentationStyle = .overCurrentContext
        sb.modalTransitionStyle = .crossDissolve
        self.present(sb, animated: true, completion: nil)
    }
    
    @IBAction func cart(_ sender: Any) {
//        guard let window = UIApplication.shared.keyWindow else { return }
//
//        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
//
//        details.selectedIndex = 2
//        window.rootViewController = details
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    @IBAction func cancelReservation(_ sender: UIButton) {
        guard let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "ReservationCancelltionVC") as? ReservationCancelltionVC else {return}
        self.navigationController?.pushViewController(sb, animated: true)
    }
    @IBAction func confirm(_ sender: Any) {
//        if (Singletone.instance.appUserType) != .Customer {
//                   if "lang".localized == "ar" {
//                       displayMessage(title: "", message: "لا يمكنك عمل طلب إلا في حالة التسجيل كمستخدم", status: .error, forController: self)
//                   } else {
//                       displayMessage(title: "", message: "You can't Confirm order except you are a user", status: .error, forController: self)
//                   }
//               } else {
                   let longitude = Constants.long
                   let latitude = Constants.lat
        
        print(Helper.getApiToken())
                   if Helper.getApiToken() == nil {
                       let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "LoginPopupVC")
                       sb.modalPresentationStyle = .overCurrentContext
                       sb.modalTransitionStyle = .crossDissolve
                       self.present(sb, animated: true, completion: nil)
                   } else {
                    
                    if selectedCount == "" {
                        
                        displayMessage(title: "", message: "Select the number of people".localized, status: .error, forController: self)
                    } else if dateTF.text == "" {
                        
                        displayMessage(title: "", message: "Choose the date".localized, status: .error, forController: self)
                    } else if timeTF.text == "" {
                        
                        displayMessage(title: "", message: "Choose time".localized, status: .error, forController: self)
                    } else {
                    
                        UWInitialization(self) { (controller , result) in
                            
                            
                            self.paymentController = controller
                            guard let nonNilController = self.paymentController else {
                                self.presentAlert(resut: result)
                                return
                            }
                            
                            self.present(nonNilController, animated: true, completion: nil)
                           // self.navigationController?.pushViewController(nonNilController, animated: true)
                     
                        }
                            
                    }
                    
                 //   }
            }
    }
    @IBAction func orderDate(_ sender: UIButton) {
        guard let Details = UIStoryboard(name: "Sections", bundle: nil).instantiateViewController(withIdentifier: "OrderDateVC") as? OrderDateVC else { return }
        Details.selectedDate = { selectedDate in
            self.dateTF.text = selectedDate
            self.dateTF.isEnabled = false
        }
        self.navigationController?.pushViewController(Details, animated: true)
    }
}
extension ReservationRequestVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ReservationCell else {return UICollectionViewCell()}
        cell.config(selectionNumber: numberArr[indexPath.row].reservationNumber, selected: numberArr[indexPath.row].NumberSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        func SelectionAction(indexPath: IndexPath) {
            for i in 0..<numberArr.count{
                if i == indexPath.row {
                    self.numberArr[i].NumberSelected = true
                } else {
                    self.numberArr[i].NumberSelected = false
                }
            }
            self.numberCollectionView.reloadData()
        }
        
        SelectionAction(indexPath: indexPath)
        selectedCount = numberArr[indexPath.row].numberId
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(numberArr.count)
    }

}
extension ReservationRequestVC: CreateReservationViewDelegate {
    func CreateReservationResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "", message: "Done".localized , status: .success, forController: self)
                print(resultMsg.successMessage)
                guard let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "ConfirmationPopup") as? ConfirmationPopup else {return}
                       sb.modalPresentationStyle = .overFullScreen
                      // sb.modalTransitionStyle = .crossDissolve
                       self.present(sb, animated: true, completion: nil)
                
            } else if !resultMsg.restaurant_id.isEmpty, resultMsg.restaurant_id  != [""] {
                displayMessage(title: "", message: resultMsg.restaurant_id[0], status: .error, forController: self)
            } else if !resultMsg.number_of_persons.isEmpty, resultMsg.number_of_persons != [""] {
                displayMessage(title: "", message: resultMsg.number_of_persons[0], status: .error, forController: self)
            } else if !resultMsg.date.isEmpty, resultMsg.date != [""] {
                displayMessage(title: "", message: resultMsg.date[0], status: .error, forController: self)
            } else if !resultMsg.time.isEmpty, resultMsg.time != [""] {
                displayMessage(title: "", message: resultMsg.time[0], status: .error, forController: self)
            }
            
        }
    }
    
}


extension ReservationRequestVC {
    func presentAlert(resut: paymentResult) {
        var displayTitle: String = ""
        var key: mandatoryEnum = .amount
        
        switch resut {
        case .mandatory(let fields):
            key = fields
        default:
            break
        }
        
        switch  key {
        case .amount:
            displayTitle = "Amount"
        case.country:
            displayTitle = "Country"
        case.action_code:
            displayTitle = "Action Code"
        case.currency:
            displayTitle = "Currency"
        case.email:
            displayTitle = "Email"
        case.trackId:
            displayTitle = "TrackID"
        case .tokenID:
            displayTitle = "TockenID"
            
        case .cardOperation:
            displayTitle = "cardOperation"
        }
        
        let alert = UIAlertController(title: "Alert", message: "Check \(displayTitle) Field", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ReservationRequestVC : Initializer {
    
    func didPaymentResult(result: paymentResult, error: Error?, model: PaymentResultData?) {
        
        
        
        switch result {
        case .sucess:
            print("PAYMENT SUCESS")
            DispatchQueue.main.async {
                
                
                self.CreateResevationVCPresenter.showIndicator()
                self.CreateResevationVCPresenter.postCreateReservation(restaurant_id: self.resturant_id, number_of_persons: Int(self.selectedCount) ?? 0, date: self.dateTF.text ?? "", time: self.timeTF.text ?? "", price: Int(self.fees ) ,position : self.session)
                
            }
        case.failure:
            
            print("PAYMENT FAILURE")
            DispatchQueue.main.async {
                
                displayMessage(title: "", message: "PAYMENT FAILURE", status: .error, forController: self)

                self.navigateTOReceptPage(model: model)
            }
        case .mandatory(let fieldName):
            print(fieldName)
            break
        }
        
        
    }
    
    
    func prepareModel() -> UWInitializer {
        let model = UWInitializer.init(amount: "\(self.fees)",
            email: "mahmoud.dtag2020@gmail.com",
            currency: "SAR",
            country: "SA" ,
            actionCode: "1",
            trackIdCode: "1233",createTokenIsEnabled : false,
            merchantIP : "10.10.10.10"
            , tokenizationType: "0")
        return model
    }
    
    func navigateTOReceptPage(model: PaymentResultData?) {
        
        
        print(model?.result.debugDescription)
//        self.paymentController?.navigationController?.popViewController(animated: true)
        
        guard let window = UIApplication.shared.keyWindow else { return }
        let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
        sb.selectedIndex = 0
        window.rootViewController = sb
        UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
        
//        let controller = ReceptConfiguration.setup()
//        controller.model = model
//        controller.modalPresentationStyle = .overFullScreen
//        self.present(controller, animated: true, completion: nil)
    }
    
}

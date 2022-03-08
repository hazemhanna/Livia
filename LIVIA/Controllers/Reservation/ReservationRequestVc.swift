//
//  ReservationRequestVc.swift
//  Livia
//
//  Created by MAC on 19/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import Foundation
import UIKit
import ImageSlideshow

class ReservationRequestVc : UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var indoorBtn : UIButton!
    @IBOutlet weak var outdoorBtn : UIButton!
    @IBOutlet weak var bigVisitBtn : UIButton!

    @IBOutlet weak var selectCateDropDown: TextFieldDropDown!    
    @IBOutlet weak var noteTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!

    var numbers = ["1","2","3","4","5","6","7","8","9","10+"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCatDropDown()
        titleLbl.text = "Reserve Table".localized
        selectCateDropDown.text  = "People Number".localized
        
        if "lang".localized == "ar" {
            noteTF.textAlignment = .right
            dateTF.textAlignment = .right
            selectCateDropDown.textAlignment = .right

        }else{
            noteTF.textAlignment = .left
            dateTF.textAlignment = .left
            selectCateDropDown.textAlignment = .left
        }
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "ScanVc") as? ScanVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
    
    @IBAction func rewardBtn(_ sender: UIButton) {
        if sender.tag == 0 {
            self.indoorBtn.backgroundColor = #colorLiteral(red: 1, green: 0.4078431373, blue: 0.5294117647, alpha: 1)
            self.outdoorBtn.backgroundColor = .white
            self.bigVisitBtn.backgroundColor = .white
            self.indoorBtn.setTitleColor(UIColor.white, for: .normal)
            self.outdoorBtn.setTitleColor(UIColor.black, for: .normal)
            self.bigVisitBtn.setTitleColor(UIColor.black, for: .normal)
        }else if sender.tag == 1 {
            self.outdoorBtn.backgroundColor = #colorLiteral(red: 1, green: 0.4078431373, blue: 0.5294117647, alpha: 1)
            self.bigVisitBtn.backgroundColor = .white
            self.indoorBtn.backgroundColor = .white
            self.indoorBtn.setTitleColor(UIColor.black, for: .normal)
            self.outdoorBtn.setTitleColor(UIColor.white, for: .normal)
            self.bigVisitBtn.setTitleColor(UIColor.black, for: .normal)
        }else{
            self.bigVisitBtn.backgroundColor = #colorLiteral(red: 1, green: 0.4078431373, blue: 0.5294117647, alpha: 1)
            self.indoorBtn.backgroundColor = .white
            self.outdoorBtn.backgroundColor = .white
            self.indoorBtn.setTitleColor(UIColor.black, for: .normal)
            self.outdoorBtn.setTitleColor(UIColor.black, for: .normal)
            self.bigVisitBtn.setTitleColor(UIColor.white, for: .normal)
            
        }
    }
    
    func setupCatDropDown(){
        selectCateDropDown.optionArray = self.numbers
        selectCateDropDown.didSelect { (selectedText, index, id) in
            if index == 9 {
                displayMessage(title: "", message: "اكتب عدد الاشخاص".localized, status:.info, forController: self)
                self.selectCateDropDown.becomeFirstResponder()
            }else{
                self.selectCateDropDown.text = selectedText
            }
        }
    }

    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dateAction(_ sender: UIButton) {
        let main = UIStoryboard(name: "Reservation", bundle: nil).instantiateViewController(withIdentifier: "OrderDateVC")
        self.navigationController?.pushViewController(main, animated: true)
    }

    
    
    @IBAction func confirm(_ sender: UIButton) {
        displayMessage(title: "", message: "تم تاكيدالحجز بنجاح".localized, status:.success, forController: self)
    guard let window = UIApplication.shared.keyWindow else { return }
        let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
        sb.selectedIndex = 0
        window.rootViewController = sb
        UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
    }
    
}


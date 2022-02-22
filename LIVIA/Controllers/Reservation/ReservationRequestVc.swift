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
    @IBOutlet weak var selectCateDropDown: TextFieldDropDown!    
    @IBOutlet weak var noteTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!

    var numbers = ["1","2","3","4","5"]

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
    
    @IBAction func rewardBtn(_ sender: UIButton) {
        if sender.tag == 0 {
            self.indoorBtn.backgroundColor = #colorLiteral(red: 1, green: 0.4078431373, blue: 0.5294117647, alpha: 1)
            self.outdoorBtn.backgroundColor = .white
            self.indoorBtn.setTitleColor(UIColor.white, for: .normal)
            self.outdoorBtn.setTitleColor(UIColor.black, for: .normal)
        }else{
            self.indoorBtn.backgroundColor = .white
            self.outdoorBtn.backgroundColor = #colorLiteral(red: 1, green: 0.4078431373, blue: 0.5294117647, alpha: 1)
            self.indoorBtn.setTitleColor(UIColor.black, for: .normal)
            self.outdoorBtn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    func setupCatDropDown(){
        selectCateDropDown.optionArray = self.numbers
        selectCateDropDown.didSelect { (selectedText, index, id) in
            self.selectCateDropDown.text = selectedText
        }
    }

    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dateAction(_ sender: UIButton) {
        let main = UIStoryboard(name: "Reservation", bundle: nil).instantiateViewController(withIdentifier: "OrderDateVC")
        self.navigationController?.pushViewController(main, animated: true)
    }

    
}


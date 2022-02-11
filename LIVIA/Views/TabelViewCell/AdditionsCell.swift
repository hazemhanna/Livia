//
//  AdditionsCell.swift
//  Shanab
//
//  Created by Macbook on 23/07/2020.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import DLRadioButton
class AdditionsCell: UITableViewCell {
    var selectionOption: ((_ Selected : Bool) ->Void)?
    var increase : (() -> Void)?
    var decrease :(() -> Void)?
    @IBOutlet weak var QuantityLb: UILabel!
    
    
    @IBOutlet weak var CounterSt: UIStackView!
    
    
    @IBOutlet weak var optionBN: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func SelectAddition(_ sender: UISwitch) {
        
        selectionOption?(sender.isOn)

    }
    
    @IBAction func ChangeQuantity(_ sender: UIButton) {
        
        if sender.tag == 1 {
            
            increase?()
        } else {
            
            decrease?()
        }
    }
    
    
    
    @IBAction func radioButtonAction(_ sender: UIButton) {
    }
    func config(name: String, selected: Bool) {
        optionBN.setTitle(name, for: .normal)
        if selected {
            optionBN.isSelected = true
        } else {
            optionBN.isSelected = false
        }
        
    }
   
    
}

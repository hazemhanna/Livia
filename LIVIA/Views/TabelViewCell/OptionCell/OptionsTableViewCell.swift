//
//  OptionsTableViewCell.swift
//  Livia
//
//  Created by MAC on 28/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var selectedImageView : UIImageView!
    @IBOutlet weak var quantityLbl : UILabel!
    @IBOutlet weak var priceLbl : UILabel!

    var Increase: (() ->Void)? = nil
    var Dicrease:(() ->Void)? = nil
    var optionCounter = 1

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func confic(title : String ,price : String, selected : Bool,quantity : Int){
        
        self.titleLbl.text = title
        self.priceLbl.text = price +  "" + "EGP".localized

        if selected{
            selectedImageView.image = UIImage(named: "Ellipse 333")
        }else{
            selectedImageView.image = UIImage(named: "Ellipse 348-1")
        }
        quantityLbl.text = String(quantity)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func Increase(_ sender: Any) {
        Increase?()
    }
    
    @IBAction func Dicrease(_ sender: UIButton) {
        Dicrease?()
    }
    
}

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
    var productCounter = 1
    
    var Increase: (() ->Void)? = nil
    var Dicrease:(() ->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func confic(title : String , selected : Bool){
        self.titleLbl.text = title
        if selected{
            selectedImageView.image = UIImage(named: "Selected")
        }else{
            selectedImageView.image = UIImage(named: "UnSelected")
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func Increase(_ sender: Any) {
        Increase?()
        self.quantityLbl.text = "\(productCounter)"
    }
    
    @IBAction func Dicrease(_ sender: UIButton) {
        Dicrease?()
        self.quantityLbl.text = "\(productCounter)"
    }
    
}

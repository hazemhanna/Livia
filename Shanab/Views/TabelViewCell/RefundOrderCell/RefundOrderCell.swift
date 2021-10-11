//
//  RefundOrderCell.swift
//  Shanab
//
//  Created by MAC on 10/10/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//

import UIKit

class RefundOrderCell: UITableViewCell {

    @IBOutlet weak var resturantImage : UIImageView!
    @IBOutlet weak var resturantName : UILabel!
    @IBOutlet weak var dateLble : UILabel!
    @IBOutlet weak var descLbl: UILabel!

    var goToDetails: (() ->Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func config(imagePath: String ,desc: String ,name : String ,date: String ) {
        dateLble.text = "date".localized + " " + date
        resturantName.text = name
        descLbl.text = desc
        guard let imageURL = URL(string: "https://shnp.dtagdev.com" + "/" + imagePath) else { return }
        self.resturantImage.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "shanab loading"))
    }
    
    
    @IBAction func orderDetails(_ sender: UIButton) {
         goToDetails?()
    }
    
    
}

//
//  PreviousOrders.swift
//  Shanab
//
//  Created by mahmoud helmy on 11/9/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Cosmos

class PreviousOrders: UITableViewCell {
    
    var goToDetails: (() ->Void)? = nil

    @IBOutlet weak var Price: CustomLabel!
    
    @IBOutlet weak var Date: CustomLabel!
    
    @IBOutlet weak var OrderImage: UIImageView!
    
    @IBOutlet weak var Rate: CosmosView!
    
    @IBOutlet weak var Name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configure(name: String, imagePath: String, rate: Double , date : String , total : Double) {

        self.OrderImage.image = #imageLiteral(resourceName: "logo-1")
        self.Price.text = "\(Price)" + "S.R".localized
           //    }
        self.Name.text = name
        self.Date.text = date
        self.Rate.text = "\(rate)"
        if rate >= 0 {
            
            self.Rate.rating = rate
        } else {
            
            self.Rate.rating = 0

        }
       
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func Details(_ sender: Any) {
        
        goToDetails?()

    }
    
    
}

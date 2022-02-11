//
//  PreviosListCell.swift
//  Shanab
//
//  Created by Macbook on 4/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher
class PreviosListCell: UITableViewCell {
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var cosmos: CosmosView!
    @IBOutlet weak var goToDetails: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        orderImage.setRounded()
        self.selectionStyle = .none

        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func config(time: String, imagePath: String, name: String, address: String, rate: Double, price: Double) {
        guard let imageURL = URL(string: "BASE_URL" + "/" + imagePath) else { return }
        self.orderImage.kf.setImage(with: imageURL)
        self.address.text = address
        self.name.text = name
        self.time.text = time
        self.price.text = "\(price)"
        
    }
}

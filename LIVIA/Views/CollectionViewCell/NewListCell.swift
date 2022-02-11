//
//  PreviousListCell.swift
//  Shanab
//
//  Created by Macbook on 4/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Cosmos
class NewListCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var cosmos: CosmosView!
    @IBOutlet weak var goToDetails: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func config(name: String, address: String, rate: Double, imagePath: String) {
        if (!imagePath.contains("http")) {
                   guard let imageURL = URL(string: (BASE_URL + "/" + imagePath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
                   print(imageURL)
                   self.image.kf.setImage(with: imageURL)
               }  else if imagePath != "" {
                   guard let imageURL = URL(string: imagePath) else { return }
                   self.image.kf.setImage(with: imageURL)
               } else {
                   self.image.image = #imageLiteral(resourceName: "shanab loading")
               }
        self.name.text = name
        self.address.text = address
    }

    @IBAction func orderDetails(_ sender: UIButton) {
    }
}

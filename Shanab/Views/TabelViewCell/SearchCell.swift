//
//  SearchCell.swift
//  Shanab
//
//  Created by Macbook on 3/25/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var familyName: UILabel!
    @IBOutlet weak var section: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none

    }
    func config(name: String, imagePath: String, section: String, price: String) {
        if imagePath != "" {
                  guard let imageURL = URL(string: imagePath) else { return }
                  self.searchImage.kf.setImage(with: imageURL)
              } else {
                  self.searchImage.image = #imageLiteral(resourceName: "shanab loading")
              }
    self.familyName.text = name
    self.price.text = price
    self.section.text = section
      
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}

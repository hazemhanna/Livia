//
//  ProfileCell.swift
//  Shanab
//
//  Created by Macbook on 3/29/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            self.cellName.textColor = isSelected ? #colorLiteral(red: 0.9058823529, green: 0.3294117647, blue: 0.2705882353, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellName.adjustsFontSizeToFitWidth = true
        cellName.minimumScaleFactor = 0.5
        
    }
    
    func config(name: String, selected: Bool, imagePath: UIImage) {
               self.cellImage.image = imagePath
               self.cellName.text = name
               if selected {
                   self.cellName.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                   self.cellName.textColor = #colorLiteral(red: 0.8121929765, green: 0.2939046025, blue: 0.2674312294, alpha: 1)
               } else {
                   self.cellName.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                   self.cellName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
               }
               
      }
}

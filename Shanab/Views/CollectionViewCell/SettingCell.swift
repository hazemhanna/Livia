//
//  SettingCell.swift
//  Shanab
//
//  Created by Macbook on 30/07/2020.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Kingfisher
class SettingCell: UICollectionViewCell {
    @IBOutlet weak var sectionImage: UIImageView!
     var selectionAction: (() -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func config(imagePath: UIImage) {
           self.sectionImage.image = imagePath
    }
    @IBAction func selectionAction(_ sender: Any) {
        selectionAction?()
    }
}

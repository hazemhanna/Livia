//
//  SectionCell.swift
//  Shanab
//
//  Created by Macbook on 27/07/2020.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class SectionCell: UICollectionViewCell {
    @IBOutlet weak var sectionName: UILabel!
    @IBOutlet weak var sectionImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.sectionName.adjustsFontSizeToFitWidth = true
        self.sectionName.minimumScaleFactor = 0.5
       // sectionImage.setRounded()
    }

    func config( imagePath: String , name: String){
        self.sectionName.text = name
        guard let imageURL = URL(string: (imagePath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
        self.sectionImage.kf.setImage(with: imageURL)
        
       }

}

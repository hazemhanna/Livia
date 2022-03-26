//
//  SliderCell.swift
//  Livia
//
//  Created by MAC on 27/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import UIKit

class SliderCell: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func config(imagePath: String) {
        
        
        guard let imageURL = URL(string: (imagePath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
        self.cellImage.kf.setImage(with: imageURL)
    
    }
}

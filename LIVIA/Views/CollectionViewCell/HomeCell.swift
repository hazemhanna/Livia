//
//  HomeCell.swift
//  Shanab
//
//  Created by Macbook on 4/14/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    @IBOutlet weak var sectionImageView: UIImageView!
    @IBOutlet weak var sectionName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(imagePath: String, name: String) {
        self.sectionName.text = name
        guard let imageURL = URL(string: (imagePath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
        self.sectionImageView.kf.setImage(with: imageURL)
        
                
    }
    
    
    
}

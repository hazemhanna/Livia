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
        
                        
           if (!imagePath.contains("http")) {
                guard let imageURL = URL(string: (BASE_URL + "/" + imagePath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
                print(imageURL)
                self.sectionImageView.kf.setImage(with: imageURL)
            } else if imagePath != "" {
                guard let imageURL = URL(string: imagePath) else { return }
                self.sectionImageView.kf.setImage(with: imageURL)
            } else {
                self.sectionImageView.image = #imageLiteral(resourceName: "shanab loading")
            }
      
       
        
        self.sectionName.text = name
    }
    
    
    
}

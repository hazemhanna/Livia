//
//  SizeCollectionViewCell.swift
//  Livia
//
//  Created by MAC on 28/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import UIKit

class SizeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var selectedImage : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func confic(title : String , selected : Bool){
        self.titleLbl.text = title
        if selected{
            selectedImage.image = UIImage(named: "Selected")
        }else{
            selectedImage.image = UIImage(named: "UnSelected")
        }
    }
}

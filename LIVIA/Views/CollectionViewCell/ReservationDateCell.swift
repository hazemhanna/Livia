//
//  ReservationDateCell.swift
//  Shanab
//
//  Created by Macbook on 4/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class ReservationDateCell: UICollectionViewCell {
    @IBOutlet weak var selectedDay: UIButton!
    @IBOutlet weak var day: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func date(_ sender: UIButton) {
    }
}

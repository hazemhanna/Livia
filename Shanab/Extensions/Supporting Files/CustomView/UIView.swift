//
//  CustomUIView.swift
//  Shanab
//
//  Created by Macbook on 4/7/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    func setGradientBackground(ColorOne: UIColor, ColorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [ColorOne.cgColor, ColorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

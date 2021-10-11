//
//  HelperMethods.swift
//  CharityProject
//
//  Created by D-TAG on 5/15/19.
//  Copyright © 2019 D-tag. All rights reserved.
//

import Foundation
import SwiftMessages

//MARK:- Display normal Alert
public func displayMessage(title: String, message: String, status: Theme, forController controller: UIViewController) {
    let success = MessageView.viewFromNib(layout: .cardView)
    success.configureTheme(status, iconStyle: .default )
    success.configureDropShadow()
    success.configureContent(title: title, body: message)
    success.button?.isHidden = true
    var successConfig = SwiftMessages.defaultConfig
    successConfig.duration = .seconds(seconds: 1)
    successConfig.presentationStyle = .top
    successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
    SwiftMessages.show(config: successConfig, view: success)
    
}


//MARK: - Localization and languages
public func localizedStringFor(key:String)->String {
    return NSLocalizedString(key, comment: "")
}
//MARK:- Display QRCode
public func generateQRCode(from string: String) -> UIImage? {
    let data = string.data(using: String.Encoding.ascii)

    if let filter = CIFilter(name: "CIQRCodeGenerator") {
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)

        if let output = filter.outputImage?.transformed(by: transform) {
            return UIImage(ciImage: output)
        }
    }

    return nil
}


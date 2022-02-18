//
//  SceneDelegate.swift
//  Shanab
//
//  Created by Macbook on 3/22/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = self.window
        
        let sb = UIStoryboard(name: "Authentications", bundle: nil).instantiateViewController(withIdentifier: "LoginNav")
       // let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar")
        UIApplication.shared.windows.first?.rootViewController = sb
        UIApplication.shared.windows.first?.makeKeyAndVisible()


        guard let _ = (scene as? UIWindowScene) else { return }
    }



}


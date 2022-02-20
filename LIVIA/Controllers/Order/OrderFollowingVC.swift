//
//  OrderFollowingVC.swift
//  Shanab
//
//  Created by Macbook on 3/30/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import MapKit
class OrderFollowingVC: UIViewController {
    
    @IBOutlet weak var orderNum: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var statusLB: UILabel!
    @IBOutlet weak var New: UIImageView!
    @IBOutlet weak var Preparing: UIImageView!
    @IBOutlet weak var OnWay: UIImageView!
    @IBOutlet weak var Arrived: UIImageView!
    @IBOutlet weak var Completed: UIImageView!
    
    @IBOutlet weak var TopToView: NSLayoutConstraint!
    @IBOutlet weak var BottomToStack: NSLayoutConstraint!
    @IBOutlet weak var BtnHeight: NSLayoutConstraint!
    @IBOutlet weak var UpdateBtn: UIButton!
    
    
    var id = Int()
    var status = String()
    var date = String()
    override func viewDidLoad() {
        super.viewDidLoad()
   
        switch "delivering" {
        case "new":
            New.image = #imageLiteral(resourceName: "icons8-sync")
//            UpdateBtn.isHidden = true
//            BtnHeight.isActive = false
//            BottomToStack.isActive = false
//            TopToView.isActive = true
            
        case "preparing":
            New.image = #imageLiteral(resourceName: "checked-green-1")
//            Preparing.image = #imageLiteral(resourceName: "CurrentStatus")
//            UpdateBtn.isHidden = true
//            BtnHeight.isActive = false
//            BottomToStack.isActive = false
            
        case "delivering":
            New.image = #imageLiteral(resourceName: "checked-green-1")
            Preparing.image = #imageLiteral(resourceName: "checked-green-1")
            OnWay.image = #imageLiteral(resourceName: "CurrentStatus")
//            UpdateBtn.isHidden = true
//            BtnHeight.isActive = false
//            BottomToStack.isActive = false
//            TopToView.isActive = true
        case "delvivered":
            New.image = #imageLiteral(resourceName: "checked-green-1")
            Preparing.image = #imageLiteral(resourceName: "checked-green-1")
            OnWay.image = #imageLiteral(resourceName: "checked-green-1")
            Arrived.image = #imageLiteral(resourceName: "CurrentStatus")
//            UpdateBtn.isHidden = true
//            BtnHeight.isActive = false
//            BottomToStack.isActive = false
//            TopToView.isActive = true


        case "competed":
            
            New.image = #imageLiteral(resourceName: "checked-green-1")
            Preparing.image = #imageLiteral(resourceName: "checked-green-1")
            OnWay.image = #imageLiteral(resourceName: "checked-green-1")
            Arrived.image = #imageLiteral(resourceName: "checked-green-1")
            Completed.image = #imageLiteral(resourceName: "checked-green-1")
           // UpdateBtn.isHidden = false
          //  BtnHeight.isActive = true
          //  BottomToStack.isActive = true
           // TopToView.isActive = false
        default:
            break
        }
        
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func backBtn(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
    }
    
}

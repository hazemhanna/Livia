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
    
    var order : orderList?
    
    @IBOutlet weak var TopToView: NSLayoutConstraint!
    
    @IBOutlet weak var BottomToStack: NSLayoutConstraint!
    
    @IBOutlet weak var BtnHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var UpdateBtn: UIButton!
    
    
    var id = Int()
    var status = String()
    var date = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderNum.text = "\(order?.id ?? 0)"
        orderDate.text = order?.createdAt
        statusLB.text = order?.status?.localized
        
        switch order?.status {
        case "new":
            New.image = #imageLiteral(resourceName: "icons8-sync")
            UpdateBtn.isHidden = true
            BtnHeight.isActive = false
            BottomToStack.isActive = false
            TopToView.isActive = true

        case "preparing":
            New.image = #imageLiteral(resourceName: "checked-green-1")
            Preparing.image = #imageLiteral(resourceName: "CurrentStatus")
            UpdateBtn.isHidden = true
            BtnHeight.isActive = false
            BottomToStack.isActive = false
        case "delivering":
            New.image = #imageLiteral(resourceName: "checked-green-1")
            Preparing.image = #imageLiteral(resourceName: "checked-green-1")
            OnWay.image = #imageLiteral(resourceName: "CurrentStatus")
            UpdateBtn.isHidden = true
            BtnHeight.isActive = false
            BottomToStack.isActive = false
            TopToView.isActive = true

            
        case "delvivered":
            
            New.image = #imageLiteral(resourceName: "checked-green-1")
            Preparing.image = #imageLiteral(resourceName: "checked-green-1")
            OnWay.image = #imageLiteral(resourceName: "checked-green-1")
            Arrived.image = #imageLiteral(resourceName: "CurrentStatus")
            UpdateBtn.isHidden = true
            BtnHeight.isActive = false
            BottomToStack.isActive = false
            TopToView.isActive = true


        case "competed":
            
            New.image = #imageLiteral(resourceName: "checked-green-1")
            Preparing.image = #imageLiteral(resourceName: "checked-green-1")
            OnWay.image = #imageLiteral(resourceName: "checked-green-1")
            Arrived.image = #imageLiteral(resourceName: "checked-green-1")
            Completed.image = #imageLiteral(resourceName: "checked-green-1")
            UpdateBtn.isHidden = false
            BtnHeight.isActive = true
            BottomToStack.isActive = true
            TopToView.isActive = false

            
        default:
            break
        }
        
    }
    
    @IBAction func UpdateRate(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "RatingVC") as! RatingVC
        
        sb.order_id = order?.id ?? 0
        
    
        sb.modalPresentationStyle = .overCurrentContext
        sb.modalTransitionStyle = .crossDissolve
        self.present(sb, animated: true, completion: nil)
    }
    
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    @IBAction func Dismiss(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cart(_ sender: Any) {
//        guard let window = UIApplication.shared.keyWindow else { return }
//
//        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
//
//        details.selectedIndex = 2
//        window.rootViewController = details
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func Comlpeleted(_ sender: Any) {
        let sb = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: "RatingVC")
        sb.modalPresentationStyle = .overCurrentContext
        sb.modalTransitionStyle = .crossDissolve
        self.present(sb, animated: true, completion: nil)
        
    }
}

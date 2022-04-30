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
    @IBOutlet weak var Completed: UIImageView!
    @IBOutlet weak var NewView: UIView!
    @IBOutlet weak var PreparingView: UIView!
    @IBOutlet weak var OnWayView: UIView!
    @IBOutlet weak var CompletedView: UIView!
    @IBOutlet weak var NEWLBl : UILabel!
    @IBOutlet weak var PREPAREDLBl : UILabel!
    @IBOutlet weak var WAYLBl : UILabel!
    @IBOutlet weak var COMPLETEDLBl : UILabel!
    var order: Order?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        NEWLBl.text = "NEW".localized
        PREPAREDLBl.text = "PREPARED".localized
        WAYLBl.text = "ON_THE_WAY".localized
        COMPLETEDLBl.text = "COMPLETED".localized
        
        switch order?.logs?.last?.status ?? "" {
        case "NEW":
            New.image = #imageLiteral(resourceName: "icons8-sync")
        case "PREPARED":
            New.image = #imageLiteral(resourceName: "checked-green-1")
            Preparing.image = #imageLiteral(resourceName: "icons8-sync")
        case "ON_THE_WAY":
            New.image = #imageLiteral(resourceName: "checked-green-1")
            Preparing.image = #imageLiteral(resourceName: "checked-green-1")
            OnWay.image = #imageLiteral(resourceName: "CurrentStatus")
        case "COMPLETED":
            New.image = #imageLiteral(resourceName: "checked-green-1")
            Preparing.image = #imageLiteral(resourceName: "checked-green-1")
            OnWay.image = #imageLiteral(resourceName: "checked-green-1")
            Completed.image = #imageLiteral(resourceName: "checked-green-1")
        default:
            break
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        orderNum.text = "\(order?.id ?? 0 )"
        orderDate.text = convertDateFormatter(date: order?.orderDate ?? "")
        statusLB.text = order?.logs?.last?.status?.localized ?? ""
        if order?.order_place == 1{
            OnWayView.isHidden = false
        }else{
            OnWayView.isHidden = true
        }
    }
    
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func backBtn(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
    }
    
    public func convertDateFormatter(date: String) -> String {
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
     dateFormatter.locale = Locale(identifier: "your_loc_id")
     let convertedDate = dateFormatter.date(from: date)
     guard dateFormatter.date(from: date) != nil else {
     assert(false, "no date from string")
     return ""
     }
     dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
     let timeStamp = dateFormatter.string(from: convertedDate!)
     print(timeStamp)
     return timeStamp
     }
}

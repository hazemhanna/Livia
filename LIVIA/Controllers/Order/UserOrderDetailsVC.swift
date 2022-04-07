//
//  UserOrderDetailsVC.swift
//  Shanab
//
//  Created by Macbook on 7/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class UserOrderDetailsVC: UIViewController{
    
    @IBOutlet weak var totalPriceLB: UILabel!
    @IBOutlet weak var fees: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var orderTyper : UILabel!
    @IBOutlet weak var paymentView : UIView!
    @IBOutlet weak var TaxLb: UILabel!
    
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var TableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var TaxLb2: UILabel!
    @IBOutlet weak var oredrId  : UILabel!
    

    fileprivate let cellIdentifier = "OrderReceiptCell"
    var order: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
      
        TaxLb2.text = "taxs".localized
        self.TaxLb.text = ("The total price includes ".localized + "VAT tax".localized)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        TableHeight.constant = CGFloat(40 * (order?.orderItems?.count ?? 0))
        detailsTableView.reloadData()
        
        
        var total = 0
        for t in  self.order?.orderItems ?? [] {
            let price = Double(t.price ?? "") ?? 0.0
            total +=  Int(price) * (t.quantity ?? 0)
        }
        
        self.orderPrice.text = String(total) + " " + "EGP".localized
        self.totalPriceLB.text = String(total + 40) + " " + "EGP".localized
        oredrId.text = "\(order?.id ?? 0 )"
    }
    
   override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.detailsTableView.layer.removeAllAnimations()
        TableHeight.constant = detailsTableView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    
    @IBAction func Dismiss(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "ScanVc") as? ScanVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }

}

extension UserOrderDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  order?.orderItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? OrderReceiptCell else {return UITableViewCell()}
        let item = order?.orderItems?[indexPath.row]

        if "lang".localized == "ar" {
            cell.config(name: item?.product?.title?.ar ?? "", number: item?.quantity ?? 0,price: item?.price ?? "")
        }else{
            cell.config(name: item?.product?.title?.en ?? "", number: item?.quantity ?? 0, price: item?.price ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}


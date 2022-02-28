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

    fileprivate let cellIdentifier = "OrderReceiptCell"
    
    var details = [Int]() {
        didSet {
            DispatchQueue.main.async {
            
                self.detailsTableView.reloadData()
                self.TableHeight.constant = 3*40
            
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.estimatedRowHeight = 120
        TaxLb2.text = "taxs".localized
        self.TaxLb.text = ("The total price includes ".localized + "VAT tax".localized)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        details.append(1)
        details.append(1)
        details.append(1)
    }
    
   override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.detailsTableView.layer.removeAllAnimations()
        TableHeight.constant = detailsTableView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
    
    @IBAction func Dismiss(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
 

}

extension UserOrderDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? OrderReceiptCell else {return UITableViewCell()}
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}


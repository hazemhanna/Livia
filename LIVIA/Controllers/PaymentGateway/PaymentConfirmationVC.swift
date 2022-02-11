//
//  PaymentConfirmationVC.swift
//  Shanab
//
//  Created by Macbook on 3/31/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import DLRadioButton
class PaymentConfirmationVC: UIViewController {
    @IBOutlet weak var paymentWay3: UIButton!
    @IBOutlet weak var paymentWay2: UIButton!
    @IBOutlet weak var paymentWay1: UIButton!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    fileprivate let cellIdentifier = "CartCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: cellIdentifier)
      
    }
    
    @IBAction func paymentWay(_ radioButton: DLRadioButton) {
    }
    
    @IBAction func Confirm(_ sender: UIButton) {
    }
    

}
extension PaymentConfirmationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CartCell else {return UITableViewCell()}
        return cell
    }
    
    
}

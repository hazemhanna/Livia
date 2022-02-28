//
//  subscriptionsVc.swift
//  Livia
//
//  Created by MAC on 27/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation
import UIKit
import ImageSlideshow

class SubscriptionsVc : UIViewController {
    
    @IBOutlet weak var MealDetailsTableView: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var empyView : UIView!

    private let TableCellIdentifier = "subscriptionsCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MealDetailsTableView.delegate = self
        MealDetailsTableView.dataSource = self
        MealDetailsTableView.estimatedRowHeight = UITableView.automaticDimension
        MealDetailsTableView.register(UINib(nibName: TableCellIdentifier, bundle: nil), forCellReuseIdentifier: TableCellIdentifier)
        titleLbl.text = "subscriptions".localized
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SubscriptionsVc  : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifier, for: indexPath) as? subscriptionsCell else {return UITableViewCell()}
        
        //cell.config(imagePath: "", date: "13/3/2022", price: 40.0 , time: "١١ يوم", pakageName: "الباقة الذهيية")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

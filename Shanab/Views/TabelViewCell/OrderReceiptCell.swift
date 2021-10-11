//
//  OrderReceiptCell.swift
//  Shanab
//
//  Created by Macbook on 3/31/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class OrderReceiptCell: UITableViewCell {
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var OptionsTableView: UITableView!
    
    
    
    @IBOutlet weak var TableOptionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var RestaurantName: UILabel!
    
    private let cellIdentifier = "DriverDetaisTableViewCell"
    @IBOutlet weak var price: UILabel!
    var options = [Option]() {
        didSet {
            DispatchQueue.main.async {
                self.OptionsTableView.reloadData()
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        OptionsTableView.delegate = self
        OptionsTableView.dataSource = self
        OptionsTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        
    }
    
    
//    override func layoutSubviews() {
//
////        self.TableOptionHeight?.constant = self.OptionsTableView.contentSize.height
//
//    }
//    override func viewWillLayoutSubviews() {
//        super.updateViewConstraints()
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
        
    }
    func config(name: String, number: Int, price: String, options: [Option] , restaurant : String) {
        self.name.text = name
        self.number.text = "\(number)"
        print(price)
        self.price.text = price
        RestaurantName.text = restaurant
        print(self.price.text)
        self.options = options
    }
    
    
}
extension OrderReceiptCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if options.count == 0 {
            
            TableOptionHeight.constant = 0
        } else {
            
            TableOptionHeight.constant = CGFloat(45 * options.count)
        }
        
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as?
            DriverDetailsTableViewCell else {return UITableViewCell()}
        let detailedOption = options[indexPath.row]
        
        if "lang".localized == "ar" {
            
            cell.config(name:  detailedOption.options?.nameAr ?? ""  , number: detailedOption.quantity ?? 0 ,price: detailedOption.price?.rounded(toPlaces: 2) ?? 0.0)
        } else {
            
            cell.config(name:  detailedOption.options?.nameEn ?? ""  , number: detailedOption.quantity ?? 0 ,price: detailedOption.price?.rounded(toPlaces: 2) ?? 0.0)

        }

        
               return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }
    
    
}

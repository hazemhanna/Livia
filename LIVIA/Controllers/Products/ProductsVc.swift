//
//  BestSellerVC.swift
//  Shanab
//
//  Created by Macbook on 3/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import ImageSlideshow
class ProductsVc : UIViewController {
    

    @IBOutlet weak var bestSellerTableView: UITableView!

    fileprivate let cellIdentifier = "ValiableResturantCell"
    var productCounter = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        bestSellerTableView.delegate = self
        bestSellerTableView.dataSource = self
        bestSellerTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)

    }
      
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension ProductsVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ValiableResturantCell else {return UITableViewCell()}
        
        cell.increase = {
            self.productCounter += 1
            cell.quantityTF.text = "\(self.productCounter)"
        }
        
        cell.decrease = {
            if self.productCounter > 1 {
                self.productCounter -= 1
                cell.quantityTF.text = "\(self.productCounter)"
            }

        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
        self.navigationController?.pushViewController(details, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}




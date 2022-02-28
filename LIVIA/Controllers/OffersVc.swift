//
//  OffersVc.swift
//  Livia
//
//  Created by MAC on 24/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import UIKit
class OffersVc : UIViewController {
    
    @IBOutlet weak var bestSellerTableView: UITableView!
    fileprivate let cellIdentifier = "OffersCell"
    var productCounter = Int()
    
    var meals = [RestaurantMeal]() {
        didSet{
            DispatchQueue.main.async {
                self.bestSellerTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bestSellerTableView.delegate = self
        bestSellerTableView.dataSource = self
        bestSellerTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        meals.append(RestaurantMeal(nameAr: "بيتزا خضروات", image: #imageLiteral(resourceName: "Screen Shot 2022-02-11 at 4.19.53 AM"), descriptionAr: "بيتزا"))
        
        meals.append(RestaurantMeal(nameAr: "بيتزا فراخ", image: #imageLiteral(resourceName: "Screen Shot 2022-02-13 at 2.39.35 AM"), descriptionAr: "بيتزا"))
        
        meals.append(RestaurantMeal(nameAr: "بيتزا سي فود", image: #imageLiteral(resourceName: "food-1"), descriptionAr: "بيتزا"))

        meals.append(RestaurantMeal(nameAr: "بيتزا فراخ", image: #imageLiteral(resourceName: "Screen Shot 2022-02-11 at 4.19.53 AM"), descriptionAr: "بيتزا"))

        
    }
      
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    
    @IBAction func BackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension OffersVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? OffersCell else {return UITableViewCell()}
        
        cell.config(name: meals[indexPath.row].nameAr ?? "",price: 12.2, imagePath: meals[indexPath.row].image  , type: meals[indexPath.row].descriptionAr ?? "")

        cell.goToFavorites = {
            if cell.isFavourite{
                cell.FavoriteBN.setImage(UIImage(named: "heart"), for: .normal)
                cell.isFavourite = false
            }else{
                cell.FavoriteBN.setImage(UIImage(named: "222"), for: .normal)
                cell.isFavourite = true
            }
        }
        
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
        details.meals = self.meals[indexPath.row]
        self.navigationController?.pushViewController(details, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "ScanVc") as? ScanVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    

    @IBAction func searchButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }

    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
}



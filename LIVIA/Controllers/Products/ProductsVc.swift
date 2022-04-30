//
//  BestSellerVC.swift
//  Shanab
//
//  Created by Macbook on 3/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ProductsVc : UIViewController {
    
    @IBOutlet weak var titleLbl  : UILabel!
    @IBOutlet weak var bestSellerTableView: UITableView!
    @IBOutlet weak var empyView : UIView!
    @IBOutlet weak var emptyLbl  : UILabel!

    
    fileprivate let cellIdentifier = "ValiableResturantCell"
    private let homeViewModel = HomeViewModel()
    var disposeBag = DisposeBag()
    
    var products = [Product]() {
        didSet{
            DispatchQueue.main.async {
                self.bestSellerTableView.reloadData()
            }
        }
    }
    var catId = Int()
    var catTitle = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        bestSellerTableView.delegate = self
        bestSellerTableView.dataSource = self
        bestSellerTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        homeViewModel.showIndicator()
        self.getProduct(id : self.catId)
        self.titleLbl.text = catTitle
        emptyLbl.text = "there is no product".localized
    }
      
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func BackBtn(_ sender: Any) {
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
extension ProductsVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ValiableResturantCell else {return UITableViewCell()}
        
        if "lang".localized == "ar" {
        cell.config(name: products[indexPath.row].title?.ar ?? ""
                    , price: products[indexPath.row].variants?[0].price ?? ""
                    , imagePath: products[indexPath.row].images?[0].image ?? ""
                    , type: products[indexPath.row].desc?.ar ?? ""
                    , isWishlist: products[indexPath.row].isWishlist ?? false
                    , discount: Double(products[indexPath.row].discount ?? "") ?? 0)
        }else{
            cell.config(name: products[indexPath.row].title?.en ?? ""
                        , price: products[indexPath.row].variants?[0].price ?? ""
                        , imagePath: products[indexPath.row].images?[0].image ?? "",
                        type: products[indexPath.row].desc?.en ?? ""
                        ,isWishlist: products[indexPath.row].isWishlist ?? false
                        , discount: Double(products[indexPath.row].discount ?? "") ?? 0)

        }
        cell.goToFavorites = {
            if Helper.getApiToken() ?? ""  == ""  {
                    displayMessage(title: "", message: "You should login first".localized, status:.warning, forController: self)
            }else{
                self.homeViewModel.showIndicator()
                self.addWishList(id: self.products[indexPath.row].id ?? 0 , isWishList: self.products[indexPath.row].isWishlist ?? false)
               }
            }
        cell.increase = {
            guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
            details.product = self.products[indexPath.row]
            self.navigationController?.pushViewController(details, animated: true)
        }
        
        cell.decrease = {
            guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
            details.product = self.products[indexPath.row]
            self.navigationController?.pushViewController(details, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
        details.product = self.products[indexPath.row]
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension ProductsVc{
    
    func getProduct(id : Int) {
            self.homeViewModel.getCategoryProduct(id : id).subscribe(onNext: { (data) in
                self.homeViewModel.dismissIndicator()
                self.products = data.data?.products ?? []
                if self.products.count > 0 {
                    self.empyView.isHidden = true
                }else{
                   self.empyView.isHidden = false
                }
            }, onError: { (error) in
                self.homeViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
    }

 func addWishList(id : Int,isWishList : Bool) {
        self.homeViewModel.addWishList(id: id,isWishList :isWishList).subscribe(onNext: { (data) in
            if data.value ?? false {
                if isWishList{
                displayMessage(title: "", message: "remove to favourite".localized, status:.success, forController: self)
                }else{
                displayMessage(title: "", message: "Add to favourite".localized, status:.success, forController: self)
                }
            }
            self.getProduct(id: self.catId)
            }, onError: { (error) in
                self.homeViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
    
}

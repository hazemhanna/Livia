//
//  FavoriteMealsVC.swift
//  Shanab
//
//  Created by Macbook on 7/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class FavoriteMealsVC: UIViewController {
    @IBOutlet weak var titleLbl  : UILabel!

    @IBOutlet weak var favoriteMealsTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var noProduct: UILabel!

    
    fileprivate let cellIdentifier = "ValiableResturantCell"
    private let homeViewModel = HomeViewModel()
    var disposeBag = DisposeBag()
    
    var products = [Product]() {
        didSet{
            DispatchQueue.main.async {
                self.favoriteMealsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteMealsTableView.delegate = self
        favoriteMealsTableView.dataSource = self
        favoriteMealsTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        titleLbl.text =  "Favorite Meals".localized
        
        homeViewModel.showIndicator()
        getWishList()
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func backBtn(_ sender: Any) {
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
    
    func show () {
        if products.count > 0 {
            favoriteMealsTableView.isHidden = false
            self.emptyView.isHidden = true
        }else{
            favoriteMealsTableView.isHidden = true
            self.emptyView.isHidden = false
        }
    }
    
}

extension FavoriteMealsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ValiableResturantCell else {return UITableViewCell()}
         cell.FavoriteBN.setImage(UIImage(named: "222"), for: .normal)
        
        
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
            self.homeViewModel.showIndicator()
            self.reomveWishlist(id: self.products[indexPath.row].id ?? 0)
        }
        
        cell.increase = {
            guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }

            self.navigationController?.pushViewController(details, animated: true)
        }
        
        cell.decrease = {
            guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
            self.navigationController?.pushViewController(details, animated: true)
            
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
extension FavoriteMealsVC {
    func getWishList() {
            self.homeViewModel.getWishList().subscribe(onNext: { (data) in
                 self.homeViewModel.dismissIndicator()
                self.products = data.data?.products ?? []
                self.show()
            }, onError: { (error) in
                self.homeViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
    

    func reomveWishlist(id : Int) {
            self.homeViewModel.addWishList(id: id, isWishList: true).subscribe(onNext: { (data) in
                self.getWishList()
            }, onError: { (error) in
                self.homeViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
    
    
}

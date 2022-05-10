//
//  SearchVC.swift
//  Livia
//
//  Created by MAC on 22/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//



import UIKit
import RxSwift
import RxCocoa

class SearchVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var empyView : UIView!
    @IBOutlet weak var titleLbl  : UILabel!
    private let CellIdentifierTableView = "ValiableResturantCell"
    private let homeViewModel = HomeViewModel()
    var disposeBag = DisposeBag()
    
    var stock = [Product]()
    
    var products = [Product]() {
        didSet{
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(UINib(nibName: CellIdentifierTableView, bundle: nil), forCellReuseIdentifier: CellIdentifierTableView)
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        homeViewModel.showIndicator()
        self.getProduct()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
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

extension SearchVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierTableView, for: indexPath) as? ValiableResturantCell else {return UITableViewCell()}
        
        cell.FavoriteBN.setImage(UIImage(named: "heart"), for: .normal)
      
        var price =  ""
        var image = ""

        if products[indexPath.row].variants?.count ?? 0 > 0 {
            price = products[indexPath.row].variants?[0].price ?? ""
        }
    
        if products[indexPath.row].images?.count ?? 0 > 0 {
            image = products[indexPath.row].images?[0].image ?? ""
        }
        
        if "lang".localized == "ar" {
        cell.config(name: products[indexPath.row].title?.ar ?? ""
                    , price: price
                    , imagePath:  image
                    , type: products[indexPath.row].category?.title?.ar ?? ""
                    , isWishlist: products[indexPath.row].isWishlist ?? false
                    , discount: Double(products[indexPath.row].discount ?? "") ?? 0)
        }else{
            cell.config(name: products[indexPath.row].title?.en ?? ""
                        , price:  price
                        , imagePath: image
                        ,type: products[indexPath.row].category?.title?.en ?? ""
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

extension SearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.products = stock
            self.searchTableView.reloadData()
     }else{
        if "lang".localized == "ar" {
        let filtered = products.filter { $0.title?.ar?.contains(searchText) as! Bool}
            self.products = filtered
        }else{
            let filtered = products.filter { $0.title?.en?.contains(searchText) as! Bool}
            self.products = filtered
        }
        self.searchTableView.reloadData()
        }
    }

}

extension SearchVC{
    func getProduct() {
            self.homeViewModel.getProduct().subscribe(onNext: { (data) in
                self.homeViewModel.dismissIndicator()
                self.products = data.data?.products ?? []
                self.stock = data.data?.products ?? []
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
                self.getProduct()
            }, onError: { (error) in
                self.homeViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
}


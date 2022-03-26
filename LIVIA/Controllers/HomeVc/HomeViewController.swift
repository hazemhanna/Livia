//
//  HomeViewController.swift
//  Livia
//
//  Created by MAC on 11/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//



import UIKit
import ImageSlideshow
import DropDown
import SwiftMessages
import Alamofire
import RxSwift
import RxCocoa


class HomeViewController: UIViewController {

    @IBOutlet weak var RestaurantTableView: UITableView!
    @IBOutlet weak var imageSlider: ImageSlideshow!
    @IBOutlet weak var homeSectionsCollectionView: UICollectionView!
    @IBOutlet weak var notificationBN: UIButton!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var SlidercollectionView: UICollectionView!
    @IBOutlet weak var titleLbl  : UILabel!
    
    
    var sliders = [Slider](){
        didSet{
            DispatchQueue.main.async {
                self.SlidercollectionView.reloadData()
            }
        }
    }

    var category = [Category](){
        didSet{
            DispatchQueue.main.async {
                self.homeSectionsCollectionView.reloadData()
            }
        }
    }
    
    var products = [Product]() {
        didSet{
            DispatchQueue.main.async {
                self.RestaurantTableView.reloadData()
            }
        }
    }
    
    var timer = Timer()
    var counter = 0
    fileprivate let CellIdentifierCollectionView = "HomeCell"
    fileprivate let CellIdentifierTableView = "ValiableResturantCell"
    fileprivate let sliderCell = "SliderCell"
    var productCounter = Int()
    let token = Helper.getApiToken() ?? ""
    
    private let homeViewModel = HomeViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = false
        homeSectionsCollectionView.delegate = self
        homeSectionsCollectionView.dataSource = self
        homeSectionsCollectionView.register(UINib(nibName: CellIdentifierCollectionView, bundle: nil), forCellWithReuseIdentifier: CellIdentifierCollectionView)

        SlidercollectionView.delegate = self
        SlidercollectionView.dataSource = self
        SlidercollectionView.register(UINib(nibName: sliderCell, bundle: nil), forCellWithReuseIdentifier: sliderCell)

        
        titleLbl.text = "Home".localized
        
        RestaurantTableView.delegate = self
        RestaurantTableView.dataSource = self
        RestaurantTableView.tableFooterView = UIView()
        RestaurantTableView.register(UINib(nibName: CellIdentifierTableView, bundle: nil), forCellReuseIdentifier: CellIdentifierTableView)
        
    
        if token != "" {
          notificationBN.isHidden = false
        }else{
         notificationBN.isHidden = true
        }
        
        homeViewModel.showIndicator()
        self.getSlider()
        self.getProduct()
        self.getCat()
        
    }
    
    @objc func changeImage() {
             
         if counter < sliders.count {
              let index = IndexPath.init(item: counter, section: 0)
              self.SlidercollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              pageView.currentPage = counter
              counter += 1
         } else {
              counter = 0
              let index = IndexPath.init(item: counter, section: 0)
              self.SlidercollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
               pageView.currentPage = counter
               counter = 1
           }
      }
    
    

    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }


    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }

    fileprivate func setupImageSlider() {

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


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == SlidercollectionView {
            return sliders.count

        }else{
            return category.count

        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == SlidercollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sliderCell, for: indexPath) as? SliderCell else { return UICollectionViewCell()}
            
            cell.config(imagePath:  self.sliders[indexPath.row].image ?? "")
            
            return cell
            
        }else {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifierCollectionView, for: indexPath) as? HomeCell else { return UICollectionViewCell()}
            
            if "lang".localized == "ar" {
                cell.config(imagePath: self.category[indexPath.row].image ?? "", name: self.category[indexPath.row].title?.ar ?? "")
            }else{
                cell.config(imagePath: self.category[indexPath.row].image ?? "", name: self.category[indexPath.row].title?.en ?? "")

            }
        return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductsVc") as? ProductsVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == SlidercollectionView {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)

        }else{
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size: CGFloat = (collectionView.frame.size.width - space) / 4.1
            return CGSize(width: size, height: collectionView.frame.size.height)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierTableView, for: indexPath) as? ValiableResturantCell else {return UITableViewCell()}
        cell.FavoriteBN.setImage(UIImage(named: "heart"), for: .normal)
        
        if "lang".localized == "ar" {
        cell.config(name: products[indexPath.row].title?.ar ?? ""
                    , price: products[indexPath.row].variants?[0].price ?? ""
                    , imagePath: products[indexPath.row].images?[0].image ?? ""
                    , type: products[indexPath.row].desc?.ar ?? ""
                    , isWishlist: products[indexPath.row].isWishlist ?? false )
        }else{
            cell.config(name: products[indexPath.row].title?.en ?? ""
                        , price: products[indexPath.row].variants?[0].price ?? ""
                        , imagePath: products[indexPath.row].images?[0].image ?? "",
                        type: products[indexPath.row].desc?.en ?? ""
                        ,isWishlist: products[indexPath.row].isWishlist ?? false)

        }
        cell.goToFavorites = {
            self.homeViewModel.showIndicator()
            self.addWishList(id: self.products[indexPath.row].id ?? 0 , isWishList: self.products[indexPath.row].isWishlist ?? false)
        }
        cell.increase = {
            guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
           // details.meals = self.meals[indexPath.row]
            self.navigationController?.pushViewController(details, animated: true)
            
        }
        
        cell.decrease = {
            guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
            //details.meals = self.meals[indexPath.row]
            self.navigationController?.pushViewController(details, animated: true)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
        //details.meals = self.meals[indexPath.row]
        self.navigationController?.pushViewController(details, animated: true)
        
    }

}



extension HomeViewController{
    func getSlider() {
            self.homeViewModel.getSlider().subscribe(onNext: { (data) in
              
                self.homeViewModel.dismissIndicator()
                self.sliders = data.data?.sliders ?? []
                self.pageView.numberOfPages = self.sliders.count
                self.pageView.currentPage = 0
                DispatchQueue.main.async {
                    self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
                    }
                
            }, onError: { (error) in
                self.homeViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
    
    func getCat() {
            self.homeViewModel.getCategories().subscribe(onNext: { (data) in
                 self.homeViewModel.dismissIndicator()
                    self.category = data.data?.categories ?? []
                
            }, onError: { (error) in
                self.homeViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
    
    
    func getProduct() {
            self.homeViewModel.getProduct().subscribe(onNext: { (data) in
                 self.homeViewModel.dismissIndicator()
                    self.products = data.data?.products ?? []
                
            }, onError: { (error) in
                self.homeViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
    
    
    func addWishList(id : Int,isWishList : Bool) {
        self.homeViewModel.addWishList(id: id,isWishList :isWishList).subscribe(onNext: { (data) in
                self.getProduct()
            }, onError: { (error) in
                self.homeViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
}


struct RestaurantMeal {
    var nameAr : String!
    var image : UIImage!
    var descriptionAr : String!
}

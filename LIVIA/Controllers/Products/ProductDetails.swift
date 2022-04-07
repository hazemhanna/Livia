//
//  MakeOrderVC.swift
//  Shanab
//
//  Created by Macbook on 3/26/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import DLRadioButton
import RxSwift
import RxCocoa


class ProductDetails: UIViewController {
    
    @IBOutlet weak var slidercollectionView: UICollectionView!
    @IBOutlet weak var sizecollectionView: UICollectionView!
    @IBOutlet weak var RestaurantName: UILabel!
    @IBOutlet weak var FavoriteBN : UIButton!
    @IBOutlet weak var optionbleView: UITableView!
    @IBOutlet weak var OptionTableHeight: NSLayoutConstraint!
    @IBOutlet weak var sizeStackHeight: NSLayoutConstraint!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var notesTF: UITextField!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var othrtNote: UILabel!
    @IBOutlet weak var noteTF: UITextField!
    
    fileprivate let sliderCell = "SliderCell"
    fileprivate let cellIdentifierTableView = "OptionsTableViewCell"
    fileprivate let cellIdentifierCollectionView = "SizeCollectionViewCell"
    let headerCellIdentifier = "HeaderViewCell"
    
    var isFavourite = false
    var variant_id = Int()
    var productCounter = 1
    var optionCounter = 1
    var options : [[String : Int]] = [[:]]
    var optionPrice = 0.0
    var sizePrice = 0.0
    
    var total = 0.0
    
    var product: Product?
    var timer = Timer()
    var counter = 0
    
    
    private let cartViewModel = CartViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slidercollectionView.delegate = self
        slidercollectionView.dataSource = self
        slidercollectionView.register(UINib(nibName: sliderCell, bundle: nil), forCellWithReuseIdentifier: sliderCell)

        sizecollectionView.delegate = self
        sizecollectionView.dataSource = self
        sizecollectionView.register(UINib(nibName: cellIdentifierCollectionView, bundle: nil), forCellWithReuseIdentifier: cellIdentifierCollectionView)

        optionbleView.delegate = self
        optionbleView.dataSource = self
        optionbleView.register(UINib(nibName: cellIdentifierTableView, bundle: nil), forCellReuseIdentifier: cellIdentifierTableView)
        
        self.optionbleView.register(UINib(nibName: headerCellIdentifier, bundle: nil), forCellReuseIdentifier: headerCellIdentifier)
          size.text = "size".localized
          othrtNote.text = "othetnotes".localized

    }
    
    override func viewDidAppear(_ animated: Bool) {
        slidercollectionView.reloadData()
        optionbleView.reloadData()
        var size = 0
        for i in self.product?.productCollections ?? [] {
            size += 50 * (i.options?.count ?? 0)
        }
        OptionTableHeight.constant = CGFloat((30) * Int(CGFloat((self.product?.productCollections?.count ?? 0))) + (size))
        if "lang".localized == "ar" {
       self.RestaurantName.text = self.product?.title?.ar ?? ""
            self.desc.text = self.product?.desc?.ar?.parseHtml ?? ""
        }else{
            self.RestaurantName.text = self.product?.title?.en ?? ""
            self.desc.text = self.product?.desc?.en?.parseHtml ?? ""
        }
        
        self.sizePrice =  Double(self.product?.variants?[0].price ?? "") ?? 0
        self.total = Double(self.product?.variants?[0].price ?? "") ?? 0
        self.price.text = String(self.total) + " " + "EGP".localized
        
        self.variant_id = product?.variants?[0].id ?? 0
        if product?.type == "simple"{
            sizeStackHeight.constant = 0
        }else{
            sizeStackHeight.constant = 40
            sizecollectionView.reloadData()
        }
        
        self.isFavourite = self.product?.isWishlist ?? false
        if self.isFavourite {
            self.FavoriteBN.setImage(UIImage(named: "222"), for: .normal)
        }else{
            self.FavoriteBN.setImage(UIImage(named: "heart"), for: .normal)
        }
      
        self.pageView.numberOfPages = self.product?.images?.count ?? 0
        self.pageView.currentPage = 0
        
        DispatchQueue.main.async {
        self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
        if counter <  self.product?.images?.count ?? 0 {
              let index = IndexPath.init(item: counter, section: 0)
              self.slidercollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              pageView.currentPage = counter
              counter += 1
         } else {
              counter = 0
              let index = IndexPath.init(item: counter, section: 0)
              self.slidercollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
               pageView.currentPage = counter
               counter = 1
           }
      }
    
    @IBAction func Back(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cart(_ sender: Any) {
        setupSideMenu()
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "ScanVc") as? ScanVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    @IBAction func Increase(_ sender: UIButton) {
        if self.productCounter > 1 {
            self.productCounter -= 1
            quantityLbl.text = "\(self.productCounter)"
            let price = ((self.sizePrice) * Double(self.productCounter)) + optionPrice
            self.total = ((self.sizePrice) * Double(self.productCounter))  + optionPrice
            self.price.text = "\(price)" + "" + "EGP".localized
        }
    }
    
    @IBAction func decreaseBN(_ sender: UIButton) {
        self.productCounter += 1
        quantityLbl.text = "\(self.productCounter)"
        let price = ((self.sizePrice) * Double(self.productCounter))  + optionPrice
        self.total = ((self.sizePrice) * Double(self.productCounter))  + optionPrice
        self.price.text = "\(price)" + "" + "EGP".localized
    }
    
    
    @IBAction func confirm(_ sender: UIButton) {
        if Helper.getApiToken() ?? ""  == ""  {
            displayMessage(title: "", message: "You should login first".localized, status:.warning, forController: self)
       }else{
        self.cartViewModel.showIndicator()
        self.addToCart(product_id: self.product?.id ?? 0, variant_id: self.variant_id, message: self.noteTF.text ?? "", quantity: self.productCounter, options: self.options)
       }
        
    }
    
    @IBAction func favourit(_ sender: UIButton) {
        if Helper.getApiToken() ?? ""  == ""  {
            displayMessage(title: "", message: "You should login first".localized, status:.warning, forController: self)
       } else {
           self.cartViewModel.showIndicator()
           if isFavourite{
               self.isFavourite = false
                self.FavoriteBN.setImage(UIImage(named: "heart"), for: .normal)
               self.addWishList(id: self.product?.id ?? 0 , isWishList: self.isFavourite)
              }else{
                  self.isFavourite = true
                  self.FavoriteBN.setImage(UIImage(named: "222"), for: .normal)
                  self.addWishList(id: self.product?.id ?? 0 , isWishList: self.isFavourite)
              }
        }
    }
}


extension ProductDetails: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == slidercollectionView {
            return self.product?.images?.count ?? 0
        }else{
            return self.product?.variants?.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == slidercollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sliderCell, for: indexPath) as! SliderCell
            cell.config(imagePath:  self.product?.images?[indexPath.row].image ?? "")
        return cell
     }else {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierCollectionView, for: indexPath) as! SizeCollectionViewCell
         cell.confic(title: self.product?.variants?[indexPath.row].productSize?.localized ?? "",selected: self.product?.variants?[indexPath.row].selected ?? false)
         self.variant_id = product?.variants?[indexPath.row].id ?? 0

         return cell
        }
    }
    
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sizecollectionView {
            self.product?.variants?.forEach { model in
                model.selected = false
            }
            
            if self.product?.variants?.count ?? 0 > 0 {
            DispatchQueue.main.async {
                let selectedFilter = (self.product?.variants?[indexPath.row].selected ?? false) == false ? true : false
                self.product?.variants?[indexPath.row].selected = selectedFilter
                self.sizePrice = Double(self.product?.variants?[indexPath.row].price ?? "") ?? 0
                self.total = Double(self.product?.variants?[indexPath.row].price ?? "") ?? 0
                self.price.text = (self.product?.variants?[indexPath.row].price ?? "") + " " + "EGP".localized
                self.sizecollectionView.reloadData()
              }
            }
        }
    }
}

extension ProductDetails: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == slidercollectionView {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }else{
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size: CGFloat = (collectionView.frame.size.width - space) / 3.1
            return CGSize(width: size, height: collectionView.frame.size.height)
        }
    }
}


extension ProductDetails: UITableViewDelegate, UITableViewDataSource {
    
   func numberOfSections(in tableView: UITableView) -> Int {
       return self.product?.productCollections?.count ?? 0
   }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.product?.productCollections?[section].options?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierTableView, for: indexPath) as? OptionsTableViewCell else {return UITableViewCell()}
        let options =  self.product?.productCollections?[indexPath.section].options?[indexPath.row]

        if "lang".localized == "ar" {
          cell.confic(title: options?.title?.ar ?? "" , selected: options?.selected ?? false)
        }else{
          cell.confic(title: options?.title?.en ?? "" , selected: options?.selected ?? false)
        }
        
        cell.Increase = {
            self.optionCounter += 1
            cell.quantityLbl.text = "\(self.optionCounter)"
           // self.optionPrice = Double(self.product?.productCollections?[indexPath.section].options?[indexPath.row].variants?[0].price ?? "") ?? 0.0
            //self.price.text = String(self.total + (self.optionPrice))
           // self.total = (self.total + (self.optionPrice))
        }
        cell.Dicrease = {
            if self.optionCounter > 1 {
                self.optionCounter -= 1
                cell.quantityLbl.text = "\(self.optionCounter)"
                //self.price.text = String(self.total - (self.optionPrice))
               // self.total = (self.total - (self.optionPrice))
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if self.product?.productCollections?[indexPath.section].options?.count ?? 0 > 0 {
        let options =  self.product?.productCollections?[indexPath.section].options?[indexPath.row]
        DispatchQueue.main.async {
            let selectedFilter = (options?.selected ?? false) == false ? true : false
            options?.selected = selectedFilter
         self.optionPrice = Double(self.product?.productCollections?[indexPath.section].options?[indexPath.row].variants?[0].price ?? "") ?? 0.0
            var price = 0.0
            if selectedFilter {
                price = self.total + (self.optionPrice * Double(self.optionCounter))
                self.price.text = "\(price)" + "" + "EGP".localized
                self.total = price
            }else{
                price = (self.total) - (self.optionPrice * Double(self.optionCounter))
                self.price.text = "\(price)" + "" + "EGP".localized
                self.total = price
                self.optionPrice = 0.0
            }
            self.optionbleView.reloadData()
          }
        }
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentifier) as? HeaderViewCell else { return UITableViewCell()}
        cell.titleLbl.text = self.product?.productCollections?[section].name?.ar ?? ""
           return cell
       }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 50
    }
}

extension ProductDetails{
    
func addWishList(id : Int,isWishList : Bool) {
    self.cartViewModel.addWishList(id: id,isWishList :isWishList).subscribe(onNext: { (data) in
        self.cartViewModel.dismissIndicator()
        if data.value ?? false{
        }
    }, onError: { (error) in
            self.cartViewModel.dismissIndicator()
        }).disposed(by: disposeBag)
    }
    
    
    func addToCart(product_id : Int,variant_id : Int,message : String,quantity : Int,options : [[String : Int]]) {
        self.cartViewModel.addToCart(product_id: product_id, variant_id: variant_id, message: message, quantity: quantity, options: options).subscribe(onNext: { (data) in
            self.cartViewModel.dismissIndicator()
            if data.value ?? false{
            displayMessage(title: "", message: "Add to cart".localized , status: .success, forController: self)
            }else {
                displayMessage(title: "", message: data.msg ?? "" , status: .error, forController: self)

                
            }
        }, onError: { (error) in
                self.cartViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
    
}

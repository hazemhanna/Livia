//
//  File.swift
//  Livia
//
//  Created by MAC on 18/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CartVC: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var noProduct: UILabel!
    @IBOutlet weak var TableHeight: NSLayoutConstraint!
    @IBOutlet weak var discreption: UITextField!
    @IBOutlet weak var totalLbl   : UILabel!
    @IBOutlet weak var deliveryLbl   : UILabel!

    fileprivate let cellIdentifier = "ValiableResturantCell"
    var productCounter = Int()
    
    private let cartViewModel = CartViewModel()
    var disposeBag = DisposeBag()
    
    var cart = [Cart]() {
        didSet{
            DispatchQueue.main.async {
                self.cartTableView.reloadData()
                self.TableHeight.constant = CGFloat((150 * self.cart.count))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if  Helper.getApiToken() ?? ""  == ""  {
            displayMessage(title: "", message: "You should login first".localized, status:.warning, forController: self)
            noProduct.text = "You should login first".localized
            emptyView.isHidden = false
        } else {
            cartTableView.delegate = self
            cartTableView.dataSource = self
            cartTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
            noProduct.text = "emptyCart".localized
            cartViewModel.showIndicator()
            getCart()
        }
    }
    
    func show () {
        if cart.count > 0 {
            cartTableView.isHidden = false
            self.emptyView.isHidden = true
        }else{
            cartTableView.isHidden = true
            self.emptyView.isHidden = false
        }
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func confirmBtn(_ sender: Any) {
        guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "LocationDetailsVC") as? LocationDetailsVC else { return }
        Details.notes = self.discreption.text ?? ""
        self.navigationController?.pushViewController(Details, animated: true)
        
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
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

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
 

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ValiableResturantCell else {return UITableViewCell()}
        
        let product = cart[indexPath.row].product
        var image = ""
        
        if product?.images?.count ?? 0 > 0 {
            image = product?.images?[0].image ?? ""
        }
     
        if "lang".localized == "ar" {
        cell.configCart(name: product?.title?.ar ?? ""
                     ,price: cart[indexPath.row].price ?? ""
                    , imagePath: image
                    , type: product?.desc?.ar ?? ""
                    , quantity: cart[indexPath.row].quantity ?? 0
                    , discount: Double(cart[indexPath.row].product?.discount ?? "") ?? 0)
        }else{
            cell.configCart(name: product?.title?.en ?? ""
                         ,price: (cart[indexPath.row].price ?? "")
                         ,imagePath: image
                         ,type: product?.desc?.en ?? ""
                         ,quantity: cart[indexPath.row].quantity ?? 0
                         , discount: Double(cart[indexPath.row].product?.discount ?? "") ?? 0)
        }
        
        self.productCounter = cart[indexPath.row].quantity ?? 0
        
        cell.goToFavorites = {
            self.cartViewModel.showIndicator()
            self.removeCart(cart_id: self.cart[indexPath.row].id ?? 0)
         }
        
        cell.increase = {
            self.productCounter += 1
            cell.quantityTF.text = "\(self.productCounter)"
            self.cartViewModel.showIndicator()
            self.updateCart(cart_id: self.cart[indexPath.row].id ?? 0, quantity:  self.productCounter)
        }
        
        cell.decrease = {
            if self.productCounter > 1 {
                self.productCounter -= 1
                cell.quantityTF.text = "\(self.productCounter)"
                self.cartViewModel.showIndicator()
                self.updateCart(cart_id: self.cart[indexPath.row].id ?? 0, quantity:  self.productCounter)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
        details.product = self.cart[indexPath.row].product
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension CartVC {
    
    func getCart() {
        self.cartViewModel.getCart().subscribe(onNext: { (data) in
          self.cartViewModel.dismissIndicator()
          self.cart = data.data?.cart ?? []
            
            var totalPrice = 0
            var discPrice = 0
            for t in  self.cart {
                let price = Double(t.price ?? "") ?? 0.0
                totalPrice +=  Int(price) * (t.quantity ?? 0)
                let priceBeforDis = Double(t.productVariant?.price ?? "") ?? 0.0
                discPrice +=  Int(priceBeforDis) * (t.quantity ?? 0)
            }
            self.totalLbl.text = "totalPrice".localized + " " + String(totalPrice) + " " + "EGP".localized
            let discount = discPrice - totalPrice
           
            self.deliveryLbl.text = "totalDiscount".localized + " " + String(discount) + " " + "EGP".localized
            self.show ()
          }, onError: { (error) in
          self.cartViewModel.dismissIndicator()
         }).disposed(by: disposeBag)
    }
    
    func updateCart(cart_id : Int ,quantity:Int ) {
            self.cartViewModel.updateCart(product_id: cart_id, quantity: quantity).subscribe(onNext: { (data) in
                self.getCart()
            }, onError: { (error) in
                self.cartViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }

    func removeCart(cart_id : Int) {
            self.cartViewModel.removeCart(id: cart_id).subscribe(onNext: { (data) in
              self.getCart()
            }, onError: { (error) in
                self.cartViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
    
}


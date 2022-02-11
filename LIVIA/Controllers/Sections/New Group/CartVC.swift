//
//  CartVC.swift
//  Shanab
//
//  Created by Macbook on 3/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class CartVC: UIViewController {
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    private let OnlineCartVCPresenter = OnlineCartPresenter(services: Services())
    @IBOutlet weak var total: CustomLabel!
     @IBOutlet weak var noProduct: UILabel!
    @IBOutlet weak var minumemPrice : UILabel!

    @IBOutlet weak var TableHeight: NSLayoutConstraint!
    @IBOutlet weak var discreption: UITextView!
    
    var totalPrice = Double()
    var currency = String()
    var productCounter = 1
    var mealId = Int()
    var quantity = Int()
    var nameMeal = String()
    var mealComponents = String()
    var totalCartPrice: Double = 0.0
    var deletedIndex: Int = 0
    var price = 0.0
    var minemum = 0.0
    
    var vat = 0.0
    var fee = 0.0
    
    fileprivate let cellIdentifier = "CartCell"
    var CartIems = [onlineCart]() {
        didSet {
                self.cartTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    cartTableView.tableFooterView = UIView()
      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if  Helper.getApiToken() == "" || Helper.getApiToken() == nil {
            displayMessage(title: "", message: "You should login first".localized, status:.warning, forController: self)
            noProduct.text = "You should login first".localized
        } else {
            price = 0.0
            cartTableView.delegate = self
            cartTableView.dataSource = self
            cartTableView.tableFooterView = UIView()
            cartTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
            OnlineCartVCPresenter.setonlineCartViewDelegate(onlineCartViewDelegate: self)
            OnlineCartVCPresenter.showIndicator()
            OnlineCartVCPresenter.getCartItems()
            noProduct.text = "emptyCart".localized
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.cartTableView.layer.removeAllAnimations()
        TableHeight.constant = cartTableView.contentSize.height

        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
    
    
    @IBAction func confirm(_ sender: UIButton) {
        if price < minemum {
            
            displayMessage(title: "", message: "minumam".localized + ": \(minemum) \("S.R".localized)", status: .error, forController: self)
            
        }else {
        guard let Details = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "MyAddressesVC") as? MyAddressesVC else { return }
        Details.total = Double(total.text ?? "0.0") ?? 0.0
        Details.quantity = productCounter
        Details.vat = vat
        Details.fee = fee
        self.navigationController?.pushViewController(Details, animated: true)
        }
    
    }
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CartIems.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let Details = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "CartDetailsVC") as? CartDetailsVC else { return }
        Details.details = CartIems[indexPath.row]
        self.navigationController?.pushViewController(Details, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CartCell else {return UITableViewCell()}
        let meal = CartIems[indexPath.row].meal ?? Meal()
        let meal_price = meal.price?[0].price ?? 0
        cell.CartButton.isHidden = true
        cell.productCounter = CartIems[indexPath.row].quantity ?? 0
        if "lang".localized == "ar" {
        cell.config(name: meal.nameAr  ?? "", price: 0 , imagePath: meal.image ?? "", components: meal.descriptionAr ?? "")
        } else {
        cell.config(name: meal.nameEn  ?? "", price: 0 , imagePath: meal.image ?? "", components: meal.descriptionEn ?? "")
        }
        var price = Double(CartIems[indexPath.row].quantity ?? 0) * (CartIems[indexPath.row].meal?.price?[0].price ?? 0.0)
        cell.quantityLB.text = "\(self.CartIems[indexPath.row].quantity ?? 0)"
        if "lang".localized == "ar" {
             cell.orderName.text = self.CartIems[indexPath.row].meal?.nameAr ?? ""
        } else {
             cell.orderName.text = self.CartIems[indexPath.row].meal?.nameEn ?? ""
        }
        
        cell.price.text = "\(price.rounded(toPlaces: 2))"
        totalCartPrice += price
        cell.Dicrease = {
            if cell.productCounter > 1 {
                cell.productCounter -= 1
                cell.quantityLB.text = "\(self.productCounter)"
                let totalPrice = Double(meal_price) * Double(cell.productCounter)
                cell.price.text = "\(totalPrice.rounded(toPlaces: 2))"
                var totalPriceD = Double(self.total.text ?? "0.0")!
                totalPriceD -= Double(meal_price)
                self.total.text = "\(totalPriceD.rounded(toPlaces: 2))"
                Singletone.instance.cart[indexPath.row].quantity = (cell.productCounter)
            } else {
     
            }
            
        }
        cell.Increase = {
            cell.productCounter += 1
            cell.quantityLB.text = "\(self.productCounter)"
            let totalPrice = Double(meal_price) * Double(cell.productCounter)
            Singletone.instance.cart[indexPath.row].quantity = (cell.productCounter)
            cell.price.text = "\(totalPrice.rounded(toPlaces: 2))"
            var totalPriceD = Double(self.total.text ?? "0.0")!
            totalPriceD += Double(meal_price)
            self.total.text = "\(totalPriceD.rounded(toPlaces: 2))"
        }
        cell.delet = {
            self.deletedIndex = indexPath.row
            self.OnlineCartVCPresenter.showIndicator()
            self.OnlineCartVCPresenter.postDeleteCart(condition: "one" , id: self.CartIems[indexPath.row].id ?? 0)
        }
        if indexPath.row == CartIems.count - 1 {
        }
        return cell
    }
}

extension CartVC: onlineCartViewDelegate {
    func postDeleteCart(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage == "" {
                price = 0.0
                displayMessage(title: "", message: "Item deleted from cart".localized, status: .success, forController: self)
                self.CartIems.remove(at: deletedIndex)
                self.OnlineCartVCPresenter.getCartItems()
            } else if !resultMsg.condition.isEmpty ,resultMsg.condition != [""] {
                displayMessage(title: "", message: resultMsg.condition[0], status: .error, forController: self)
            } else if !resultMsg.id.isEmpty ,resultMsg.id != [""] {
                displayMessage(title: "", message: resultMsg.id[0], status: .error, forController: self)
            }
        }
    }
    
    func FavoriteResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "", message: resultMsg.successMessage, status: .success, forController: self)
            } else if resultMsg.item_id != [""] {
                displayMessage(title: "", message: resultMsg.item_id[0], status: .error, forController: self)
            } else if resultMsg.item_type != [""] {
                displayMessage(title: "", message: resultMsg.item_type[0], status: .error, forController: self)
            }
        }
    }
    
    func RemoveFavorite(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "", message: resultMsg.successMessage, status: .success, forController: self)
            } else if resultMsg.item_id != [""] {
                displayMessage(title: "", message: resultMsg.item_id[0], status: .error, forController: self)
            } else if resultMsg.item_type != [""] {
                displayMessage(title: "", message: resultMsg.item_type[0], status: .error, forController: self)
            }
        }
        
    }
    
    func getCartResult(_ error: Error?, _ result: OnlinetDataClass?) {
        if let cart_items = result?.cart {
            self.cartTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
            self.vat = Double(result?.vat ?? "0.0") ?? 0.0
            switch result?.fee {
            case .int(let x):
                self.fee = x
            case .string(let x):
                self.fee = Double(x) ?? 0.0
            default:
                break
            }
            self.CartIems = cart_items
            var count = 0
            for EditPrice in CartIems {
                if EditPrice.meal?.hasOffer == 1 {
                    var discount = (Double(EditPrice.meal?.discount ?? 0))
                    if EditPrice.meal?.discountType == "percentage" {
                        discount /= 100
                        discount = ((EditPrice.meal?.price?[0].price ?? 0.0) - ((EditPrice.meal?.price?[0].price ?? 0.0 ) * Double(discount))).rounded(toPlaces: 2)
                    } else {
                        discount = ((EditPrice.meal?.price?[0].price ?? 0.0) -  Double(discount)).rounded(toPlaces: 2)
                    }
                    CartIems[count].meal?.price?[0].price = discount
                    print(discount ,"\n" , CartIems[count].meal?.price?[0].price)
                }
                count += 1
            }
            for i in CartIems {
                var priceForItem = Double(i.quantity ?? 0) * (i.meal?.price?[0].price ?? 0.0)
                for j in i.optionsContainer! {
                  //  var price = 0.0
                    switch j.options?.price {
                    case .double(let s):
                        price = Double(Double(j.quantity ?? 0) * s)
                        price = price.rounded(toPlaces: 2)
                    default:
                        break
                    }
                    priceForItem += price
                }
                price += priceForItem
            }
            total.text = "\(price.round(to: 2))"
            Singletone.instance.cart = CartIems
            totalCartPrice = 0
            if self.CartIems.count == 0 {
                self.emptyView.isHidden = false
                self.cartTableView.isHidden = true
            } else {
                self.cartTableView.reloadData()
                self.emptyView.isHidden = true
                self.cartTableView.isHidden = false
            }
            minemum = Double(cart_items.first?.meal?.restaurant?.minimum ?? 0)
            minumemPrice.text = "minumam".localized + ": \(cart_items.first?.meal?.restaurant?.minimum ?? 0) \("S.R".localized)"
        }
        DispatchQueue.main.async {
            self.cartTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        }
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

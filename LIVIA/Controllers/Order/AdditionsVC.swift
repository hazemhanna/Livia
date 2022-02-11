//
//  MakeOrderVC.swift
//  Shanab
//
//  Created by Macbook on 3/26/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import DLRadioButton
class AdditionsVC: UIViewController {
    @IBOutlet weak var AdditionTableView: UITableView!
    @IBOutlet weak var quantityTF: UILabel!
    @IBOutlet weak var emptyView: UIView!
    private let AdditionalVCPresenter = AdditionsPresenter(services: Services())
    @IBOutlet weak var stackViewST: UIStackView!
    @IBOutlet weak var mealNameLB: UILabel!
    @IBOutlet weak var caloriesLB: UILabel!
    @IBOutlet weak var notesTF: UITextField!
    @IBOutlet weak var oneImageView: UIImageView!
    @IBOutlet weak var mealComponentsLB: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var discount : UILabel!
    @IBOutlet weak var RestaurantName: UILabel!
    
    fileprivate let cellIdentifier = "AdditionsCell"
    fileprivate let HeaderIdentifier = "HeaderCell"
    
    
    @IBOutlet weak var OptionTableHeight: NSLayoutConstraint!
    
    var restaurant_id = Int()
    var restaurantName = String()
    var total = Double()
    var meal_id = Int()
    var cartItems = [onlineCart]()
    var currency = String()
    var productCounter = 1
    var CurrentIndex = 0
    var selections = [(id:Int , qun: Int)]()
    var selected = Bool()
    var imagePath = String()
    var mealName = String()
    var mealComponents = String()
    var mealCalory = String()
    var image = String()
    var MealPrice = Double()
    var mealDetails =  [Collection]() {
        didSet {
            DispatchQueue.main.async {
                self.AdditionTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if "lang".localized == "ar" {
            price.text = "\(total) ريال"
        } else {
            price.text = "\(total) SAR"
        }
          if (!imagePath.contains("http")) {
                  guard let imageURL = URL(string: (BASE_URL + "/" + imagePath).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
                  print(imageURL)
                  self.oneImageView.kf.setImage(with: imageURL)
              }  else if imagePath != "" {
                  guard let imageURL = URL(string: imagePath) else { return }
                  self.oneImageView.kf.setImage(with: imageURL)
              } else {
                  self.oneImageView.image = #imageLiteral(resourceName: "shanab loading")
              }
        
        RestaurantName.text = restaurantName
        mealNameLB.text = mealName
        mealComponentsLB.text = mealComponents
        caloriesLB.text =  mealCalory
        AdditionTableView.delegate = self
        AdditionTableView.dataSource = self
        AdditionTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        AdditionTableView.register(UINib(nibName: HeaderIdentifier, bundle: nil), forCellReuseIdentifier: HeaderIdentifier)
        AdditionalVCPresenter.setAdditionsViewDelegate(AdditionsViewDelegate: self)
        AdditionalVCPresenter.showIndicator()
        AdditionalVCPresenter.postMealDetails(meal_id: meal_id)
        stackViewST.layer.cornerRadius = 20
        
        
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.AdditionTableView.layer.removeAllAnimations()
        OptionTableHeight.constant = AdditionTableView.contentSize.height

        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cart(_ sender: Any) {
//        guard let window = UIApplication.shared.keyWindow else { return }
//
//        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
//
//        details.selectedIndex = 2
//        self.navigationController?.pushViewController(details, animated: true)
        
        setupSideMenu()
       // window.rootViewController = details
        
    }
    @IBAction func Increase(_ sender: UIButton) {
        self.productCounter += 1
        self.quantityTF.text = "\(self.productCounter)"
        
        print(self.price.text?.replace(string: "S.R".localized, replacement: ""))
        
        let OldPrice = Double(self.price.text?.replace(string: "S.R".localized, replacement: "") ?? "0.0")

        self.price.text = "\((OldPrice! +  MealPrice).rounded(toPlaces: 2))" + "S.R".localized
       
        
    }
    @IBAction func cartListButton(_ sender: Any) {
        
    }
    @IBAction func decreaseBN(_ sender: UIButton) {
        if productCounter > 1 {
            self.productCounter -= 1
            self.quantityTF.text = "\(self.productCounter)"
            let OldPrice = Double(self.price.text?.replace(string: "S.R".localized, replacement: "") ?? "0.0")
            self.price.text = "\((OldPrice! - MealPrice).rounded(toPlaces: 2))"  + "S.R".localized

        } else {
            self.productCounter = 1
            self.quantityTF.text = "\(self.productCounter)"
            self.price.text = "\(MealPrice) " + "S.R".localized

        }
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        
        if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
            
            displayMessage(title: "", message: "You should login first".localized, status:.warning, forController: self)
        } else {
        AdditionalVCPresenter.showIndicator()
        AdditionalVCPresenter.postAddToCart(meal_id: meal_id, quantity: productCounter, message: notesTF.text ?? "", options: selections)
            
        }
    }
}
extension AdditionsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealDetails[section].option?.count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return mealDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for:
            indexPath) as? AdditionsCell else {return UITableViewCell()}
        
        
        var options = self.mealDetails[indexPath.section].option ?? [Options]()
        
        if "lang".localized == "en" {
            if CurrentIndex == indexPath.row && self.selected {
                cell.config(name: options[indexPath.row].nameEn ?? "", selected: true)
            } else {
                cell.config(name: options[indexPath.row].nameEn ?? "", selected: false)
            }
            
        } else {
            if CurrentIndex == indexPath.row && self.selected {
                cell.config(name: options[indexPath.row].nameAr ?? "", selected: true)
            } else {
                cell.config(name: options[indexPath.row].nameAr ?? "", selected: false)
            }
            
        }
        
        cell.CounterSt.isHidden = true
        var quan = 1
        cell.increase = {
            
            quan = Int(cell.QuantityLb.text ?? "0") ?? 0
            quan += 1
            cell.QuantityLb.text = "\(quan)"
            
            for i in 0..<self.selections.count {
                
                if options[indexPath.row].id == self.selections[i].id {
                    
                    self.selections[i].qun = quan
                    
                    print(self.price.text)
                    print(self.price.text?.replace(string: "S.R".localized, replacement: ""))
                    let OldPrice = Double(self.price.text?.replace(string: "S.R".localized, replacement: "") ?? "0.0")
                    
                    print(OldPrice)
                    switch options[indexPath.row].price {
                    
                    case .Arr(let price):
                        self.price.text = "\((OldPrice! + Double((price[0].price ?? 0.0) * Double(quan))).rounded(toPlaces: 2))"  + "S.R".localized
                    case .double(let priceV):
                        self.price.text = "\((OldPrice! + Double(priceV)).rounded(toPlaces: 2))"  + "S.R".localized

                    default:
                        break
                    }
                    
                    break
                }
            }
            
            //self.selections.append((id: options[indexPath.row].id ?? 0, qun: quan))
        }
        
        cell.decrease = {
            
                    quan = Int(cell.QuantityLb.text ?? "0") ?? 0
                    
                    if quan > 1 {
                    quan -= 1
                    cell.QuantityLb.text = "\(quan)"
                    
                    for i in 0..<self.selections.count {
                        
                        if options[indexPath.row].id == self.selections[i].id {
                            
                            self.selections[i].qun = quan
                            let OldPrice = Double(self.price.text?.replace(string: "S.R".localized, replacement: "") ?? "0.0")
                            switch options[indexPath.row].price {
                            case .Arr(let price):
                                self.price.text = "\((OldPrice! + Double((price[0].price ?? 0.0) * Double(quan))).rounded(toPlaces: 2))"  + "S.R".localized
                            case .double(let price):
                                self.price.text = "\((OldPrice! - Double(price)).rounded(toPlaces: 2))"

                            default:
                                break
                            }
                            
                            break
                        }
                    }
                }
        
        }
        
        cell.selectionOption = { selection in
            
            if selection {
                
                cell.CounterSt.isHidden = false
                
                let OldPrice = Double(self.price.text?.replace(string: "S.R".localized, replacement: "") ?? "0.0")
                switch options[indexPath.row].price {
                
                case .Arr(let price):
                    
                    self.price.text = "\((OldPrice! + Double((price[0].price ?? 0.0) * Double(quan))).rounded(toPlaces: 2))"  + "S.R".localized
                    
                case .double(let price):
                    
                    self.price.text = "\((OldPrice! + Double(price)).rounded(toPlaces: 2))"

                default:
                    break
                }
                
                self.selections.append((id: options[indexPath.row].id ?? 0, qun: 1))
            } else {
                
                for i in 0..<self.selections.count {
                    
                    if self.selections[i].id == options[indexPath.row].id {
                        
                        let OldPrice = Double(self.price.text?.replace(string: "S.R".localized, replacement: "") ?? "0.0")
                        switch options[indexPath.row].price {
                        case .Arr(let price):
                            self.price.text = "\((OldPrice! + Double((price[0].price ?? 0.0) * Double(quan))).rounded(toPlaces: 2))"
                        case .double(let price):
                            self.price.text = "\((OldPrice! - Double(price * Double(self.selections[i].qun))).rounded(toPlaces: 2))"

                        default:
                            break
                        }
                        
                        cell.QuantityLb.text = "1"
                        self.selections.remove(at: i)
                        break
                        print(self.selections)
                    }
                }
                cell.CounterSt.isHidden = true
            }
            
         //   self.selected = true
        //    for i in 0..<self.selections.count {
                
                
//                if i == indexPath.row {
//                    self.CurrentIndex = i
//                    self.selections.append(options[self.CurrentIndex].id ?? 0)
//                } else {
//                    options[i].selected = false
//                }
                
          //  }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderIdentifier) as? HeaderCell else {return UITableViewCell()}
        if "lang".localized == "ar" {
            cell.config(mealName: mealDetails[section].nameAr ?? "" )
            return cell
        } else {
            cell.config(mealName: mealDetails[section].nameEn ?? "" )
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
}
extension AdditionsVC: AdditionsViewDelegate {
    func postAddToCartResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "Order added successfully".localized, message: resultMsg.successMessage, status: .success, forController: self)
                Singletone.instance.cart = cartItems
                   
            } else if resultMsg.meal_id != [""] {
                displayMessage(title: "", message: resultMsg.meal_id[0], status: .error, forController: self)
            } else if resultMsg.quantity != [""] {
                displayMessage(title: "", message: resultMsg.quantity[0], status: .error, forController: self)
            } else if resultMsg.message != [""] {
                displayMessage(title: "", message: resultMsg.message[0], status: .error, forController: self)
            } else if resultMsg.options != [""] {
                displayMessage(title: "", message: resultMsg.options[0], status: .error, forController: self)
            }
        }
    }
    
    func MealDetailsResult(_ error: Error?, _ details: CollectionDataClass?) {
        if let lists = details {
            self.mealDetails = lists.collection ?? []
            if self.mealDetails.count == 0 {
              //  self.emptyView.isHidden = false
                self.AdditionTableView.isHidden = true
            } else {
                self.emptyView.isHidden = true
                self.AdditionTableView.isHidden = false
            }
            
            self.discount.text = "\(lists.price?[0].price?.rounded(toPlaces: 2) ?? 0.0)"
            self.MealPrice = lists.price?[0].price?.rounded(toPlaces: 2)  ?? 0.0
            
            let total = Double(lists.price?[0].price ?? 0) - Double(lists.discount ?? 0)
            self.price.text = "\(total)"
        }
        
    self.AdditionTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)

    }
    
}

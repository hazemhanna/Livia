//
//  SearchVC.swift
//  Shanab
//
//  Created by Macbook on 3/25/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    @IBOutlet weak var sigmentSearch: UISegmentedControl!
    //    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var MealsTableView: UITableView!
    @IBOutlet weak var SegmantStackView: UIStackView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchStack: UIStackView!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var empyView : UIView!

    
    private let cellForTable = "ProductiveFamiliesCell"
    private let MealsCellIdentifier = "BestSellerCell"
    var type = String()
    var id = Int()
    var isSearching = false
    var restaurants_list = [Restaurant]()
    
    var MealSearch = [CollectionDataClass]() {
        didSet {
            DispatchQueue.main.async {
                self.MealsTableView.reloadData()
            }
        }
    }
    
    var NormalResult = [SearchResult]() {
        didSet {
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }
    
    private let SearchVCPresenter = SearchPresenter(services: Services())
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.type = "meal"

        searchTableView.delegate = self
        searchTableView.dataSource = self
        MealsTableView.delegate = self
        MealsTableView.dataSource = self
        MealsTableView.tableFooterView = UIView()
        searchTableView.tableFooterView = UIView()
        searchBar.returnKeyType = UIReturnKeyType.done
        searchTableView.register(UINib(nibName: cellForTable, bundle: nil), forCellReuseIdentifier: cellForTable)
        MealsTableView.register(UINib(nibName: MealsCellIdentifier, bundle: nil), forCellReuseIdentifier: MealsCellIdentifier)
        SearchVCPresenter.setSearchViewDelegate(SearchViewDelegate: self)
        searchStack.layer.borderColor = #colorLiteral(red: 0.9195484519, green: 0.2682709396, blue: 0.21753335, alpha: 1)
        searchStack.layer.borderWidth = 1
        searchStack.layer.cornerRadius = 20
        
        searchBar.delegate = self
        
    }
    
  

    
    @IBAction func sigmentPressed(_ sender: Any) {
        switch sigmentSearch.selectedSegmentIndex
        
        {
        case 1:
            self.type = "restaurant"
            if self.searchBar.text == "" {
                self.MealsTableView.isHidden = false
                self.searchTableView.isHidden = true
            } else {
                self.searchTableView.isHidden = false
                self.MealsTableView.isHidden = true
                SearchVCPresenter.showIndicator()
                SearchVCPresenter.postRestaurantSearch(word: self.searchBar.text ?? "")
                
            }
        case 0:
            self.type = "meal"
            if self.searchBar.text == "" {
                self.searchTableView.isHidden = false
                self.MealsTableView.isHidden = true
            } else {
                self.MealsTableView.isHidden = false
                self.searchTableView.isHidden = true
                SearchVCPresenter.showIndicator()
                SearchVCPresenter.postMealSearch(word: self.searchBar.text ?? "")
                
            }
        default:
            break
        }
    }
    
    
    //    @IBAction func sideMenu(_ sender: UIBarButtonItem) {
    //        self.setupSideMenu()
    //    }
    @IBAction func backButton(_ sender: Any) {
        guard let window = UIApplication.shared.keyWindow else { return }
        let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar")
        window.rootViewController = sb
        UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
    }
}
extension SearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == "restaurant" {
            return NormalResult.count
        } else if type == "meal" {
            
            print(MealSearch.count)
            return MealSearch.count
        }
        else {
            return NormalResult.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if type ==  "restaurant" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellForTable, for: indexPath) as? ProductiveFamiliesCell else { return UITableViewCell()}
            
            cell.FavoriteBN.isHidden = true

            
            if "lang".localized == "en" {
                cell.config(familyName: NormalResult[indexPath.row].nameEn ?? "" , time: 0 , imagePath: NormalResult[indexPath.row].image ?? "" , productName: NormalResult[indexPath.row].type ?? "", price: 0, rate: Double(NormalResult[indexPath.row].rate ?? 0))
            } else {
                cell.config(familyName: NormalResult[indexPath.row].nameAr ?? "" , time: 0 , imagePath: NormalResult[indexPath.row].image ?? "" , productName: NormalResult[indexPath.row].type ?? "", price: 0, rate: Double(NormalResult[indexPath.row].rate ?? 0))
            }
           
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MealsCellIdentifier, for: indexPath) as? BestSellerCell else { return UITableViewCell()}
            
            cell.price.isHidden = true
            cell.AddToCartBtn.isHidden = true
            cell.discount.isHidden = true
            cell.FavoriteBN.alpha = 0
            cell.PriceLB.isHidden = true
            
            
            if "lang".localized == "en"{
                cell.config(imagePath: MealSearch[indexPath.row].image ?? "", name: MealSearch[indexPath.row].nameEn ?? "", mealComponants: MealSearch[indexPath.row].descriptionEn ?? "", price: MealSearch[indexPath.row].price?[0].price ?? 0.0, discount: 0)
            } else {
                cell.config(imagePath: MealSearch[indexPath.row].image ?? "", name: MealSearch[indexPath.row].nameAr ?? "", mealComponants: MealSearch[indexPath.row].descriptionAr ?? "", price: MealSearch[indexPath.row].price?[0].price ?? 0.0, discount: 0)
            }
            
            cell.goToFavorites = {
               
                if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
                    
                    displayMessage(title: "".localized, message: "You should login first".localized, status:.warning, forController: self)

                } else {
                    
                }
            }
           
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
  
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension SearchVC: SearchViewDelegate {
    
    
    func FavoriteResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if !resultMsg.successMessage.isEmpty, resultMsg.successMessage != "" {
                displayMessage(title: "Done", message: resultMsg.successMessage, status: .success, forController: self)
            } else if !resultMsg.item_id.isEmpty, resultMsg.item_id != [""] {
                displayMessage(title: "", message: resultMsg.item_id[0], status: .error, forController: self)
            } else if !resultMsg.item_type.isEmpty, resultMsg.item_type != [""] {
                displayMessage(title: "", message: resultMsg.item_type[0], status: .error, forController: self)
            }
        }
    }
    
    
    func RemoveFavorite(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "Done".localized, message: resultMsg.successMessage, status: .success, forController: self)
            } else if resultMsg.item_id != [""] {
                displayMessage(title: "Done".localized, message: resultMsg.item_id[0], status: .error, forController: self)
            } else if resultMsg.item_type != [""] {
                displayMessage(title: "", message: resultMsg.item_type[0], status: .error, forController: self)
            }
        }
    }
    
    func MealSearchResult(_ error: Error?, _ result: [CollectionDataClass]?) {
        if let lists = result{
            self.MealSearch = lists
        }
        
        if MealSearch.count > 0 {
            empyView.isHidden = true
        }else{
            empyView.isHidden = false
        }
        
        self.MealsTableView.reloadData()

        
    }
    func RestaurantSearchResult(_ error: Error?, _ restaurantResult: [SearchResult]?) {
        if let lists = restaurantResult {
            
            self.NormalResult =  lists
            if NormalResult.count > 0 {
                empyView.isHidden = true
            }else{
                empyView.isHidden = false
            }
        }
        
        self.searchTableView.reloadData()

    }
}
extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.searchTableView.isHidden = true
            self.MealsTableView.isHidden = true
            
        } else {
            
            if type == "restaurant" {
                SearchVCPresenter.showIndicator()
                SearchVCPresenter.postRestaurantSearch(word: self.searchBar.text ?? "")
                isSearching = true
                self.searchTableView.isHidden = false
                self.MealsTableView.isHidden = true
                
                self.searchTableView.reloadData()
                
                if NormalResult.count > 0 {
                    empyView.isHidden = true
                }else{
                    empyView.isHidden = false
                }
                
            } else {
                
                SearchVCPresenter.showIndicator()
                SearchVCPresenter.postMealSearch(word: self.searchBar.text ?? "")
                isSearching = true
                self.MealsTableView.isHidden = false
                self.searchTableView.isHidden = true
                self.MealsTableView.reloadData()
            
                if MealSearch.count > 0 {
                    empyView.isHidden = true
                }else{
                    empyView.isHidden = false
                }
                
            }
        }
    }
}

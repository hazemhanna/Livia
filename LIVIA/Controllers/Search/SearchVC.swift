//
//  SearchVC.swift
//  Livia
//
//  Created by MAC on 22/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//



import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var empyView : UIView!

    private let cellForTable = "FavouriteCell"

    var meals = [RestaurantMeal]() {
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
        searchTableView.tableFooterView = UIView()
        searchBar.returnKeyType = UIReturnKeyType.done
        searchTableView.register(UINib(nibName: cellForTable, bundle: nil), forCellReuseIdentifier: cellForTable)
        searchBar.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        
        meals.append(RestaurantMeal(nameAr: "بيتزا خضروات", image: #imageLiteral(resourceName: "Screen Shot 2022-02-11 at 4.19.53 AM"), descriptionAr: "بيتزا"))
        
        meals.append(RestaurantMeal(nameAr: "سلطة خضراء", image: #imageLiteral(resourceName: "taylor-kiser-EvoIiaIVRzU-unsplash-1"), descriptionAr: "سلطة"))
        
        meals.append(RestaurantMeal(nameAr: "بيتزا سي فود", image: #imageLiteral(resourceName: "food-1"), descriptionAr: "بيتزا"))

        meals.append(RestaurantMeal(nameAr: "بيتزا فراخ", image: #imageLiteral(resourceName: "Screen Shot 2022-02-11 at 4.19.53 AM"), descriptionAr: "بيتزا"))
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension SearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellForTable, for: indexPath) as? FavouriteCell else { return UITableViewCell()}
            
        cell.config(name: meals[indexPath.row].nameAr ?? "",price: 12.2, imagePath: meals[indexPath.row].image  , type: meals[indexPath.row].descriptionAr ?? "")
        cell.FavoriteBN.setImage(UIImage(named: "heart"), for: .normal)

    
        cell.RemoveFromeFavorite = {
            if cell.isFavourite{
                cell.FavoriteBN.setImage(UIImage(named: "heart"), for: .normal)
                cell.isFavourite = false
            }else{
                cell.FavoriteBN.setImage(UIImage(named: "222"), for: .normal)
                cell.isFavourite = true
            }
        }
        
        
        cell.AddToCart = {
            displayMessage(title: "", message: "تم الاضافة الي السلة بنجاح".localized, status:.success, forController: self)
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

}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.searchTableView.isHidden = true
         }else {
                self.searchTableView.isHidden = false
                self.searchTableView.reloadData()
                if meals.count > 0 {
                    empyView.isHidden = true
                }else{
                    empyView.isHidden = false
                }
                
            }
        }
   }



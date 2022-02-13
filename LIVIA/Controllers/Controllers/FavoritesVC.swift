//
//  FavoritesVC.swift
//  Shanab
//
//  Created by Macbook on 3/30/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
class FavoritesVC: UIViewController {
    fileprivate let cellIdentifier = "ValiableResturantCell"
    var item_type = "restaurant"
    var deletedIndex: Int = 0
    private let UserFavoritesVCPresenter = UserFavoritesPresenter(services: Services())
    @IBOutlet weak var favoriteTableView: UITableView!
    var ClientFavoriteList = [Favorites]() {
        didSet {
            DispatchQueue.main.async {
                self.favoriteTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.tableFooterView = UIView()
        favoriteTableView.rowHeight = UITableView.automaticDimension
        favoriteTableView.estimatedRowHeight = UITableView.automaticDimension
        favoriteTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        UserFavoritesVCPresenter.setUserFavoritesViewDelegate(UserFavoritesViewDelegate: self)
        UserFavoritesVCPresenter.showIndicator()
        UserFavoritesVCPresenter.postFavoriteGet(item_type: "restaurant")
        
    }
    @IBAction func sideMenu(_ sender: Any) {
         self.setupSideMenu()
    }
    @IBAction func cart(_ sender: Any) {
//        guard let window = UIApplication.shared.keyWindow else { return }
//
//        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
//
//        details.selectedIndex = 2
//        window.rootViewController = details
        self.navigationController?.popViewController(animated: true)
    }
}
extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClientFavoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ValiableResturantCell else {return UITableViewCell()}
        
     //   cell.price.isHidden = true
        guard let item_type = ClientFavoriteList[indexPath.row].restaurant else {return UITableViewCell() }
        cell.FavoriteBN.setBackgroundImage(#imageLiteral(resourceName: "heart 2"), for: .normal)
        
        cell.goToFavorites = {
            self.deletedIndex = indexPath.row
            self.UserFavoritesVCPresenter.showIndicator()
            self.UserFavoritesVCPresenter.postRemoveFavorite(item_id: self.ClientFavoriteList[indexPath.row].itemID ?? 0, item_type: self.ClientFavoriteList[indexPath.row].itemType ?? "")
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
    }
}
extension FavoritesVC: UserFavoritesViewDelegate {
    func RemoveFavorite(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
            if "lang".localized == "en" {
                    displayMessage(title: "Remove from Favorite List", message: "", status: .success, forController: self)
            } else {
                    displayMessage(title: "تم الحذف من المفضلة", message: "", status: .success, forController: self)
            }
                self.ClientFavoriteList.remove(at: deletedIndex)
                self.favoriteTableView.reloadData()
                
            } else if resultMsg.item_id != [""] {
                displayMessage(title: "", message: resultMsg.item_id[0], status: .error, forController: self)
            } else if resultMsg.item_type != [""] {
                displayMessage(title: "", message: resultMsg.item_type[0], status: .error, forController: self)
            }
        }
    }
    
    func UserFavoritesResult(_ error: Error?, _ favoriteList: [Favorites]?) {
        if let lists = favoriteList{
            self.ClientFavoriteList = lists.reversed()
            
        }
        
        
    }
}

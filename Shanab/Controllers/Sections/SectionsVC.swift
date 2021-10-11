//
//  SectionsVC.swift
//  Shanab
//
//  Created by Macbook on 3/25/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class SectionsVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var sectionCollectionView: UICollectionView!
    private let CatgeoriesVCPresenter = CatgeoriesPresenter(services: Services())
    
    var catgeories = [Category]() {
        didSet {
            DispatchQueue.main.async {
                self.sectionCollectionView.reloadData()
            }
        }
    }
    fileprivate let cellIdentifier = "SectionCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionCollectionView.delegate = self
        sectionCollectionView.dataSource = self
        sectionCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        CatgeoriesVCPresenter.setCatgeoriesViewDelegate(CatgeoriesViewDelegate: self)
        CatgeoriesVCPresenter.showIndicator()
        CatgeoriesVCPresenter.getCatgeories()
 
        
    }
    
    @IBAction func cart(_ sender: Any) {
        guard let window = UIApplication.shared.keyWindow else { return }

        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
        
        details.selectedIndex = 2
        window.rootViewController = details
    }
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
}


extension SectionsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catgeories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? SectionCell else { return UICollectionViewCell()}
        if "lang".localized == "ar" {
            cell.config(imagePath: catgeories[indexPath.row].image ?? "", name: catgeories[indexPath.row].nameAr ?? "")
            return cell
        } else {
            cell.config(imagePath: catgeories[indexPath.row].image ?? "", name: catgeories[indexPath.row].nameEn ?? "")
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "MealDetailsVC") as? MealDetailsVC else { return }
        details.category_id =  self.catgeories[indexPath.row].id ?? 0
        details.image = self.catgeories[indexPath.row].image ?? ""
        if "lang".localized == "en" {
            details.Name = self.catgeories[indexPath.row].nameEn ?? ""
            
        }
        details.Name = self.catgeories[indexPath.row].nameAr ?? ""
        self.navigationController?.pushViewController(details, animated: true)
    }
    
}
extension SectionsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 2.1
        return CGSize(width: size  , height: size - 20)
    }
    
}
extension SectionsVC: CatgeoriesViewDelegate {
    func CatgeoriesResult(_ error: Error?, _ catgeory: [Category]?) {
        if let catgeoryList = catgeory {
            self.catgeories = catgeoryList
        }
    }
    
    
}

//
//  SectionsVC.swift
//  Shanab
//
//  Created by Macbook on 3/25/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class SectionsVC: UIViewController {
    @IBOutlet weak var titleLbl  : UILabel!

    @IBOutlet weak var sectionCollectionView: UICollectionView!
    fileprivate let cellIdentifier = "SectionCell"

    var meals = [RestaurantMeal]() {
        didSet{
            DispatchQueue.main.async {
                self.sectionCollectionView.reloadData()
            }
        }
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionCollectionView.delegate = self
        sectionCollectionView.dataSource = self
        sectionCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        meals.append(RestaurantMeal(nameAr: "بيتزا ", image: #imageLiteral(resourceName: "Screen Shot 2022-02-27 at 10.59.12 PM"), descriptionAr: "بيتزا"))

        meals.append(RestaurantMeal(nameAr: "برجر", image: #imageLiteral(resourceName: "Set of cartoon pizzas with different stuffing"), descriptionAr: "برجر"))
        
        meals.append(RestaurantMeal(nameAr: "مشروبات", image:#imageLiteral(resourceName: "Set of cartoon pizzas with different stuffing-2"), descriptionAr: "سلطة"))
        
        meals.append(RestaurantMeal(nameAr: "فطار", image: #imageLiteral(resourceName: "Screen Shot 2022-02-27 at 10.59.04 PM"), descriptionAr: "بيتزا"))

        meals.append(RestaurantMeal(nameAr: "سلطة ", image: #imageLiteral(resourceName: "Screen Shot 2022-02-27 at 10.58.56 PM"), descriptionAr: "بيتزا"))
        
        meals.append(RestaurantMeal(nameAr: "مقبلات ", image:#imageLiteral(resourceName: "Screen Shot 2022-02-27 at 10.59.20 PM"), descriptionAr: "بيتزا"))

    }
    

    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }

    @IBAction func backBtn(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "ScanVc") as? ScanVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
}


extension SectionsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? SectionCell else { return UICollectionViewCell()}
        cell.config(imagePath: meals[indexPath.row].image, name: meals[indexPath.row].nameAr ?? "")
        return cell

        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductsVc") as? ProductsVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    
}
extension SectionsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 2.1
        return CGSize(width: size  , height: size )
    }
    
}

//
//  SectionsVC.swift
//  Shanab
//
//  Created by Macbook on 3/25/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SectionsVC: UIViewController {
    @IBOutlet weak var titleLbl  : UILabel!

    @IBOutlet weak var sectionCollectionView: UICollectionView!
    fileprivate let cellIdentifier = "SectionCell"

    var category = [Category](){
        didSet{
            DispatchQueue.main.async {
                self.sectionCollectionView.reloadData()
            }
        }
    }
    private let homeViewModel = HomeViewModel()
    var disposeBag = DisposeBag()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionCollectionView.delegate = self
        sectionCollectionView.dataSource = self
        sectionCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        titleLbl.text = "Sections".localized
        self.homeViewModel.showIndicator()
        getCat()
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
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? SectionCell else { return UICollectionViewCell()}
        if "lang".localized == "ar" {
            cell.config(imagePath: self.category[indexPath.row].image ?? "", name: self.category[indexPath.row].title?.ar ?? "")
        }else{
            cell.config(imagePath: self.category[indexPath.row].image ?? "", name: self.category[indexPath.row].title?.en ?? "")
        }
        return cell

        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductsVc") as? ProductsVc else { return }
        details.catId = self.category[indexPath.row].id ?? 0
        if "lang".localized == "ar" {
            details.catTitle = self.category[indexPath.row].title?.ar ?? ""
        }else{
            details.catTitle = self.category[indexPath.row].title?.en ?? ""
        }
        
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
extension SectionsVC{

func getCat() {
        self.homeViewModel.getCategories().subscribe(onNext: { (data) in
             self.homeViewModel.dismissIndicator()
                self.category = data.data?.categories ?? []
            
        }, onError: { (error) in
            self.homeViewModel.dismissIndicator()
        }).disposed(by: disposeBag)
    }
}

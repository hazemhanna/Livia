//
//  SectionsVC.swift
//  Shanab
//
//  Created by Macbook on 3/25/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class SectionsVC: UIViewController {

    @IBOutlet weak var sectionCollectionView: UICollectionView!
    
 
    fileprivate let cellIdentifier = "SectionCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionCollectionView.delegate = self
        sectionCollectionView.dataSource = self
        sectionCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
         
    }
    

    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }

    @IBAction func backBtn(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
    }
    
}


extension SectionsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? SectionCell else { return UICollectionViewCell()}
     
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

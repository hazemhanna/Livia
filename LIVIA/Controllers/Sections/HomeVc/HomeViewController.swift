//
//  HomeViewController.swift
//  Livia
//
//  Created by MAC on 11/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//



import UIKit
import ImageSlideshow
import DropDown
import SwiftMessages
import Alamofire

class HomeViewController: UIViewController {

    @IBOutlet weak var RestaurantTableView: UITableView!
    @IBOutlet weak var TypeBN: UIButton!
    @IBOutlet weak var imageSlider: ImageSlideshow!
    @IBOutlet weak var oneImageView: UIImageView!
    @IBOutlet weak var homeSectionsCollectionView: UICollectionView!
    @IBOutlet weak var notificationBN: UIButton!

    fileprivate let CellIdentifierCollectionView = "HomeCell"
    fileprivate let CellIdentifierTableView = "ValiableResturantCell"


    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = false
        homeSectionsCollectionView.delegate = self
        homeSectionsCollectionView.dataSource = self
        homeSectionsCollectionView.register(UINib(nibName: CellIdentifierCollectionView, bundle: nil), forCellWithReuseIdentifier: CellIdentifierCollectionView)

        RestaurantTableView.delegate = self
        RestaurantTableView.dataSource = self
        RestaurantTableView.tableFooterView = UIView()
        RestaurantTableView.register(UINib(nibName: CellIdentifierTableView, bundle: nil), forCellReuseIdentifier: CellIdentifierTableView)

    
//        if (Helper.getApiToken() ?? "") != "" {
//          notificationBN.isHidden = false
//        }else{
//            notificationBN.isHidden = true
//        }
    }

    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }


    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }

    fileprivate func setupImageSlider() {
//        imageSlider.slideshowInterval = 2
//        imageSlider.circular = false
//        imageSlider.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
//        imageSlider.contentScaleMode = .scaleAspectFill
//        imageSlider.zoomEnabled = true
//        if self.imageURLS.count == 1 {
//            imageSlider.isHidden = true
//            oneImageView.isHidden = false
//            oneImageView.image = UIImage.init(url: URL(string:  (self.imageURLS[0].image ?? "")))
//            oneImageView.contentMode = .scaleAspectFill
//            oneImageView.layer.cornerRadius = 25
//            oneImageView.layer.masksToBounds = true
//        } else {
//            imageSlider.isHidden = false
//            oneImageView.isHidden = true
//            let image = self.getImageData()
//            print(image.count)
//           self.imageSlider.setImageInputs(image)
//        }
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
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifierCollectionView, for: indexPath) as? HomeCell else { return UICollectionViewCell()}
          
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "MealDetailsVC") as? MealDetailsVC else { return }

        self.navigationController?.pushViewController(details, animated: true)
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 4.1
        return CGSize(width: size, height: collectionView.frame.size.height)
        
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierTableView, for: indexPath) as? ValiableResturantCell else {return UITableViewCell()}
      return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "RestaurantDetailsVC") as? RestaurantDetailsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    
}


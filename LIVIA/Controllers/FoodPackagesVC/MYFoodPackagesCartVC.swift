//
//  MYFoodPackagesCartVC.swift
//  Livia
//
//  Created by MAC on 27/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import Foundation
import UIKit
import ImageSlideshow


class MYFoodPackagesCartVC  : UIViewController {
    
    @IBOutlet weak var MealDetailsTableView: UITableView!
    private let TableCellIdentifier = "MyFoodCartCell"
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var empyView : UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MealDetailsTableView.delegate = self
        MealDetailsTableView.dataSource = self

        MealDetailsTableView.register(UINib(nibName: TableCellIdentifier, bundle: nil), forCellReuseIdentifier: TableCellIdentifier)
        titleLbl.text = "FoodCart".localized

    }
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func cartItems(_ sender: Any) {
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

extension MYFoodPackagesCartVC   : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifier, for: indexPath) as? MyFoodCartCell else {return UITableViewCell()}
        
        cell.confirm = {
            let alert = UIAlertController(title: "تاكيد", message: "هل انت متاكد من عملية الشراء", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "نعم", style: UIAlertAction.Style.default, handler: { action in
                print("")
                }))
                alert.addAction(UIAlertAction(title: "لا", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            
       }
        
        
        cell.delete = {
            let alert = UIAlertController(title: "تاكيد", message: "هل انت متاكد من عملية الحذف", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "نعم", style: UIAlertAction.Style.default, handler: { action in
                    print("")

                }))
                alert.addAction(UIAlertAction(title: "لا", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
        
     return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

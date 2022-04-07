//
//  OrderList.swift
//  Shanab
//
//  Created by Macbook on 3/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class OrderListVC : UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var titleLbl  : UILabel!

    
    fileprivate let cellIdentifier = "ListCell"
    let orderViewModel  = OrderViewModel()
    var disposeBag = DisposeBag()
    
    var list = [Order](){
        didSet {
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text =  "Order List".localized
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        orderViewModel.showIndicator()
        getOrder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
extension OrderListVC: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ListCell else { return UITableViewCell()}
        
        cell.config(date: self.list[indexPath.row].orderDate ?? "",orderNumber: self.list[indexPath.row].id ?? 0)
        
        cell.goToDetails = {
            guard let Details = UIStoryboard(name: "Orders", bundle: nil).instantiateViewController(withIdentifier: "OrderDetailsVC") as? OrderDetailsVC else { return }
            Details.order = self.list[indexPath.row]
            self.navigationController?.pushViewController(Details, animated: true)
            
        }
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let Details = UIStoryboard(name: "Orders", bundle: nil).instantiateViewController(withIdentifier: "OrderDetailsVC") as? OrderDetailsVC else { return }
        Details.order = self.list[indexPath.row]
        self.navigationController?.pushViewController(Details, animated: true)
    }
}

extension OrderListVC {
    
    func getOrder() {
        self.orderViewModel.getOrders().subscribe(onNext: { (data) in
          self.orderViewModel.dismissIndicator()
           self.list = data.data?.orders ?? []
            //self.show()
          }, onError: { (error) in
          self.orderViewModel.dismissIndicator()
         }).disposed(by: disposeBag)
    }
    
}

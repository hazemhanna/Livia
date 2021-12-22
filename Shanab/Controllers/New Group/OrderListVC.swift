//
//  OrderList.swift
//  Shanab
//
//  Created by Macbook on 3/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import DropDown
import Cosmos
class OrderListVC : UIViewController {
    
    
    private let UserListVCPresenter = UserListPresenter(services: Services())
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var orderType: UIButton!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var LoginView: UIView!
    
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var reasonTF: UITextField!
    @IBOutlet weak var cancelOrderBtn : UIButton!
    @IBOutlet weak var cancelBtn : UIButton!
    @IBOutlet weak var canceltitle : UILabel!
    @IBOutlet weak var cancelreason : UILabel!

    
    var currentPage = 1
    var order_id = Int()
    
    let orderTypsDropDown = DropDown()
    fileprivate let cellIdentifier = "ListCell"
    
    var type = "new"
    
    let TypesApi = ["new", "preparing", "delivering", "delivered" , "competed","canceled"]
    
    let TypeArr = ["new order".localized, "preparing order".localized , "on_way".localized, "arrived".localized, "completed".localized ,"canceled".localized]
    
    var list = [orderList](){
        didSet {
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
    }
    
    var isFatching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.tableFooterView  = UIView()
        
        cancelreason.text = "What is the Cancel Reason?".localized
        canceltitle.text = "Are you sure ?".localized
        cancelBtn.setTitle("Cancel".localized, for: .normal)
        cancelOrderBtn.setTitle("Cancel Order".localized, for: .normal)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if  Helper.getApiToken() == "" || Helper.getApiToken() == nil {
            
            displayMessage(title: "", message: "You should login first".localized, status:.warning, forController: self)
            LoginView.isHidden = false
        } else {
            LoginView.isHidden = true
            listTableView.delegate = self
            listTableView.dataSource = self
            listTableView.prefetchDataSource = self
            listTableView.tableFooterView = UIView()
            listTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
            UserListVCPresenter.setUserListViewDelegate(UserListViewDelegate: self)
            UserListVCPresenter.showIndicator()
            
            DispatchQueue.global().async {
                self.list.removeAll()
                self.UserListVCPresenter.postUserGetList(status: [self.type], currentPage: self.currentPage)

                
            }
            SetuporderTypesDropDown()
        }
        
    }
    func SetuporderTypesDropDown() {
        orderTypsDropDown.anchorView = orderType
        orderTypsDropDown.bottomOffset = CGPoint(x: 0, y: orderTypsDropDown.anchorView?.plainView.bounds.height ?? 0 + 50)
        orderTypsDropDown.dataSource = TypeArr
        orderTypsDropDown.selectionAction = {[weak self] (index, item) in
            self?.orderType.setTitleColor(#colorLiteral(red: 0.8121929765, green: 0.2939046025, blue: 0.2674312294, alpha: 1), for: .normal)
            self?.orderType.setTitle(item, for: .normal)
            self?.type = self?.TypesApi[index] ?? ""
            self?.currentPage = 1
            self?.list.removeAll()
            self?.UserListVCPresenter.showIndicator()
            self?.UserListVCPresenter.postUserGetList(status: [self?.type ?? ""], currentPage: self?.currentPage ?? 1)
        }
        orderTypsDropDown.direction = .any
        orderTypsDropDown.width = self.view.frame.width / 2
    }
    
    @IBAction func orderType(_ sender: UIButton) {
        orderTypsDropDown.show()
    }
    
    
    @IBAction func canceBtn(_ sender: UIButton) {
        cancelView.isHidden = true
    }
    
    @IBAction func canceOrderBtn(_ sender: UIButton) {
        UserListVCPresenter.showIndicator()
        UserListVCPresenter.refundOrder(order_id:   self.order_id , rate: 0.0, refund_reson: reasonTF.text ?? "")
        cancelView.isHidden = true
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func cart(_ sender: Any) {
        guard let window = UIApplication.shared.keyWindow else { return }
        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
        details.selectedIndex = 2
        window.rootViewController = details
    }
    
    
}
extension OrderListVC: UITableViewDelegate, UITableViewDataSource , UITableViewDataSourcePrefetching {
    
     func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= list.count - 4  && !isFatching{
                self.UserListVCPresenter.postUserGetList(status: [self.type], currentPage: currentPage )
                isFatching = true
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ListCell else { return UITableViewCell()}
        cell.config(date: list[indexPath.row].createdAt ?? "", status: list[indexPath.row].status ?? "", orderNumber: list[indexPath.row].id ?? 0)
        cell.goToDetails = {
            guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "UserOrderDetailsVC") as? UserOrderDetailsVC else { return }
            Details.id = self.list[indexPath.row].id ?? 0
            Details.status = self.list[indexPath.row].status ?? ""
            self.navigationController?.pushViewController(Details, animated: true)
        }
        cell.FollowOrder = {
            guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "OrderFollowingVC") as? OrderFollowingVC else { return }
            
            Details.order = self.list[indexPath.row]
            Details.id = self.list[indexPath.row].id ?? 0
            Details.status = self.list[indexPath.row].status ?? ""
            Details.date = self.list[indexPath.row].createdAt ?? ""
            self.navigationController?.pushViewController(Details, animated: true)
        }
        
        cell.cancelOrder = {
            self.order_id = self.list[indexPath.row].id ?? 0
            self.cancelView.isHidden = false
        }
    
      if type == "new" {
            cell.followBtn.isHidden = true
            cell.cancelBtn.isHidden = false
        }else if type == "preparing"{
            cell.followBtn.isHidden = false
            cell.cancelBtn.isHidden = false
        }else{
            if type == "canceled" {
                cell.followBtn.isHidden = true
                cell.cancelBtn.isHidden = true
            }else{
                cell.followBtn.isHidden = false
                cell.cancelBtn.isHidden = true
            }
        }
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220
    }
    
}
extension OrderListVC: UserListViewDelegate {
    
    func getUserRewards(_ error: Error?, _ list: [Reward]?) {
        
    }
    
    func UserRefundResult(_ error: Error?, _ list: orderpagination?) {
       
    }
    
    func refundOrder(_ error: Error?, _ list: RefundModelJSON?){
        if let lists = list {
            displayMessage(title: "", message: "Done".localized , status: .success, forController: self)
            DispatchQueue.global().async {
                self.list.removeAll()
                self.UserListVCPresenter.postUserGetList(status: [self.type], currentPage: self.currentPage)
            }
        }
    }
    
    func UserListResult(_ error: Error?, _ list: orderpagination?) {
        DispatchQueue.main.async {
            if let lists = list {
                self.list.append(contentsOf: lists.order ?? [])
                if self.list.count == 0 {
                    self.emptyView.isHidden = false
                    self.listTableView.isHidden = true
                } else {
                    self.emptyView.isHidden = true
                    self.listTableView.isHidden = false
                }
                if lists.nextPageURL != nil {
                    self.isFatching = false
                    self.currentPage += 1
                }
                self.listTableView.reloadData()
            }
        }

    }
}

//
//  WalletVc.swift
//  Shanab
//
//  Created by MAC on 09/10/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//


import UIKit
import DropDown

class WalletVc: UIViewController {
    
    private let UserListVCPresenter = UserListPresenter(services: Services())
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var orderbtn : UIButton!
    @IBOutlet weak var rewardsBtn : UIButton!
    @IBOutlet weak var titleLbl  : UILabel!
    @IBOutlet weak var empyView : UIView!
    fileprivate let cellIdentifier = "RefundOrderCell"
    fileprivate let cellIdentifier2 = "RewardCell"

    var type = "order"
    var totalWallet = Int()
    
    var list = [orderList](){
        didSet {
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
    }
    
    var rewards  = [Reward]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderbtn.setTitle("refund".localized, for: .normal)
        rewardsBtn.setTitle("rewards".localized, for: .normal)
        titleLbl.text = "wallet".localized
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if  Helper.getApiToken() == "" || Helper.getApiToken() == nil {
            displayMessage(title: "", message: "You should login first".localized, status:.warning, forController: self)
        } else {
            listTableView.delegate = self
            listTableView.dataSource = self
            listTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
            listTableView.register(UINib(nibName: cellIdentifier2, bundle: nil), forCellReuseIdentifier: cellIdentifier2)

            UserListVCPresenter.setUserListViewDelegate(UserListViewDelegate: self)
            UserListVCPresenter.showIndicator()
            DispatchQueue.global().async {
                self.UserListVCPresenter.UserRefundResult(status: ["refunded"])
                self.UserListVCPresenter.getUserRewards()
            }
        }
    }
    
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func rewardBtn(_ sender: UIButton) {
        if sender.tag == 0 {
            self.orderbtn.backgroundColor = .red
            self.rewardsBtn.backgroundColor = .white
            self.type = "order"
            self.orderbtn.setTitleColor(UIColor.white, for: .normal)
            self.rewardsBtn.setTitleColor(UIColor.black, for: .normal)
            if list.count > 0 {
                empyView.isHidden = true
            }else{
                empyView.isHidden = false
            }
            
            self.listTableView.reloadData()

        }else{
            self.orderbtn.backgroundColor = .white
            self.rewardsBtn.backgroundColor = .red
            self.type = "reward"
            self.orderbtn.setTitleColor(UIColor.black, for: .normal)
            self.rewardsBtn.setTitleColor(UIColor.white, for: .normal)
            if rewards.count > 0 {
                empyView.isHidden = true
            }else{
                empyView.isHidden = false
            }
            
            self.listTableView.reloadData()

            
        }
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension WalletVc: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == "order"{
         return list.count
        }else{
         return rewards.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if type == "order"{

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RefundOrderCell else { return UITableViewCell()}
            
            if "lang".localized == "ar" {
                cell.config(desc: list[indexPath.row].refund_reson ?? ""
                            , name:  list[indexPath.row].status ?? ""
                            , date:  list[indexPath.row].createdAt ?? ""
                            , orderId: list[indexPath.row].orderDetail?[0].orderID ?? 0)
            }else{
                cell.config(desc: list[indexPath.row].refund_reson ?? ""
                            , name:  list[indexPath.row].status ?? ""
                            , date:  list[indexPath.row].createdAt ?? ""
                            , orderId: list[indexPath.row].orderDetail?[0].orderID ?? 0)
            }
            
            cell.goToDetails = {
            guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "UserOrderDetailsVC") as? UserOrderDetailsVC else { return }
            Details.id = self.list[indexPath.row].id ?? 0
            Details.status = self.list[indexPath.row].status ?? ""
            self.navigationController?.pushViewController(Details, animated: true)
        }
        
        return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2, for: indexPath) as? RewardCell else { return UITableViewCell()}
            if "lang".localized == "ar" {
            cell.config(date: self.rewards[indexPath.row].createdAt ?? "" , title: self.rewards[indexPath.row].titleAr ?? "", value: self.rewards[indexPath.row].value ?? 0,totalWallet : self.totalWallet)
            }else{
                cell.config(date: self.rewards[indexPath.row].createdAt ?? "" , title: self.rewards[indexPath.row].titleEn ?? "", value: self.rewards[indexPath.row].value ?? 0,totalWallet : self.totalWallet)
            }
            return cell
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             return 150
      
    }
    
}

extension WalletVc: UserListViewDelegate {
    
    
    func refundOrder(_ error: Error?, _ list: RefundModelJSON?){
        
    }
    
    func getUserRewards(_ error: Error?, _ list: [Reward]?) {
            if let lists = list {
                self.rewards = lists
                self.listTableView.reloadData()
            }
    }
    
    func UserRefundResult(_ error: Error?, _ list: orderpagination?) {
        DispatchQueue.main.async {
            if let lists = list {
             self.list = lists.order ?? []
                self.listTableView.reloadData()
            }
            
            if self.list.count > 0 {
                self.empyView.isHidden = true
            }else{
                self.empyView.isHidden = false
            }
            
        }
        
        
    }
    
    func UserListResult(_ error: Error?, _ list: orderpagination?) {
     
    }
}

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
        titleLbl.text = "profile".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
            listTableView.delegate = self
            listTableView.dataSource = self
            listTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
            listTableView.register(UINib(nibName: cellIdentifier2, bundle: nil), forCellReuseIdentifier: cellIdentifier2)
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
        }else{
            self.orderbtn.backgroundColor = .white
            self.rewardsBtn.backgroundColor = .red
            self.type = "reward"
            self.orderbtn.setTitleColor(UIColor.black, for: .normal)
            self.rewardsBtn.setTitleColor(UIColor.white, for: .normal)
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
         return 2
        }else{
         return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if type == "order"{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RefundOrderCell else { return UITableViewCell()}
        return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2, for: indexPath) as? RewardCell else { return UITableViewCell()}
            return cell
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             return 150
    }
    
}

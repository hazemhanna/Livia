//
//  File.swift
//  Livia
//
//  Created by MAC on 18/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NotificationsVC: UIViewController {
    
    @IBOutlet weak var notificationsTableView: UITableView!
    @IBOutlet weak var titleLbl  : UILabel!
    @IBOutlet weak var emptyView: UIView!

    fileprivate let cellIdentifier = "NotificationsCell"
    let user = Helper.getUserRole() ?? ""
     
    private let homeViewModel = HomeViewModel()
     var disposeBag = DisposeBag()
        
        var notification = [Notifications]() {
            didSet{
                DispatchQueue.main.async {
                    self.notificationsTableView.reloadData()
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationsTableView.delegate = self
        notificationsTableView.dataSource = self
        notificationsTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        titleLbl.text = "Notifications".localized
        
        self.homeViewModel.showIndicator()
        getNotification()
        
    }
    
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func backBtn(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
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
extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? NotificationsCell else {return UITableViewCell()}
        
        if "lang".localized == "ar" {
            cell.config(id: self.notification[indexPath.row].data?.body?.id ?? 0
                        ,status: self.notification[indexPath.row].data?.name?.ar ?? ""
                        ,title: self.notification[indexPath.row].data?.body?.ar ?? "")
        }else{
            cell.config(id: self.notification[indexPath.row].data?.body?.id ?? 0
                        ,status: self.notification[indexPath.row].data?.name?.en ?? ""
                        ,title: self.notification[indexPath.row].data?.body?.en ?? "")

        }
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "UserOrderDetailsVC") as? UserOrderDetailsVC else { return }
//        self.navigationController?.pushViewController(Details, animated: true)
//
    }
    
}
extension NotificationsVC{
    func getNotification() {
            self.homeViewModel.getNotification().subscribe(onNext: { (data) in
                 self.homeViewModel.dismissIndicator()
                 self.notification = data.data?.notifications ?? []
                if self.notification.count > 0 {
                    self.emptyView.isHidden = true
                }else{
                   self.emptyView.isHidden = false
                }
                
            }, onError: { (error) in
                self.homeViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
}

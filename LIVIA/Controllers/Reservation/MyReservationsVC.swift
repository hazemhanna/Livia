//
//  MyReservations.swift
//  Livia
//
//  Created by MAC on 22/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//



import UIKit
import DropDown
import Cosmos
class MyReservationsVC : UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var titleLBL : UILabel!

    @IBOutlet weak var emptyView: UIView!

    fileprivate let cellIdentifier = "ReservationCell"
    
    
//    var list = [orderList](){
//        didSet {
//            DispatchQueue.main.async {
//                self.listTableView.reloadData()
//            }
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLBL.text = "MyReservations".localized
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            listTableView.delegate = self
            listTableView.dataSource = self
            listTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension MyReservationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ReservationCell else { return UITableViewCell()}
        cell.goToDetails = {
            guard let Details = UIStoryboard(name: "Reservation", bundle: nil).instantiateViewController(withIdentifier: "MyReservationsDetailsVC") as? MyReservationsDetailsVC else { return }
            self.navigationController?.pushViewController(Details, animated: true)
            
        }
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let Details = UIStoryboard(name: "Reservation", bundle: nil).instantiateViewController(withIdentifier: "MyReservationsDetailsVC") as? MyReservationsDetailsVC else { return }
        self.navigationController?.pushViewController(Details, animated: true)
    }
    
}

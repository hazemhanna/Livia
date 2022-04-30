//
//  MyReservations.swift
//  Livia
//
//  Created by MAC on 22/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//



import UIKit
import RxSwift
import RxCocoa

class MyReservationsVC : UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var titleLBL : UILabel!
    @IBOutlet weak var emptyView: UIView!
    
    fileprivate let cellIdentifier = "ReservationCell"
    
    private let reservationVM  = ReservatiomViewModel()
    var disposeBag = DisposeBag()
    
    
    var reservations = [Reservations](){
        didSet {
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLBL.text = "MyReservations".localized
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        reservationVM.showIndicator()
        self.getReservatiom()
    }
    

    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }

    @IBAction func backBtn(_ sender: UIButton) {
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
extension MyReservationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  reservations.count
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
extension MyReservationsVC{
    
    func getReservatiom() {
            self.reservationVM.getReservatiom().subscribe(onNext: { (data) in
                 self.reservationVM.dismissIndicator()
                self.reservations = data.data?.tableReservations?.tableReservations ?? []
                
                if self.reservations.count > 0 {
                    self.emptyView.isHidden = true
                }else{
                   self.emptyView.isHidden = false
                }
                
            }, onError: { (error) in
                self.reservationVM.dismissIndicator()
            }).disposed(by: disposeBag)
        }
    
}

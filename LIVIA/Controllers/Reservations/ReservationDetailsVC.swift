//
//  ReservationDetailsVC.swift
//  Shanab
//
//  Created by Macbook on 6/3/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class ReservationDetailsVC: UIViewController {
    @IBOutlet weak var dateLB: CustomLabel!
    @IBOutlet weak var timeLB: CustomLabel!
    @IBOutlet weak var numberLB: UILabel!
    @IBOutlet weak var depositLB: UILabel!
    @IBOutlet weak var canclingFeesLB: UILabel!
    @IBOutlet weak var sessionLB: CustomLabel!
    var id = Int()
    var numberOfPeople = Int()
    var date = String()
    var time = String()
    var session = String()
    var ReservationDetails = DetailsDataClass()
    private let ReservationDetailsVCPresenter = ResevationDetailsPresenter(services: Services())
    override func viewDidLoad() {
        super.viewDidLoad()
        ReservationDetailsVCPresenter.setReservationDetailsViewDelegate(ReservationDetailsViewDelegate: self)
        ReservationDetailsVCPresenter.showIndicator()
        ReservationDetailsVCPresenter.dismissIndicator()
        
        
        ReservationDetailsVCPresenter.postReservationDetailsResult(id: id ?? 0)
//        timeLB.text = time
//        dateLB.text = date
//        numberLB.text = "\(numberOfPeople)"
//        sessionLB.text = session
        
    }
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func cart(_ sender: Any) {
//        guard let window = UIApplication.shared.keyWindow else { return }
//
//        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
//
//        details.selectedIndex = 2
//        window.rootViewController = details
        
        self.navigationController?.popViewController(animated: true)
    }
}
extension ReservationDetailsVC: ReservationDetailsViewDelegate {
    func ReservationDetailsResult(_ error: Error?, _ details: DetailsDataClass?) {
        if let lists = details {
            self.ReservationDetails = lists
            self.dateLB.text = ReservationDetails.date ?? ""
            self.numberLB.text = ReservationDetails.numberOfPersons
            self.timeLB.text = ReservationDetails.time
            
            self.depositLB.text = "The deposit paid ".localized + "\(ReservationDetails.restaurant?.reservationFee ?? 0)" + "S.R".localized
            self.canclingFeesLB.text = "In Case Resevation Cancling we will deducted ".localized + "\(String(describing: (ReservationDetails.restaurant?.reservationFee ?? 0) / 2))" + "S.R".localized
        }
    }
    
    
}

//
//  ReservationCancelltionVC.swift
//  Shanab
//
//  Created by Macbook on 7/12/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class ReservationCancelltionVC: UIViewController {
    
   private let CancelReservationVCPresenter = CancelReservationPresenter(services: Services())
    
    var list = [reservationList]()
    
    var id = Int()
    
    @IBOutlet weak var CancelFees: UILabel!
    
    @IBOutlet weak var ReservationPaid: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CancelReservationVCPresenter.setCancelReservationViewDelegate(CancelReservationViewDelegate: self)
        CancelReservationVCPresenter.postReservationDetailsResult(id: id)
    }
    @IBAction func dismiss(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
   }
    @IBAction func confirm(_ sender: Any) {
        CancelReservationVCPresenter.showIndicator()
        CancelReservationVCPresenter.postCancelReservation(id: id )
    }
    
}
extension  ReservationCancelltionVC: CancelReservationViewDelegate {
    func ReservationDetailsResult(_ error: Error?, _ details: DetailsDataClass?) {
        
        ReservationPaid.text = "The deposit paid ".localized + "\(details?.restaurant?.reservationFee ?? 0)" + "S.R".localized
        
            CancelFees.text =  "\((details?.restaurant?.reservationFee ?? 0) / 2)" + "S.R".localized
    }
    
    func CancelReservationResult(_ error: Error?, _ reservation: SuccessError_Model?) {
         if let resultMsg = reservation {
                   if resultMsg.successMessage != "" {
                    displayMessage(title: "Done".localized, message: "Reservation cancelled".localized, status: .success, forController: self)
                    
                    self.navigationController?.popViewController(animated: true)
                   } else if resultMsg.id != [""] {
                       displayMessage(title: "", message: resultMsg.id[0], status: .error, forController: self)
                   }
               }
    }
    
    
}

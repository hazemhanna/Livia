//
//  FiltterVC.swift
//  Livia
//
//  Created by MAC on 22/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation
import UIKit

class FiltterVC : UIViewController {
    
    @IBOutlet weak var lowestButton : UIButton!
    @IBOutlet weak var heightsButton : UIButton!
    @IBOutlet weak var AtoZButton : UIButton!
    @IBOutlet weak var offersButton : UIButton!
    @IBOutlet weak var mostButton : UIButton!
    
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var titleLbl2 : UILabel!
    
    @IBOutlet weak var lowestLBL : UILabel!
    @IBOutlet weak var heightsLBL : UILabel!
    @IBOutlet weak var AtoZLBL : UILabel!
    @IBOutlet weak var offersLBL : UILabel!
    @IBOutlet weak var mostLBL : UILabel!
    
    var lowest = false
    var  height = false
    var AtoZ = false
    var offers = false
    var most = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = "fillter".localized
        titleLbl2.text = "fillterBY".localized
        
        lowestLBL.text = "lowestPrice".localized
        heightsLBL.text = "heighstPrice".localized
        AtoZLBL.text = "AToZ".localized
        offersLBL.text = "offers".localized
        mostLBL.text = "mostOrders".localized
        
        
        if "lang".localized == "ar" {
            lowestLBL.textAlignment = .right
            heightsLBL.textAlignment = .right
            AtoZLBL.textAlignment = .right
            offersLBL.textAlignment = .right
            mostLBL.textAlignment = .right
        }else{
            lowestLBL.textAlignment = .left
            heightsLBL.textAlignment = .left
            AtoZLBL.textAlignment = .left
            offersLBL.textAlignment = .left
            mostLBL.textAlignment = .left
        }
    }
    
    @IBAction func lowestButton(_ sender: Any) {
         
        if lowest{
            lowest = false
            lowestButton.setImage(#imageLiteral(resourceName: "checkoff"), for: .normal)
        }else{
            lowest = true
            lowestButton.setImage(#imageLiteral(resourceName: "Checkon"), for: .normal)
        }
    }
    
    @IBAction func heightsButton(_ sender: Any) {
        if  height{
            height = false
            heightsButton.setImage(#imageLiteral(resourceName: "checkoff"), for: .normal)
        }else{
            height = true
            heightsButton.setImage(#imageLiteral(resourceName: "Checkon"), for: .normal)
        }
    }
    
    @IBAction func AtoZButton(_ sender: Any) {
        if AtoZ{
            AtoZ = false
            AtoZButton.setImage(#imageLiteral(resourceName: "checkoff"), for: .normal)
        }else{
            AtoZ = true
            AtoZButton.setImage(#imageLiteral(resourceName: "Checkon"), for: .normal)
        }
    }
    
    @IBAction func offersButton(_ sender: Any) {
        if offers{
            offers = false
            offersButton.setImage(#imageLiteral(resourceName: "checkoff"), for: .normal)
        }else{
            offers = true
            offersButton.setImage(#imageLiteral(resourceName: "Checkon"), for: .normal)
        }
    }
    
    @IBAction func mostButton(_ sender: Any) {
        if most{
            most = false
            mostButton.setImage(#imageLiteral(resourceName: "checkoff"), for: .normal)
        }else{
            most = true
            mostButton.setImage(#imageLiteral(resourceName: "Checkon"), for: .normal)
        }
    }
    
    
    @IBAction func confirmBtn(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }

    
}

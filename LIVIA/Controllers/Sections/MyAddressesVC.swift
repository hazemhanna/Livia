//
//  MyAdressesVC.swift
//  Shanab
//
//  Created by Macbook on 5/4/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
class MyAddressesVC: UIViewController {
    private let cellIdentifier = "AddressCell"
    @IBOutlet weak var AddressesTableView: UITableView!
    var total = Double()
    var vat = Double()
    var fee = Double()
    var quantity = Int()
    private let AddressesListVCPresenter = AddressesListpresenter(services: Services())
    var Addresses = [Address]() {
        didSet {
            DispatchQueue.main.async {
                self.AddressesTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        AddressesTableView.delegate = self
        AddressesTableView.dataSource = self
//        AddressesTableView.rowHeight = UITableView.automaticDimension
//        AddressesTableView.estimatedRowHeight = UITableView.automaticDimension
//        AddressesTableView.rowHeight = UITableView.automaticDimension
//        AddressesTableView.estimatedRowHeight = UITableView.automaticDimension
        AddressesTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        AddressesTableView.tableFooterView = UIView()
        AddressesListVCPresenter.setAddressesListViewDelegate(AddressesListViewDelegate: self)
        AddressesListVCPresenter.showIndicator()
        AddressesListVCPresenter.getAddresses()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print(total)
    }
    
    
    @IBAction func AddAddressBn(_ sender: UIButton) {
        guard let Details = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "LocationDetailsVC") as? LocationDetailsVC else { return }
        self.navigationController?.pushViewController(Details, animated: true)
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
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
}

extension MyAddressesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AddressCell else { return UITableViewCell()}
        cell.config(address: Addresses[indexPath.row].address ?? "")
        cell.delet = {
            self.AddressesListVCPresenter.showIndicator()
            self.AddressesListVCPresenter.postDeleteAddress(id: self.Addresses[indexPath.row].id ?? 0)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       guard let sb = UIStoryboard(name: "PaymentGetWay", bundle: nil).instantiateViewController(withIdentifier: "RequestTypePopUpVC") as? RequestTypePopUpVC else { return }
        sb.total = total
        sb.vat = vat
        sb.fee = fee
        sb.quantity_cart = quantity
        sb.address_id = Addresses[indexPath.row].id ?? 0
        
        sb.modalPresentationStyle = .overFullScreen
        
        present(sb, animated: true, completion: nil)
//       self.navigationController?.pushViewController(sb, animated: true)
                 
    }
}
extension MyAddressesVC: AddressesListViewDelegate {
    func postDeleteAddress(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                displayMessage(title: "", message: resultMsg.successMessage, status: .success, forController: self)
                self.dismiss(animated: true, completion: nil)
            } else if resultMsg.id != [""] {
                displayMessage(title: "", message: resultMsg.id[0], status: .error, forController: self)
            }
        }
    }
    
    func getAddresses(_ error: Error?, _ adressList: [Address]?) {
        if let adds = adressList {
            self.Addresses = adds
            
        }
    }
}

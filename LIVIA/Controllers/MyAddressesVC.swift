//
//  File.swift
//  Livia
//
//  Created by MAC on 01/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import UIKit
class MyAddressesVC: UIViewController {
    @IBOutlet weak var AddressesTableView: UITableView!
      
    private let cellIdentifier = "AddressCell"
    @IBOutlet weak var titleLbl  : UILabel!
    @IBOutlet weak var addBtn  : UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddressesTableView.delegate = self
        AddressesTableView.dataSource = self
        AddressesTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        //titleLbl.text = "address".localized
       // addBtn.setTitle("addaddress".localized, for: .normal)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func AddAddressBn(_ sender: UIButton) {
        guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "LocationDetailsVC") as? LocationDetailsVC else { return }
        self.navigationController?.pushViewController(Details, animated: true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
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

extension MyAddressesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AddressCell else { return UITableViewCell()}
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sb = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "RequestTypePopUpVC") as? RequestTypePopUpVC else { return }
        self.navigationController?.pushViewController(sb, animated: true)

    }
}


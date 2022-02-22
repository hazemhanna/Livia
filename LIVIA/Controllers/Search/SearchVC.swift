//
//  SearchVC.swift
//  Livia
//
//  Created by MAC on 22/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//



import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var empyView : UIView!

    private let cellForTable = "FavouriteCell"

    var NormalResult = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.tableFooterView = UIView()
        searchBar.returnKeyType = UIReturnKeyType.done
        searchTableView.register(UINib(nibName: cellForTable, bundle: nil), forCellReuseIdentifier: cellForTable)
        searchBar.delegate = self
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension SearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellForTable, for: indexPath) as? FavouriteCell else { return UITableViewCell()}
            
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.searchTableView.isHidden = true
         }else {
                self.searchTableView.isHidden = false
                self.searchTableView.reloadData()
                if NormalResult.count > 0 {
                    empyView.isHidden = true
                }else{
                    empyView.isHidden = false
                }
                
            }
        }
   }

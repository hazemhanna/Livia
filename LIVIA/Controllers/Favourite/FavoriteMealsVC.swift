//
//  FavoriteMealsVC.swift
//  Shanab
//
//  Created by Macbook on 7/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class FavoriteMealsVC: UIViewController {
   
    @IBOutlet weak var favoriteMealsTableView: UITableView!
    fileprivate let cellIdentifier = "FavouriteCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteMealsTableView.delegate = self
        favoriteMealsTableView.dataSource = self
        favoriteMealsTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func backBtn(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
    }
    
    
}
extension FavoriteMealsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavouriteCell else {return UITableViewCell()}
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
}

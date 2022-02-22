//
//  OrderDateVC.swift
//  Shanab
//
//  Created by Macbook on 4/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import FSCalendar
class OrderDateVC: UIViewController {
    
    @IBOutlet weak var orderCalender: FSCalendar!
    
    var selectedDate: ((String) -> Void)?
    var dateString = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        orderCalender.delegate = self
        orderCalender.dataSource = self
        orderCalender.register(FSCalendarCell.self, forCellReuseIdentifier: "Cell")
     
    }
    @IBAction func Confirm(_ sender: UIButton) {
        
        selectedDate?(dateString)
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension OrderDateVC: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {

         let cell = calendar.dequeueReusableCell(withIdentifier: "Cell", for: date, at: position)
                
        return cell
    }
   
    func minimumDate(for calendar: FSCalendar) -> Date {
        let manthAgo = Calendar.current.date(byAdding: .day, value: 0, to: Date()) ?? Date()
        return manthAgo
    }
    
    func  calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateString = dateFormatter.string(from: date)
    }
}

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
    @IBOutlet weak var timePicker : UIDatePicker!

    var time =  String()
    var date = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        orderCalender.delegate = self
        orderCalender.dataSource = self
        orderCalender.register(FSCalendarCell.self, forCellReuseIdentifier: "Cell")
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        
    }
    
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en-US") as Locale
        dateFormatter.dateFormat =  "hh:mm"
        self.time = (dateFormatter.string(from: picker.date))
        Helper.savetime(token: (dateFormatter.string(from: picker.date)))
    }

    @IBAction func Confirm(_ sender: UIButton) {
       if date == ""{
            displayMessage(title: "", message: "please select date".localized, status: .error, forController: self)
        } else if time == "" {
            displayMessage(title: "", message: "please select time".localized, status: .error, forController: self)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
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
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = NSLocale(localeIdentifier: "en-US") as Locale
        self.date = dateFormatter.string(from: date)
        Helper.savedate(token: dateFormatter.string(from: date))
    }
}

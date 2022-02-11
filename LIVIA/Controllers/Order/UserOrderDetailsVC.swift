//
//  UserOrderDetailsVC.swift
//  Shanab
//
//  Created by Macbook on 7/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Urway
import PassKit

class UserOrderDetailsVC: UIViewController ,PKPaymentAuthorizationViewControllerDelegate{
    
    private let UserOrderDetailsVCPresenter = UserOrderDetailsPresenter(services: Services())
    @IBOutlet weak var totalPriceLB: UILabel!
    @IBOutlet weak var fees: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var orderTyper : UILabel!
    @IBOutlet weak var paymentView : UIView!
    @IBOutlet weak var TaxLb: UILabel!
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var TableHeight: NSLayoutConstraint!
    @IBOutlet weak var confirmBtn : UIButton!
    @IBOutlet weak var TaxLb2: UILabel!
    @IBOutlet weak var webLink: UILabel!
    @IBOutlet weak var titlewebLink : UILabel!

    
    fileprivate let cellIdentifier = "OrderReceiptCell"
    
    
    var paymentController: UIViewController? = nil
    var paymentRequest:PKPaymentRequest = {
    let request = PKPaymentRequest()
    request.merchantIdentifier = "merchant.com.Dtag.Shanab"
        request.supportedNetworks = [.quicPay, .masterCard, .visa, .amex, .discover, .mada]
                  request.merchantCapabilities = .capability3DS
                  request.countryCode = "SA"
                  request.currencyCode = "SAR"
        
        return request
    }()
    
    var pay : PayType?
    var paymentString: NSString = ""
    var isApplePay = false
    var status = String()
    var order_id = Int()
    var id = Int()
    var vat = ""
    var fromNotification = false
    var total  = Double()
    var details = [OrderDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.detailsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.estimatedRowHeight = 120
        confirmBtn.setTitle("pay".localized, for: .normal)
        TaxLb2.text = "taxs".localized
        UserOrderDetailsVCPresenter.getWebView(order_id : id)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.openWebView(_:)))
        webLink.isUserInteractionEnabled = true
        webLink.addGestureRecognizer(gestureRecognizer)
        titlewebLink.text = "bill".localized
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UserOrderDetailsVCPresenter.setUserOrderDetailsViewDelegate(UserOrderDetailsViewDelegate: self)
        UserOrderDetailsVCPresenter.showIndicator()
        UserOrderDetailsVCPresenter.getCartItems()
        if fromNotification{
            confirmBtn.isHidden = false
        }else{
            confirmBtn.isHidden = true
        }
    }
    
    @objc func openWebView(_ sender: UITapGestureRecognizer) {
        if let url = URL(string: webLink.text ?? "") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    
   override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.detailsTableView.layer.removeAllAnimations()
        TableHeight.constant = detailsTableView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
    
    @IBAction func Dismiss(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func conffirm(_ sender: Any) {
        initializeSDK()
    }
    
    func initializeSDK() {
        UWInitialization(self) { (controller , result) in
            self.paymentController = controller
            guard let nonNilController = self.paymentController else {
                self.presentAlert(resut: result)
                return
            }
            self.present(nonNilController, animated: true, completion: nil)
        }
    }
}
extension UserOrderDetailsVC: UserOrderDetailsViewDelegate {
    
    func getWebView(_ error: Error?, _ result: WebViewModel?) {
        self.webLink.text = result?.link ?? ""
    }
    
    func paidOrder(_ error: Error?, _ result: OrderPaymentModelJSON?) {
        if result?.status ?? false {
       // navigateTOReceptPage(model: nil)
     }
    }
    
    func getCartResult(_ error: Error?, _ result: String?) {
        if let error = error {
            displayMessage(title: "", message: error.localizedDescription, status: .error, forController: self)
        } else {
            self.vat = result ?? "0"
            self.TaxLb.text = ("The total price includes ".localized + "VAT tax".localized)
            self.UserOrderDetailsVCPresenter.postUserOrderDetails(id: id, status: status)
        }
    }
    
    func UserOrderDetailsResult(_ error: Error?, _ result: [DriverOrder]?) {
        if let detail = result , detail.count > 0 {
            self.details = detail[0].orderDetail ?? [OrderDetail]()
            var orderCost = Double()
            var count = 0
            for item in details {
                if item.meal?.hasOffer == 1 {
                    var discount = (Double(item.meal?.discount ?? 0))
                    if item.meal?.discountType == "percentage" {
                        discount /= 100
                        discount = ((item.meal?.price?[0].price ?? 0.0) - ((item.meal?.price?[0].price ?? 0.0 ) * Double(discount))).rounded(toPlaces: 2)
                        orderCost = Double(orderCost + (Double(item.quantity ?? 0) * discount)).rounded(toPlaces: 2)
                    } else {
                        discount = ((item.meal?.price?[0].price ?? 0.0) -  Double(discount)).rounded(toPlaces: 2)
                        orderCost = Double(orderCost + (Double(item.quantity ?? 0) * discount)).rounded(toPlaces: 2)
                    }
                    self.details[count].meal?.price?[0].price = discount
                } else {
                    orderCost = Double(orderCost + (Double(item.quantity ?? 0) * (item.meal?.price?[0].price ?? 0.0))).rounded(toPlaces: 2)
                }
            for options in (item.option ?? []) {
                orderCost = Double(orderCost + ((options.price ?? 0.0))).rounded(toPlaces: 2)
                }
                count += 1
            }
            
           // let vatD = Double((Double(vat)?.rounded(toPlaces: 2) ?? 0.0)/100).rounded(toPlaces:2)
          //  let orderCostWithVat = orderCost + (orderCost * vatD)
            orderPrice.text = "\(orderCost.rounded(toPlaces:2))"
            totalPriceLB.text = "\(result?[0].total?.rounded(toPlaces: 2) ?? 0.0)"
            total = (result?[0].total?.rounded(toPlaces: 2) ?? 0.0)
            let feesCalcoulation = Double(( total - orderCost)).rounded(toPlaces: 1)
            self.orderTyper.text = ("orderType".localized) + " " + (result?[0].type?.localized ?? "")
            
            if result?[0].type != "sfry" {
                fees.text = "\(feesCalcoulation)"
            } else {
                fees.text = "0.0"
            }
          self.detailsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        }
    }
}
extension UserOrderDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? OrderReceiptCell else {return UITableViewCell()}
        let meal = details[indexPath.row].meal ?? Meal()
        let name = "lang".localized == "ar" ? meal.nameAr : meal.nameEn
        let restaurant = "lang".localized == "ar" ? meal.restaurant?.nameAr : meal.restaurant?.nameEn
        cell.config(name: name ?? "" , number: details[indexPath.row].quantity ?? 0 , price: "\(details[indexPath.row].meal?.price?[0].price?.rounded(toPlaces: 2) ?? 0.0)" , options: self.details[indexPath.row].option ?? [Option](), restaurant: restaurant ?? "" )
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    detailsTableView.scrollToRow(at: IndexPath(item: details.count - 1 , section: 0), at: .middle, animated: true)
    }
}

extension UserOrderDetailsVC {
    func presentAlert(resut: paymentResult) {
        var displayTitle: String = ""
        var key: mandatoryEnum = .amount
        
        switch resut {
        case .mandatory(let fields):
            key = fields
        default:
            break
        }
        
        switch  key {
        case .amount:
            displayTitle = "Amount"
        case.country:
            displayTitle = "Country"
        case.action_code:
            displayTitle = "Action Code"
        case.currency:
            displayTitle = "Currency"
        case.email:
            displayTitle = "Email"
        case.trackId:
            displayTitle = "TrackID"
        case .tokenID:
            displayTitle = "TockenID"
            
        case .cardOperation:
            displayTitle = "cardOperation"
        }
        
        let alert = UIAlertController(title: "Alert", message: "Check \(displayTitle) Field", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
          controller.dismiss(animated: true, completion: nil)
        UWInitialization(self) { (controller , result) in
            self.paymentController = controller
            guard let nonNilController = self.paymentController else {
                self.presentAlert(resut: result)
                return
            }
            self.present(nonNilController, animated: true, completion: nil)
        }
      }
      
      func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
          self.paymentString = UWInitializer.generatePaymentKey(payment: payment)
        print(self.paymentString)
          completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
      }
}


//
//  CartViewModel.swift
//  Livia
//
//  Created by MAC on 28/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation
import RxSwift
import SVProgressHUD

struct CartViewModel {
    
    func showIndicator() {
        SVProgressHUD.show()
    }
    
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func getCart() -> Observable<CartModelJson> {
        let observer = GetServices.shared.getCart()
        return observer
    }
    
    func removeCart(id : Int) -> Observable<BaseModel> {
        let observer = AddServices.shared.deleteCart(id: id)
        return observer
    }
    
    func updateCart(product_id : Int,quantity : Int) -> Observable<BaseModel> {
        let params: [String: Any] = [
            "cart_id": product_id,
            "quantity": quantity]
       let observer = AddServices.shared.updateCart(params: params)
       return observer
    }
    
    func addToCart(product_id : Int,variant_id : Int,message : String,quantity : Int,options : [[String : Int]]) -> Observable<BaseModel> {

        let params: [String: Any] = [
            "product_id": product_id,
            "product_variant_id": variant_id,
            "message": message,
            "quantity": quantity,
        //    "collection_option_id": options
        ]
        
        let observer = AddServices.shared.addToCart(params: params)
        return observer
    }
    
    func addWishList(id : Int,isWishList : Bool) -> Observable<BaseModel> {
        let params: [String: Any] = [
            "product_id": id]
        let observer = AddServices.shared.addWishList(params: params,isWishList : isWishList)
        return observer
    }
    
    func createOrder(phoneNumber : String,address : String,notes : String,delivery_tax : Int) -> Observable<BaseModel> {
        let params: [String: Any] = [
            "mobile": phoneNumber,
            "address": address,
            "delivery_tax": delivery_tax,
            "notes" : notes,
            "order_place" : "order_place"]
       let observer = AddServices.shared.createOrder(params: params)
       return observer
    }

}

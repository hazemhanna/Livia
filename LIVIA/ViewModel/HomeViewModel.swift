//
//  HomeViewModel.swift
//  Livia
//
//  Created by MAC on 26/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import Foundation
import RxSwift
import SVProgressHUD

struct HomeViewModel {
    
    func showIndicator() {
        SVProgressHUD.show()
    }
    
    func dismissIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func getSlider() -> Observable<SliderModelJson> {
    let observer = GetServices.shared.getSlider()
     return observer
    }
    
    func getCategories() -> Observable<CategoriesModelJson> {
    let observer = GetServices.shared.getCategeory()
     return observer
    }
  
    func getProduct() -> Observable<ProductModelJson> {
    let observer = GetServices.shared.getProducts()
     return observer
    }
    
    func getWishList() -> Observable<ProductModelJson> {
    let observer = GetServices.shared.getWishList()
     return observer
    }
    
    func addWishList(id : Int,isWishList : Bool) -> Observable<BaseModel> {
        let params: [String: Any] = [
            "product_id": id]
        let observer = AddServices.shared.addWishList(params: params,isWishList : isWishList)
        return observer
    }
    
}

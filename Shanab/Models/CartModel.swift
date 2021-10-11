//
//  CartModel.swift
//  Shanab
//
//  Created by Macbook on 6/29/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

//import Foundation
//import CoreData
//struct CartModel : Codable {
//    var items: [CartModelItem]?
//    var totalPrice: Double?
//    var cartNotes: String?
//    var Currency: String?
//    
//}
//struct CartModelItem: Codable {
//    var itemId: Int?
//    var itemNameEn: String?
//    var itemNameAr: String?
//    var itemPrice: Double?
//    var itemSize: String?
//    var itemQuantity: Int?
//    var itemImageURL: String?
//    var itemCurrency: String?
//    var options: [Option]?
//}
//struct CartCoreData {
//   static func SaveCart(cart_data: CartModel) {
//        do {
//            let cartData = try JSONEncoder().encode(cart_data)
//            let request: NSFetchRequest<Cart> = Cart.fetchRequest()
//            request.returnsObjectsAsFaults = false
//            do {
//                let fetchCart = try CoreDataService.context.fetch(request)
//                if fetchCart.count > 0 {
//                    fetchCart[0].cart = cartData
//                } else {
//                    let coreDataCart = Cart(context: CoreDataService.context)
//                    coreDataCart.cart = cartData
//                }
//                
//            } catch {
//                print("Fetching Cart Error  \(error.localizedDescription)")
//            }
//        } catch {
//            print("Saving Cart Error \(error.localizedDescription)")
//        }
//        
//        CoreDataService.saveContext()
//    } //End Of Save Cart
//    static func getCartData() -> Data? {
//        let request: NSFetchRequest<Cart> = Cart.fetchRequest()
//        request.returnsObjectsAsFaults = false
//        var cartData: Data? = nil
//        do {
//            let fetchCart = try CoreDataService.context.fetch(request)
//            cartData = fetchCart.first?.cart
//        } catch {
//            print(" Error Getting Cart \(error.localizedDescription)")
//        }
//        return cartData
//    } // End Of Get Cart
//    static func getCurrentCart() -> CartModel? {
//        guard let cartData = getCartData() else {return CartModel()}
//        do {
//            let cart = try JSONDecoder().decode(CartModel.self, from: cartData)
//            return cart
//        } catch {
//            print(" Error Getting Current Cart \(error.localizedDescription)")
//        }
//         return nil
//    } // End Of Getting Current Cart
//    static func ClearCart() {
//        let cart = CartModel()
//        SaveCart(cart_data: cart)
//    }
//}
////var Cart = CartCoreData.getCurrentCart() ?? CartModel()
////var items = Cart.items ?? []
////for i in 0..<items.count {
////    if items[i].itemId == self.ClientFavoriteList[indexPath.row].itemID {
////        items[i].itemQuantity! += 1
////    } else {
////        let restaurantD = self.ClientFavoriteList[indexPath.row].restaurant ?? restaurant()
////        items.append(CartModelItem(itemId: self.ClientFavoriteList[indexPath.row].itemID, itemName: restaurantD.nameEn ?? "", itemPrice: <#T##Double?#>, itemSize: <#T##String?#>, itemQuantity: <#T##Int?#>, itemImageURL: <#T##String?#>, itemCurrency: <#T##String?#>))
////    }
////}
////
////
////let cartModel = CartModel(items: Cart, totalPrice: self.totalPrice, cartNotes: self.discreption.text, Currency: self.currency)
////CartCoreData.SaveCart(cart_data: cartModel)

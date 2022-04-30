//
//  ConfigURLs.swift
//  Shanab
//
//  Created by Macbook on 3/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation

var BASE_URL = "https://livia.dtagdev.com/api/"

struct ConfigURLs {
    // Auth
    static var postLogin = BASE_URL + "login"
    static var postRegister = BASE_URL  + "register"
    static var getProfile = BASE_URL  + "me"
    static var activeAccount = BASE_URL  + "active"
    static var resendCode = BASE_URL  + "resend-code"
    static var logout = BASE_URL  + "logout"
    static var updateProfile = BASE_URL  + "update-profile"
    static var updatePassword = BASE_URL  + "update-password"
    static var updateAvatar = BASE_URL  + "update-avatar"

    //general
    static var getSliders = BASE_URL  + "sliders"
    static var getCategories = BASE_URL  + "categories"
    static var settings = BASE_URL  + "settings"
    static var  contactUs = BASE_URL  + "contact-us"
    //wishlist
    static var getWishlist = BASE_URL  + "wishlist"
    static var addWishlist = BASE_URL  + "wishlist/create"
    static var removeWishlist = BASE_URL  + "wishlist/remove"
    //cart
    static var getCart = BASE_URL  + "cart"
    static var addToCart = BASE_URL  + "cart/add-to-cart"
    static var deleteCart = BASE_URL  + "cart/delete-cart/"
    static var updateCart = BASE_URL  + "cart/update-cart"
    //order
    static var getOrders = BASE_URL  + "orders"
    static var createOrder = BASE_URL  + "orders/create"
    static var canceledOrder = BASE_URL  + "orders/canceled"
    // product
    static var getProducts = BASE_URL  + "products"
    static var getOffers = BASE_URL  + "products?discounts=1"
    static var getCategeoryProducts = BASE_URL  + "products?category_id="
    //reservation
    static var getReservation = BASE_URL  + "user-tables"
    static var createReservation = BASE_URL  + "user-tables/create"
    static var cancelReservation = BASE_URL  + "user-tables/"
    
    static var getNotification = BASE_URL  + "notifications"


}

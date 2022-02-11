//
//  ConfigURLs.swift
//  Shanab
//
//  Created by Macbook on 3/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import Foundation

var BASE_URL = "https://shnp.app"
struct ConfigURLs {
    // Get Adds
    static var getAdds = BASE_URL + "/api/general/adds"
    // post All Restuarants
    static var getAllRestaurants = BASE_URL + "/api/general/restaurants"
    // post Restaurant Details
    static var postRestaurantDetails = BASE_URL + "/api/general/restaurantDetail"
    // get All Catgeories
    static var  getAllCatgeories = BASE_URL + "/api/general/categories"
    // post Restaurant Meals
    static var postRestaurantMeals = BASE_URL + "/api/general/restaurantMeals"
    // get Settings
    static var getSettings = BASE_URL + "/api/general/settings"
    // post Login
    static var postLogin = BASE_URL + "/api/user/login"
    // post User Register
    static var postUserRegister = BASE_URL + "/api/user/register"
    // post Change Password
    static var postUserChangePassword = BASE_URL + "/api/user/changePassword"
    // post Change Use Profile Password
    static var postUserPostChangeProfilePassword = BASE_URL + "/api/user/changePasswordProfile"
    // post Change User Profile Image
    static var postChangeUserProfileImage = BASE_URL + "/api/user/changeImage"
    // post Forget Pasword
    static var postForgetPassword = BASE_URL + "/api/user/forgetPassword"
    // post Set Token
    static var postUserSetToken = BASE_URL + "/api/user/setToken"
    // post Get Notifications
    static var getNotifications = BASE_URL + "/api/user/getNotifications"
    // post Driver Get Code
    static var postDriverGetCode = BASE_URL + "/api/driver/forgetPassword"
    // post Driver Change Password
    static var postDriverChangePassword = BASE_URL + "/api/driver/changePassword"
    // post Driver ChangePassword Profile
    static var postDriverChangePasswordProfile = BASE_URL + "/api/driver/changePasswordProfile"
    // post Driver Registrtion
    static var postDriverRegistrtion = BASE_URL + "/api/driver/register"
    // post Driver Login
    static var postDriverLogin = BASE_URL + "/api/driver/login"
    // post Driver Change Image
    static var postDriverChangeImage = BASE_URL + "/api/driver/changeImage"
    // get Driver Is Available Change
    static var gettDriverIsAvailableChange =  BASE_URL + "/api/driver/available"
    // post Driver Set Token
    static var postDriverSetToken = BASE_URL + "/api/driver/setToken"
    // post Driver Get Notifications
    static var postDrivergetNotification = BASE_URL + "/api/driver/getNotifications"
    // post Driver Get Orders
    static var getDriverOrderList = BASE_URL + "/api/driver/getOrders"
    // get Driver Order Details
    static var getDriverOrderDetails = BASE_URL + "/api/driver/orderDetail"
    // get Driver Reject Order
    static var getDriverRejectOrder = BASE_URL + "/api/driver/rejectOrder"
    // Post User Create Order
    static var postUserCreateOrder = BASE_URL + "/api/user/order/create"
    // post Favorite Get
    static var postFavoriteGet = BASE_URL + "/api/user/favorite/get"
    // get mail Template
    static var getmailTemplate = BASE_URL + "/api/user/mail/template"
    // post Create Reservation
    static var postCreateReservation = BASE_URL + "/api/user/reservation/create"
    // post get Reservations
    static var postgetReservations = BASE_URL + "/api/user/reservation/get"
    // post User Get Order
    static var postUserGetOrder = BASE_URL + "/api/user/order/getOrder"
    // post User Order Detail
    static var postUserOrderDetail = BASE_URL + "/api/user/order/orderDetail"
    // post Reservation Details
    static var postReservationDetails = BASE_URL + "/api/user/reservation/detail"
    // post Cancel Reservation
    static var postCancelReservation = BASE_URL + "/api/user/reservation/cancel"
    // post Remove Favorite
    static var postRemoveFavorite = BASE_URL + "/api/user/favorite/remove"
    // post Create Favorite
    static var postCreateFavorite = BASE_URL + "/api/user/favorite/create"
    // post Driver Change Order Status
    static var postDriverChangeOrderStatus = BASE_URL + "/api/driver/changeOrderStatus"
    // get User Profile
    static var getProfile = BASE_URL + "/api/user/getProfile"
    // get Driver Profile
    static var getDriverProfile = BASE_URL + "/api/user/getProfile"
    // post Meal Search
    static var postMealSearch = BASE_URL + "/api/general/searchInMeals"
    // post Restaurant Search
    static var postRestaurantSearch = BASE_URL + "/api/general/searchInRestaurants"
    // post Edit User Profile
    static var postEditProfile = BASE_URL + "/api/user/editProfile"
    // post Edit Driver Profile
    static var postEditDriverProfile = BASE_URL + "/api/driver/editProfile"
    // post Meal Details
    static var postMealDetails = BASE_URL + "/api/general/MealDetail"
    // get Addresses
    static var getAddresses = BASE_URL + "/api/user/getAddress"
    // post Add Address
    static var postAddAddress = BASE_URL + "/api/user/addAddress"
    // post get Countries
    static var postGetCountries = BASE_URL + "/api/user/getCountries"
     static var postGetCities = BASE_URL + "/api/user/getCountries"
    // post Delete Address
    static var postDeleteAddress = BASE_URL + "/api/user/deleteAddress"
    // get Cart Items
    static var getCartItems = BASE_URL + "/api/user/cart/cartItems"
    // post Add To Cart
    static var postAddToCart = BASE_URL + "/api/user/cart/addToCart"
    // post Delete Cart
    static var postDeleteCart = BASE_URL + "/api/user/cart/deleteCart"
    // get Setting
    static var getSetting = BASE_URL + "/api/general/settings"
    // get Delete Image
    static var getDeleteImage = BASE_URL + "/api/driver/deleteImage"
    // post Update Quantity
    static var postUpdateQuantity = BASE_URL + "/api/user/cart/updateCart"
    // post Driver Rejacted Order
    static var postDriverRejactedOrder = BASE_URL + "/api/driver/rejectOrder"
    // get Meals Of Main Category
    static var getMealsOfMainCategory = BASE_URL + "/api/general/categoryMeals"
    // post Rate Order
    static var postRateOrder = BASE_URL + "/api/user/order/rate"
    // post Rate Driver
    static var postRateDriver = BASE_URL + "/api/user/order/rateDriver"
    // post Comment
    static var postComment = BASE_URL + "/api/user/order/comment"
    static var Createmail = BASE_URL + "/api/user/mail/create"
    static var VerifyUserEmail = BASE_URL + "/api/user/verifyEmail"
    static var VerifyDriverEmail = BASE_URL + "/api/driver/verifyEmail"
    static var VerifyUserCode = BASE_URL + "/api/user/verifyCode"
    static var VerifyDriverCode = BASE_URL + "/api/driver/verifyCode"
    static let VerifiedEmail = "VerifiedEmail"
    static let VerifiedPhone = "VerifiedPhone"
    static let checkOrderPayment = "/api/user/order/checkOrderPayment"
    static let payed = "/api/order/payed"
    
}

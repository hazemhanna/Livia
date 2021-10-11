//
//  BestSellerVC.swift
//  Shanab
//
//  Created by Macbook on 3/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import ImageSlideshow
class RestaurantDetailsVC: UIViewController {
    private let RestaurantDetailVCPresenter = RestaurantDetailPresenter(services: Services())
    @IBOutlet weak var rateLB: UILabel!
    @IBOutlet weak var FavoriteBN: UIButton!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var lowestPrice: UILabel!
    @IBOutlet weak var oneImageView: UIImageView!
    @IBOutlet weak var deliveryTime: UILabel!
    @IBOutlet weak var deliveryFees: UILabel!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var TableReservation: UIButton!
    
    @IBOutlet weak var foodPackages : UIButton!
    @IBOutlet weak var subscribtions : UIButton!

    
    @IBOutlet weak var DetailsView: CustomView!
    
    fileprivate let cellIdentifier = "BestSellerCell"
    fileprivate let CellIdentifier = "RestaurantDetailsCell"
    @IBOutlet weak var bestSellerTableView: UITableView!
    var mealId = Int()
    var image = String()
    var isFavourite = Bool()
    var name = String()
    var restaurant_type = String()
    var rate = Int()
    var delivery_time = Int()
    var lowest_price = Int()
    var delivery_fees = Double()
    var sections = [sectionMeal]()
    //    var restaurant_id = Int()
    var categoriesArr = [Category]()
    var cartItems = [onlineCart]()
    
    var meals = [RestaurantMeal]() {
        didSet{
            DispatchQueue.main.async {
                self.bestSellerTableView.reloadData()
            }
        }
    }
    
    var resturantDetails : RestaurantDetail?
    
    
    var restaurant_id = Int()
    var category_id = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        if (!image.contains("http")) {
            guard let imageURL = URL(string: (BASE_URL + "/" + image).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
            print(imageURL)
            self.oneImageView.kf.setImage(with: imageURL)
        }  else if image != "" {
            guard let imageURL = URL(string: image) else { return }
            self.oneImageView.kf.setImage(with: imageURL)
        } else {
            self.oneImageView.image = #imageLiteral(resourceName: "shanab loading")
        }
     

        subscribtions.setTitle("subscriptions".localized, for: .normal)
        foodPackages.setTitle("foodPackages".localized, for: .normal)

        categoriesArr.append(Category(id: 0, restaurantID: restaurant_id, nameAr: "الاكثر مبيعا", nameEn: "Best Seller", image: "", createdAt: "", updatedAt: "" , NameSelected : true))
        
        categoriesArr.append(Category(id: 1, restaurantID: restaurant_id, nameAr: "العروض", nameEn: "Offers", image: "", createdAt: "", updatedAt: ""))
      
        
//        resturantDetails?.category?.forEach({ (cat) in
//            categoriesArr.append(Category(id: 1, restaurantID:cat.restaurantID, nameAr: cat.nameAr, nameEn: cat.nameEn, image: "", createdAt: "", updatedAt: ""))
//        })
        
        print(categoriesArr)
//        for i in range{
//
//
//            categoriesArr.append(Category(id: 1, restaurantID: resturantDetails?.category?[i].restaurantID, nameAr: resturantDetails?.category?[i].nameAr, nameEn: resturantDetails?.category?[i].nameEn, image: "", createdAt: "", updatedAt: ""))
//        }
        
     //   categoriesArr.append(Category(id: 2, restaurantID: restaurant_id, nameAr: "وجبات سريعة", nameEn: "Fast food", image: "", createdAt: "", updatedAt: ""))
        
        ProductName.text = name
        type.text = restaurant_type
        deliveryTime.text = "\(delivery_time)"
        rateLB.text = "\(rate)"
        deliveryFees.text = "\(delivery_fees)"
        
        
        
        bestSellerTableView.delegate = self
        bestSellerTableView.dataSource = self
        bestSellerTableView.rowHeight = UITableView.automaticDimension
        bestSellerTableView.estimatedRowHeight = UITableView.automaticDimension
        bestSellerTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        bestSellerTableView.tableFooterView = UIView()
        RestaurantDetailVCPresenter.setRestaurantDetailsViewDelegate(RestaurantDetailsViewDelegate: self)
        RestaurantDetailVCPresenter.postRestaurantDetails(restaurant_id: restaurant_id)
       // RestaurantDetailVCPresenter.postRestaurantMeals(restaurant_id: restaurant_id, type: "category", category_id: category_id)
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.register(UINib(nibName: CellIdentifier, bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
        
    }
    
    @IBAction func favoriteBN(_ sender: UIButton) {
            if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
                
                displayMessage(title: "Add favourite".localized, message: "You should login first".localized, status:.warning, forController: self)
            } else {
                
                if isFavourite {
                    FavoriteBN.setImage(#imageLiteral(resourceName: "heart-1"), for: .normal)
                    isFavourite = false
                }
                
                else {
                    FavoriteBN.setImage(#imageLiteral(resourceName: "heart 2"), for: .normal)
                    isFavourite = true
                    
                }
                
                RestaurantDetailVCPresenter.showIndicator()
                RestaurantDetailVCPresenter.postCreateFavorite(item_id: self.restaurant_id , item_type: "meal")
                RestaurantDetailVCPresenter.postRemoveFavorite(item_id: self.restaurant_id , item_type: "meal")
        }
        
    }
    @IBAction func cartItemsButton(_ sender: Any) {
//        guard let window = UIApplication.shared.keyWindow else { return }
//
//        guard let details = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController else { return }
//
//        details.selectedIndex = 2
//        window.rootViewController = details
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    
    @IBAction func ReservationBn(_ sender: UIButton) {
        guard let details = UIStoryboard(name: "Reservation", bundle: nil).instantiateViewController(withIdentifier: "ReservationRequestVC") as?
                ReservationRequestVC else { return }
        details.resturant_id = self.restaurant_id
        details.fees = self.resturantDetails?.reservation_fee ?? 0.0
        
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    @IBAction func foodPackgesBn(_ sender: UIButton) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "FoodPackages") as? FoodPackages else { return }
        details.restaurant_id = self.restaurant_id
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    @IBAction func subscriptionBn(_ sender: UIButton) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "SubscribtionVc") as? SubscribtionVc else { return }
        details.restaurant_id = self.restaurant_id
        self.navigationController?.pushViewController(details, animated: true)
 
    }
    
    
    func SelectionAction(indexPath: IndexPath) {
        for i in 0..<categoriesArr.count {
            if i == indexPath.row {
                self.categoriesArr[i].NameSelected = true
            } else {
                self.categoriesArr[i].NameSelected = false
            }
        }
    }
    
    
}
extension RestaurantDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BestSellerCell else {return UITableViewCell()}
        let y = Double(round(10 * (meals[indexPath.row].price?[0].price ?? 0.00))/10)
        print(y)
        
        if "lang".localized == "ar" {
            cell.config(imagePath: meals[indexPath.row].image ?? "" , name: meals[indexPath.row].nameAr ?? "", mealComponants: meals[indexPath.row].descriptionAr ?? "", price: y, discount: meals[indexPath.row].discount ?? 0.0)
        } else {
            cell.config(imagePath: meals[indexPath.row].image ?? "" , name: meals[indexPath.row].nameEn ?? "", mealComponants: meals[indexPath.row].descriptionEn ?? "", price:   y , discount: meals[indexPath.row].discount ?? 0.0)
            //            cell.discount
            
            //let discount =  ?? 0
            //                let result = price - (price * discount / 100)
            //                if ("lang".localized == "en") {
            //                    self.ProductPrice.attributedText = "\(details.price ?? 0 ) SAR".strikeThrough()
            //                    self.discountPrecentage.text = "%\(details.discount ?? 0) discount precentage"
            //                    self.discountedPrice.text = "\(result) SAR"
            //                } else {
            //                    self.ProductPrice.attributedText = "\(details.price ?? 0 ) ريال".strikeThrough()
            //                    self.discountPrecentage.text = "٪ \(details.discount ?? 0) :نسية الخصم"
            //                    self.discountedPrice.text = "\(result) ريال"
            //
            
            // }
        }
        
        cell.addToCart = {
            
            if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
                
                displayMessage(title: "Add to cart".localized, message: "You should login first".localized, status:.warning, forController: self)
            } else {
                
                cell.AddToCartBtn.setImage(#imageLiteral(resourceName: "cart (1)"), for: .normal)
                self.RestaurantDetailVCPresenter.showIndicator()
                self.RestaurantDetailVCPresenter.postAddToCart(meal_id: self.meals[indexPath.row].id ?? 0  , quantity: 1 , message:  "test one" , options: [])
                
            }
        }
        if Helper.getApiToken() != "" || Helper.getApiToken() != nil {

        
        if meals[indexPath.row].favorite?.count == 0 {
            
            cell.FavoriteBN.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
            cell.isFavourite = false
        } else {
            
            
            cell.FavoriteBN.setImage(#imageLiteral(resourceName: "heart 2-1"), for: .normal)
            cell.isFavourite = true


        }
        }
        
        cell.goToFavorites = {
            
            if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
                
                displayMessage(title: "Add favourite".localized, message: "You should login first".localized, status:.warning, forController: self)
            } else {
                
                self.RestaurantDetailVCPresenter.showIndicator()
                
                if cell.FavoriteBN.image(for: .normal) == #imageLiteral(resourceName: "heart") {
                self.RestaurantDetailVCPresenter.postCreateFavorite(item_id: self.meals[indexPath.row].id ?? 0, item_type: "meal")
                    cell.FavoriteBN.setImage(#imageLiteral(resourceName: "heart 2-1"), for: .normal)

                } else {
                self.RestaurantDetailVCPresenter.postRemoveFavorite(item_id: self.meals[indexPath.row].id ?? 0, item_type: "meal")
                    cell.FavoriteBN.setImage(#imageLiteral(resourceName: "heart"), for: .normal)

                
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Orders", bundle: nil).instantiateViewController(withIdentifier: "AdditionsVC") as? AdditionsVC else { return }
        details.restaurant_id = self.restaurant_id 
        details.meal_id =  self.meals[indexPath.row].id ?? 0
        details.imagePath = self.meals[indexPath.row].image ?? ""
        details.mealCalory = self.meals[indexPath.row].calories ?? ""
        if "lang".localized == "ar" {
            details.mealName = self.meals[indexPath.row].nameAr ?? ""
            details.mealComponents = self.meals[indexPath.row].descriptionAr ?? ""
            details.imagePath = self.meals[indexPath.row].image ?? ""
            
        } else {
            details.mealName = self.meals[indexPath.row].nameEn ?? ""
            details.mealComponents = self.meals[indexPath.row].descriptionEn ?? ""
            details.imagePath = self.meals[indexPath.row].image ?? ""
        }
        
        details.restaurantName = ProductName.text ?? ""
        
        self.navigationController?.pushViewController(details, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
extension RestaurantDetailsVC: RestaurantDetailsViewDelegate {
    func SectionDetails(_ error: Error?, _ result: [sectionMeal]?) {
        if let restaurantMeals = result {
            self.sections = restaurantMeals
            if self.sections.count == 0 {
                self.emptyView.isHidden = false
                self.bestSellerTableView.isHidden = true
            } else {
                self.emptyView.isHidden = true
                self.bestSellerTableView.isHidden = false
            }
            
        }
    }
    
    func CatgeoriesResult(_ error: Error?, _ catgeory: [Category]?) {
        if let catgeoryList = catgeory {
            self.categoriesArr = catgeoryList
        }
    }
    
    func AddToCartResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let meals = result {
            if meals.successMessage != "" {
                displayMessage(title: "Done".localized, message: "", status: .success, forController: self)
                Singletone.instance.cart = cartItems
            } else if meals.meal_id != [""] {
                displayMessage(title: "", message: meals.meal_id[0], status: .error, forController: self)
            } else if meals.quantity != [""] {
                displayMessage(title: "", message: meals.quantity[0], status: .error, forController: self)
            } else if meals.message != [""] {
                displayMessage(title: "", message: meals.message[0], status: .error, forController: self)
            } else if meals.options != [""] {
                displayMessage(title: "", message: meals.options[0], status: .error, forController: self)
            }
        }
    }
    
    func FavoriteResult(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {
                if "lang".localized == "en" {
                    displayMessage(title: "Saved At Favorite List", message: resultMsg.successMessage, status: .success, forController: self)
                }  else {
                        displayMessage(title: "تمت الاضافة الي المفضلة", message: "", status: .success, forController: self)
                    
                }
            }else if resultMsg.item_id != [""] {
                displayMessage(title: "", message: resultMsg.item_id[0], status: .error, forController: self)
            } else if resultMsg.item_type != [""] {
                displayMessage(title: "", message: resultMsg.item_type[0], status: .error, forController: self)
            }
        }
    }
    
    func RemoveFavorite(_ error: Error?, _ result: SuccessError_Model?) {
        if let resultMsg = result {
            if resultMsg.successMessage != "" {

                if "lang".localized == "en" {
                        displayMessage(title: "Remove from Favorite List", message: "", status: .success, forController: self)
                } else {
                        displayMessage(title: "تم الحذف من المفضلة", message: "", status: .success, forController: self)
                }
            } else if !resultMsg.item_id.isEmpty, resultMsg.item_id != [""] {
                displayMessage(title: "", message: resultMsg.item_id[0], status: .error, forController: self)
            } else if !resultMsg.item_type.isEmpty, resultMsg.item_type != [""] {
                displayMessage(title: "", message: resultMsg.item_type[0], status: .error, forController: self)
            }
        }
    }
    
    func RestaurantMealsResult(_ error: Error?, _ meals: [RestaurantMeal]?) {
        if let restaurantMeals = meals {
            
            print(restaurantMeals)
            self.meals = restaurantMeals
            if self.meals.count == 0 {
                self.emptyView.isHidden = false
                self.bestSellerTableView.isHidden = true
            } else {
                self.emptyView.isHidden = true
                self.bestSellerTableView.isHidden = false
            }
            
        }
        
    }
    
    
    func RestaurantDetailsResult(_ error: Error?, _ details: RestaurantDetail?) {
        if let restaurantDetails = details {
            
            self.resturantDetails = restaurantDetails
            
            let range = NSMakeRange(0, resturantDetails?.category?.count ?? 0)
            
            if let categories = resturantDetails?.category {
            
                
                for i in categories {
                    
                    categoriesArr.append(Category(id: 1, restaurantID: i.restaurantID, nameAr: i.nameAr, nameEn: i.nameEn, image: "", createdAt: "", updatedAt: ""))

                }
                print(categoriesArr.count)
                
                categoriesCollectionView.reloadData()
                
                
                categoriesCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                
                print(restaurantDetails.id)
                RestaurantDetailVCPresenter.postRestaurantMeals(restaurant_id: restaurantDetails.id ?? 1, type: "top", category_id: -1)

            }
            
            if restaurantDetails.reservation == "no" {
                self.TableReservation.isHidden = true
            } else {
                self.TableReservation.isHidden = false
            }
            
            if restaurantDetails.has_subscriptions == 0 {
                self.subscribtions.isHidden = true
            } else {
                self.subscribtions.isHidden = false
            }

            if restaurantDetails.has_food_subscriptions == 0 {
                self.foodPackages.isHidden = true
            } else {
                self.foodPackages.isHidden = false
            }

            
            
            
            
            if let image = restaurantDetails.image {
            let imageURL = URL(string: (BASE_URL + "/" + image).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
                
                
                self.oneImageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "shanab loading"))
            }
            
            self.deliveryFees.text = "\(restaurantDetails.deliveryFee ?? 0)"  + "S.R".localized
            self.rateLB.text = "\(restaurantDetails.rate ?? 0)"
            self.deliveryTime.text = "\(restaurantDetails.deliveryTime ?? 0)" + "Minutes".localized
            self.lowestPrice.text = "\(restaurantDetails.minimum ?? 0)" + "S.R".localized
            self.rateLB.text = "\(restaurantDetails.rate ?? 0) "
            self.type.text = restaurantDetails.type ?? ""
            
            
            if type.text == "restaurant" {
                
                if "lang".localized == "ar" {
                    
                    self.type.text = "مطعم"

                } else {
                    
                    self.type.text = restaurantDetails.type ?? ""

                }
            } else if type.text == "truck" {
                
                if "lang".localized == "ar" {
                    
                    self.type.text = "فودتراك"

                } else {
                    self.type.text = restaurantDetails.type ?? ""
                }
            }
            else if type.text == "family" {
                if "lang".localized == "ar" {
                    self.type.text = "أسر منتجة"
                } else {
                    self.type.text = restaurantDetails.type ?? ""
                }
            }
            
            if "lang".localized == "ar" {
                self.ProductName.text = restaurantDetails.nameAr ?? ""
               
            } else {
                self.ProductName.text = restaurantDetails.nameEn ?? ""
            }
            
        }
    }
}
extension RestaurantDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as? RestaurantDetailsCell else {return UICollectionViewCell()}
        
        if "lang".localized == "en" {
            
            cell.config(name: categoriesArr[indexPath.row].nameEn ?? "", selected: categoriesArr[indexPath.row].NameSelected ?? false)
            
        } else {
            
            cell.config(name: categoriesArr[indexPath.row].nameAr ?? "", selected: categoriesArr[indexPath.row].NameSelected ?? false)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        RestaurantDetailVCPresenter.showIndicator()
        
        SelectionAction(indexPath: indexPath)
        
        let restaurantId = resturantDetails?.id
        
        
        if indexPath.row == 0 {
            
            RestaurantDetailVCPresenter.postRestaurantMeals(restaurant_id: restaurantId ?? 1, type: "top", category_id: -1)
            
        } else if indexPath.row == 1 {
            
            
            RestaurantDetailVCPresenter.postRestaurantMeals(restaurant_id: restaurantId ?? 1, type: "offer", category_id: -1)
            //            RestaurantDetailVCPresenter.postRestaurantMeals(restaurant_id: resturantDetails?.id, type: "offer", category_id: resturantDetails?.category[0].id)
            
        } else {
            
            guard let categoryId = resturantDetails?.category?[indexPath.row - 2].id else { return }

            RestaurantDetailVCPresenter.postRestaurantMeals(restaurant_id: restaurantId ?? 1, type: "category", category_id: categoryId ?? 1)
            //            RestaurantDetailVCPresenter.getCatgeories()
            
        }
        DispatchQueue.main.async {
            self.categoriesCollectionView.reloadData()
        }
    }
}
extension RestaurantDetailsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 2.1
        return CGSize(width: size  , height: size - 20)
    }
    
}




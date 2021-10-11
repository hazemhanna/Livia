//
//  LocationVC.swift
//  Shanab
//
//  Created by Macbook on 5/4/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import MapKit



protocol HandleMapSearch: class {
    func dropPinZoomIn(placemark:MKPlacemark)
}


extension LocationVC: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        //get result, transform it to our needs and fill our dataSource
        print(completer.region)
        self.matchingItems2 = completer.results
        DispatchQueue.main.async {
            self.AutoCompleteTable.reloadData()
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        //handle the error
        print(error.localizedDescription)
    }
}

class LocationVC: UIViewController {
    
    
    var resultSearchController = UISearchController()
    @IBOutlet weak var SearcResult: UISearchBar!
    
    @IBOutlet weak var locationConfirmation: UIButton!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var MapView: MKMapView!
    let locationManager = CLLocationManager()
    var selectedPin: MKPlacemark?

    
    let regionInMeters: Double = 300
    var perviousLocation: CLLocation?
    let geoCoder = CLGeocoder()
    var lat = Double()
    var long = Double()
    var view_controller = String()
    
    @IBOutlet weak var TableHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var AutoCompleteTable: UITableView!{
        
        didSet{
            
            AutoCompleteTable.layer.masksToBounds = true
            AutoCompleteTable.separatorInset = UIEdgeInsets.zero
            AutoCompleteTable.layer.cornerRadius = 5.0
            AutoCompleteTable.separatorColor = UIColor.lightGray
            AutoCompleteTable.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        }
    }
    
    lazy var searchCompleter: MKLocalSearchCompleter = {
           let sC = MKLocalSearchCompleter()
           sC.delegate = self
           return sC
       }()
    
    var matchingItems: [MKMapItem] = []
    var matchingItems2: [MKLocalSearchCompletion] = []

    var mapView: MKMapView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        MapView.addGestureRecognizer(tap)

//        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "searchResultTable") as! searchResultTable
//
//        SearcResult = UISearchController(searchResultsController: locationSearchTable).searchBar
        

        
//        self.navigationItem.titleView = resultSearchController.searchBar
//        resultSearchController.hidesNavigationBarDuringPresentation = false
//        resultSearchController.dimsBackgroundDuringPresentation = true
//        definesPresentationContext = true
        
        checklocationAuthorization()
        setupLocationManager()
        startTackingUserLocation()
        
        AutoCompleteTable.delegate = self
        AutoCompleteTable.dataSource = self
        self.AutoCompleteTable.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        SearcResult.delegate = self
       
        SearcResult.sizeToFit()
        SearcResult.placeholder = "Search for places"


    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func handleLongPress (gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint: CGPoint = gestureRecognizer.location(in: MapView)
            let newCoordinate: CLLocationCoordinate2D = MapView.convert(touchPoint, toCoordinateFrom: MapView)
            addAnnotationOnLocation(pointedCoordinate: newCoordinate)
        }
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.AutoCompleteTable.layer.removeAllAnimations()
        TableHeight.constant = AutoCompleteTable.contentSize.height

        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
    
    func addAnnotationOnLocation(pointedCoordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = pointedCoordinate
        
        guard let previousLocation = self.perviousLocation else { return }
        let center = CLLocation(latitude: pointedCoordinate.latitude, longitude: pointedCoordinate.longitude)
        geoCoder.reverseGeocodeLocation(center) { [weak self] (Placemark, error) in
            guard  let self = self else {return}
            if error != nil {
                print("sorry for it")
                return
                
            }
            guard  let Placemark = Placemark?.first else {
                return
            }
            
            var streetNumber = " "

            
            if Placemark.country != nil {
                
                streetNumber = streetNumber + Placemark.country! + ", "
            }
            if Placemark.thoroughfare != nil {
                streetNumber = streetNumber + Placemark.thoroughfare! + ", "
            }
            if Placemark.locality != nil {
                streetNumber = streetNumber + Placemark.locality! + ", "
            }
            if Placemark.subLocality != nil {
                
                streetNumber = streetNumber + Placemark.subLocality!

            }
            DispatchQueue.main.async {
                self.LocationLabel.text = "\(streetNumber)"
                annotation.subtitle = (Placemark.subThoroughfare ?? "") + " " + (Placemark.thoroughfare ?? "")
                annotation.title = (Placemark.subThoroughfare ?? "") + " " + (Placemark.thoroughfare ?? "")
            }
            
        }
        MapView.removeAnnotations(self.MapView.annotations)
        MapView.addAnnotation(annotation)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        MapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            MapView.setRegion(region, animated: true)
        }
    }
    @IBAction func SideMenu(_ sender: Any) {
        
        setupSideMenu()
    }
    
    @IBAction func Back(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func LocationConfirmation(_ sender: Any) {
        UserDefaults.standard.set(self.LocationLabel.text ?? "", forKey: "Address")
        Constants.lat = self.lat
        Constants.long = self.long
        Constants.address = self.LocationLabel.text ?? ""
        self.navigationController?.popViewController(animated: true)
        
    }
    func checklocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            MapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            
            break
        case .denied:
            locationManager.requestWhenInUseAuthorization()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
            break
        case .authorizedAlways:
            MapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
            
        @unknown default:
            fatalError()
        }
    }
    func startTackingUserLocation() {
        MapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        perviousLocation = getCenterLocation(for: MapView)
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(perviousLocation!) { [weak self] (Placemark, error) in
            guard  let self = self else {return}
            if error != nil {
                print("sorry for it")
                return
                
            }
            guard  let Placemark = Placemark?.first else {
                return
            }
            var streetNumber = " "

            
            if Placemark.country != nil {
                
                streetNumber = streetNumber + Placemark.country! + ", "
            }
            if Placemark.thoroughfare != nil {
                streetNumber = streetNumber + Placemark.thoroughfare! + ", "
            }
            if Placemark.locality != nil {
                streetNumber = streetNumber + Placemark.locality! + ", "
            }
            if Placemark.subLocality != nil {
                
                streetNumber = streetNumber + Placemark.subLocality!

            }
            DispatchQueue.main.async {
                self.LocationLabel.text = "\(streetNumber)"
                
            }
            
        }
    }
    
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longtitude = mapView.centerCoordinate.longitude
        self.long = longtitude
        self.lat = latitude
        UserDefaults.standard.set(self.long, forKey: "Longitude")
        UserDefaults.standard.set(self.lat, forKey: "Latitude")
        
        self.addAnnotationOnLocation(pointedCoordinate: CLLocationCoordinate2D(latitude: self.lat, longitude: self.long))
        return CLLocation(latitude: latitude, longitude: longtitude)
    }
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checklocationAuthorization()
        } else {
            print("Please turn on your location")
        }
    }
    func handleTap(gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.location(in: MapView)
        let coordinate = MapView.convert(location,toCoordinateFrom: MapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        MapView.addAnnotation(annotation)
    }
    
}

extension LocationVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checklocationAuthorization()
    }
    
}
extension LocationVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        guard let previousLocation = self.perviousLocation else { return }
        guard center.distance(from: previousLocation) > 50 else {return}
        perviousLocation = center
        guard self.perviousLocation != nil else {return}
        geoCoder.reverseGeocodeLocation(center) { [weak self] (Placemark, error) in
            guard  let self = self else {return}
            if error != nil {
                print("sorry for it")
                return
                
            }
            guard  let Placemark = Placemark?.first else {
                return
            }
            
            var streetNumber = " "

            
            if Placemark.country != nil {
                
                streetNumber = streetNumber + Placemark.country! + ", "
            }
            if Placemark.thoroughfare != nil {
                
                streetNumber = streetNumber + Placemark.thoroughfare! + ", "
                
            }
            if Placemark.subLocality != nil {
                
                streetNumber = streetNumber + Placemark.subLocality! + ", "

            }
            if Placemark.locality != nil {
                streetNumber = streetNumber + Placemark.locality!
            }
       
                        
            print(streetNumber)
                self.LocationLabel.text = "\(streetNumber)"
        
            
        }
        
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated: Bool) {
        let center = getCenterLocation(for: mapView)
        
        guard let previousLocation = self.perviousLocation else { return }
        guard center.distance(from: previousLocation) > 50 else {return}
        perviousLocation = center
        guard self.perviousLocation != nil else {return}
        geoCoder.reverseGeocodeLocation(center) { [weak self] (Placemark, error) in
            guard  let self = self else {return}
            if error != nil {
                print("sorry for it")
                return
                
            }
            guard  let Placemark = Placemark?.first else {
                return
            }
            var streetNumber = " "

            
            if Placemark.country != nil {
                
                streetNumber = streetNumber + Placemark.country! + ", "
            }
            if Placemark.thoroughfare != nil {
                streetNumber = streetNumber + Placemark.thoroughfare! + ", "
            }
            if Placemark.locality != nil {
                streetNumber = streetNumber + Placemark.locality! + ", "
            }
            if Placemark.subLocality != nil {
                
                streetNumber = streetNumber + Placemark.subLocality!

            }
            
            DispatchQueue.main.async {
                self.LocationLabel.text = "\(streetNumber)"
            }
            
        }
    }
    
    
    
}

extension LocationVC {
    
    func dropPinZoomIn(placemark: MKPlacemark){
        // cache the pin
        
        dismissKeyboard()
        selectedPin = placemark
        // clear existing pins
        MapView.removeAnnotations(MapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        var streetNumber = " "

        if placemark.country != nil {
            
            streetNumber = streetNumber + placemark.country! + ", "
        }
        if placemark.thoroughfare != nil {
            streetNumber = streetNumber + placemark.thoroughfare! + ", "
        }
        if placemark.locality != nil {
            streetNumber = streetNumber + placemark.locality! + ", "
        }
        if placemark.subLocality != nil {
            
            streetNumber = streetNumber + placemark.subLocality!

        }
        
        DispatchQueue.main.async {
        
            self.LocationLabel.text = "\(streetNumber)"
        }
        
//        if let city = placemark.locality,
//            let state = placemark.administrativeArea {
//                annotation.subtitle = "\(city) \(state)"
//        }
        
        MapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: placemark.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            MapView.setRegion(region, animated: true)
        
       // mapView(MapView, regionDidChangeAnimated: true)
        matchingItems.removeAll()
        AutoCompleteTable.reloadData()
            
           
        }

        
//        let span = MKCoordinateSpanMake(0.05, 0.05)
//        let region = MKCoordinateRegionMake(placemark.coordinate, span)
//        MapView.setRegion(region, animated: true)
    }
    


extension LocationVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
//        let selectedItem = matchingItems2[indexPath.row].title
//        cell.textLabel?.text = selectedItem
//        cell.detailTextLabel?.text = matchingItems2[indexPath.row].subtitle
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = matchingItems[indexPath.row].placemark
        dropPinZoomIn(placemark: selectedItem)
    }
        
    func parseAddress(selectedItem:MKPlacemark) -> String {
        
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil &&
                            selectedItem.thoroughfare != nil) ? " " : ""
        
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) &&
                    (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil &&
                            selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        
        return addressLine
    }
    
}


extension LocationVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
       // searchCompleter.queryFragment = searchText

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), latitudinalMeters: 120701, longitudinalMeters: 120701)
            
            //MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        let search = MKLocalSearch(request: request)

        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            print(self.matchingItems)
            self.AutoCompleteTable.reloadData()
        }

    }
}

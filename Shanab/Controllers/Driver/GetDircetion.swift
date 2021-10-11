//
//  GetDircetion.swift
//  Shanab
//
//  Created by mahmoud helmy on 11/8/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import MapKit

class GetDircetion: UIViewController , MKMapViewDelegate{
    
    @IBOutlet weak var DirectionMap: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DirectionMap.delegate = self
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667), addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        
        let directions = MKDirections(request: request)

        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }

            for route in unwrappedResponse.routes {
                self.DirectionMap.addOverlay(route.polyline)
                self.DirectionMap.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }


    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
           let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
           renderer.strokeColor = UIColor.blue
           return renderer
       }


}

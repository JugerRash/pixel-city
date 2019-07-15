//
//  MapVC.swift
//  pixel-city
//
//  Created by juger on 7/15/19.
//  Copyright © 2019 juger. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {

    // Outlets :
    @IBOutlet weak var mapView: MKMapView!
    
    // Variables -:
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus() // to keep track if we let the app using our location or not
    let regionRadius : Double = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
    }

    // Actions -:
    @IBAction func centerCurrLocBtnPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
    
}

extension MapVC : MKMapViewDelegate {
    func centerMapOnUserLocation(){
        guard let coordinate = locationManager.location?.coordinate else { return } // This will bring us the location of the blue point
        let coordinatRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0 )
        mapView.setRegion(coordinatRegion, animated: true)
        
    }
    
}

extension MapVC : CLLocationManagerDelegate {
    
    func configureLocationServices(){
        if authorizationStatus == .notDetermined { // if out authroization not determined then we should ask the user to give us a permission
            locationManager.requestAlwaysAuthorization()
        }else { // otherwise we don't need to ask the user again for permision
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
    
}


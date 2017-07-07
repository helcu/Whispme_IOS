//
//  MapViewController.swift
//  Whispme
//
//  Created by admin on 7/7/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var areaMapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLocation() {
        // Location Manager Setup
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        // Start Location Update
        locationManager.startUpdatingLocation()
        
        // MapView Setup
        areaMapView.delegate = self
        areaMapView.showsUserLocation = true
        areaMapView.showsScale = true
        
        // Show Location in Map
        if let location = locationManager.location {
            self.updateRegion(for: location)
            
            // Simulate
            let annotation = MKPointAnnotation()
            let latitudeDelta = 0.00125
            annotation.coordinate =
                CLLocationCoordinate2D(
                    latitude: location.coordinate.latitude + latitudeDelta,
                    longitude: location.coordinate.longitude)
            annotation.title = "Current Position"
            annotation.subtitle = "On \(NSDate())"
            areaMapView.addAnnotation(annotation)
        }
    }
    
    func updateRegion(for location: CLLocation) {
        areaMapView.setCenter(
            location.coordinate,
            animated: true)
        let delta = 0.0025
        areaMapView.setRegion(
            MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpanMake(
                    delta,
                    delta)),
            animated: true)
    }
    
}

// MARK: - MapView Delegate
extension MapViewController: MKMapViewDelegate {
    
}

// MARK: - Location Manager Delegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.updateRegion(for: location)
        }
    }

}

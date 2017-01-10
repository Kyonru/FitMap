//
//  AgregarRutaViewController.swift
//  FitMap
//
//  Created by fitmap on 12/13/16.
//  Copyright © 2016 FormuladoresDiscretos. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation


class AgregarRutaViewController: UIViewController, CLLocationManagerDelegate{

    var locationManager = CLLocationManager()
    var path = GMSMutablePath()
    var trackedLocations : [CLLocation] = []
    var trackedDistance = 0.00
    
    @IBOutlet weak var MapView: GMSMapView!
    
    var rectangle = GMSPolyline()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if(CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            self.locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            
        }
        
       // MapView.isMyLocationEnabled = true

    

    }
    @IBAction func trackRoute(_ sender: UIButton) {
        if sender.currentTitle == "Start"{
            sender.setTitle("Stop", for:.normal)
            locationManager.startUpdatingLocation()
    
        }else{
            sender.setTitle("Start",for:.normal)
            
            locationManager.stopUpdatingLocation()
            path = GMSMutablePath()
            trackedLocations = []
            trackedDistance = 0.00
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        
        let locValue = locations.last!
        
        // Adding locations to a list
        trackedLocations.append(locValue)
      //  locValue.d
        let long = locValue.coordinate.longitude
        let lat = locValue.coordinate.latitude
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        
        MapView.camera = camera
        
        MapView.isMyLocationEnabled = true

        path.add(locValue.coordinate)
        rectangle = GMSPolyline(path: path)
        rectangle.map = MapView

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

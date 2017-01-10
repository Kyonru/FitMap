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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var MapView: GMSMapView!
    
    @IBAction func showAlertButtonTapped(_ sender: UIButton) {
        
        // create the alert
        let alert = UIAlertController(title: "That was awesome!", message: "Would you like to save this route?", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                self.cleanData()
                
            }
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func trackRoute(_ sender: UIButton) {
        if sender.currentTitle == "Start"{
            sender.setTitle("Stop", for:.normal)
            locationManager.startUpdatingLocation()
    
        }else{
            sender.setTitle("Start",for:.normal)
            
            locationManager.stopUpdatingLocation()
            cleanData()
            showAlertButtonTapped(sender)
            
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        
        let locValue = locations.last!
        
        // Adding locations to a list
        trackedLocations.append(locValue)

        let long = locValue.coordinate.longitude
        let lat = locValue.coordinate.latitude
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        
        MapView.camera = camera
        
        MapView.isMyLocationEnabled = true

        path.add(locValue.coordinate)
        rectangle = GMSPolyline(path: path)
        rectangle.map = MapView

    }
    
    func cleanData(){
        path = GMSMutablePath()
        trackedLocations = []
        trackedDistance = 0.00
    }

}

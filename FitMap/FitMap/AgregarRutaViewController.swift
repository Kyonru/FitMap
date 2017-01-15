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
    var trackedSpeed : [CLLocationSpeed] = []
    var trackedDistance = 0.00
    var currentSpeed = 0.00
    var rectangle = GMSPolyline()
    var stateForFirstLocation = false
    var initialLocation = CLLocation(latitude: 0.00, longitude: 0.00)
    var startingTime = DispatchTime.now()
    var endingTime = DispatchTime.now()
    
    
    @IBOutlet weak var currentSpeedLabel: UILabel!
    @IBOutlet weak var currentDistanceLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    
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
                
                /*
                  Create a route instance, and assign time and distance to it
                  Then, send this instance to editarRutaViewController
                */
                let route = Route()
                
                route.setDistance(distance: self.trackedDistance)

                route.setTime(time: Int64(self.endingTime.uptimeNanoseconds)-Int64(self.startingTime.uptimeNanoseconds))
            
                
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "AgregarRuta", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EditarRutaViewController") as! EditarRutaViewController

                nextViewController.getRouteData(route: route) // Sending the route data recorded to the editarRutaViewController
                
                self.present(nextViewController, animated:true, completion:nil)
                
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
            startingTime = DispatchTime.now()
            
        }else{
            sender.setTitle("Start",for:.normal)
            
            locationManager.stopUpdatingLocation()
            cleanData()
            //endingTime = DispatchTime.now()

            showAlertButtonTapped(sender)
            
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let locValue = locations.last!
        
        //Updating data in the UI
        currentSpeed = locValue.speed
        if(locations.count == 1){
            trackedDistance = locValue.distance(from: initialLocation)
        }else{
            trackedDistance += locations.last!.distance(from: locations[locations.count-2])
        }
        
            //locValue.distance(from: initialLocation)
        currentSpeedLabel.text = "\(currentSpeed)" + " m/s"
        currentDistanceLabel.text = "\(trackedDistance)" + " m"
        
        endingTime = DispatchTime.now()
        currentTimeLabel.text = "\(endingTime.uptimeNanoseconds-startingTime.uptimeNanoseconds)"
        
        // Adding locations to a list
        trackedLocations.append(locValue)
        
        let long = locValue.coordinate.longitude
        let lat = locValue.coordinate.latitude
        
        
        
        
        //Here is the creation of the initial marker
        if stateForFirstLocation == false{
            initialLocation = CLLocation(latitude: lat, longitude: long)
            let initialMarker = GMSMarker()
            initialMarker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            initialMarker.map = MapView
            
            stateForFirstLocation = true
        }
        
        
        
        
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
        currentSpeed = 0.00
        stateForFirstLocation = false
        currentSpeedLabel.text = " 0.00 m/s"
        currentDistanceLabel.text = " 0.00 m"
        currentTimeLabel.text = " 00 s "
        MapView.clear()
        
    }
    
}

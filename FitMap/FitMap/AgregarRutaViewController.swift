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
    var camera = GMSCameraPosition()
    var trackedLocations : [CLLocation] = []
    var trackedSpeed : [CLLocationSpeed] = []
    var trackedDistance = 0.00
    var currentSpeed = 0.00
    var rectangle = GMSPolyline()
    var stateForFirstLocation = false
    var initialLocation = CLLocation(latitude: 0.00, longitude: 0.00)
    var startingTime = DispatchTime.now()
    var endingTime = DispatchTime.now()
    var run = RunSpeedTimeDistance()
    var firstTime = false
    var wasFirst = false
    
    
    @IBOutlet weak var currentSpeedLabel: UILabel!
    @IBOutlet weak var currentDistanceLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var timeView: UIVisualEffectView!
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var speedView: UIVisualEffectView!
    
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

        locationManager.startUpdatingLocation()
//        locationManager.stopUpdatingLocation()

        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.red]
        
        tabBarController?.tabBar.barTintColor = UIColor.black
        tabBarController?.tabBar.tintColor = UIColor.red
        
        // MapView.isMyLocationEnabled = true
        
        
        //Rounding borders
        timeView.layer.cornerRadius = 15.0
        timeView.clipsToBounds = true
//        timeView.backgroundColor = UIColor(red:0.255, green: 0.148, blue: 0.163, alpha: 1.0)

        
        distanceView.layer.cornerRadius = 15.0
        distanceView.clipsToBounds = true
        
        speedView.layer.cornerRadius = 15.0
        speedView.clipsToBounds = true
        
        
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
                
                //Sending the route data recorded to the editarRutaViewController
                nextViewController.getPoints(trackedLocations: self.trackedLocations)
                
                for point in self.trackedLocations{

                    print(point.coordinate.latitude)
                    print(point.coordinate.longitude)
                }
                
                self.present(nextViewController, animated:true, completion:nil)
                
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("")
               self.cleanData()
                
            }
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func trackRoute(_ sender: UIButton) {
        wasFirst = true
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
        let long = locValue.coordinate.longitude
        let lat = locValue.coordinate.latitude
        
        if(!firstTime == false && wasFirst == true){
            
//            let locValue = locations.last!
            //Updating data in the UI
            currentSpeed = locValue.speed
            if(locations.count == 1){
                trackedDistance = locValue.distance(from: initialLocation)
            }else{
                trackedDistance += locations.last!.distance(from: locations[locations.count-2])
            }
            
            //locValue.distance(from: initialLocation)
            currentSpeedLabel.text = "\(currentSpeed)" + " m/s"
            currentDistanceLabel.text = run.distance(Distance: trackedDistance) + " m"
            
            endingTime = DispatchTime.now()
            currentTimeLabel.text = run.nanoToSeconds(seconds: Double(endingTime.uptimeNanoseconds-startingTime.uptimeNanoseconds))
            
            // Adding locations to a list
            trackedLocations.append(locValue)
            
            //Here is the creation of the initial marker
            if stateForFirstLocation == false{
                initialLocation = CLLocation(latitude: lat, longitude: long)
                let initialMarker = GMSMarker()
                initialMarker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
                initialMarker.icon = UIImage(named: "pin2")
                initialMarker.map = MapView
                
                camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
                
                MapView.camera = camera
                
                stateForFirstLocation = true
            }
            
            //Following the user location
            let updateCam = GMSCameraUpdate.setTarget(locations.last!.coordinate)
            MapView.animate(with: updateCam)
            
            
            
            MapView.isMyLocationEnabled = true
            
            path.add(locValue.coordinate)
            rectangle = GMSPolyline(path: path)
            rectangle.map = MapView
        }else{
            
            camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
            let updateCam = GMSCameraUpdate.setTarget(locations.last!.coordinate)
            MapView.animate(with: updateCam)
            MapView.camera = camera
            MapView.isMyLocationEnabled = true
            firstTime = true
            
        }
        
        
        
    }
    
    func cleanData(){
        path = GMSMutablePath()
//        trackedLocations = []
//        trackedDistance = 0.00
        currentSpeed = 0.00
        stateForFirstLocation = false
        currentSpeedLabel.text = " 0.00 m/s"
        currentDistanceLabel.text = " 0.00 m"
        currentTimeLabel.text = " 00 s "
        MapView.clear()
        
    }
    
}

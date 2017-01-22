//
//  DetalleRutaViewController.swift
//  FitMap
//
//  Created by fitmap on 12/13/16.
//  Copyright © 2016 FormuladoresDiscretos. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class DetalleRutaViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate{

    //Initializing
    var locationManager = CLLocationManager()
    var stateForFirstLocation = false
    var initialLocation = CLLocation(latitude: 0.00, longitude: 0.00)
    var path = GMSMutablePath()
    var path2 = GMSMutablePath()
    var rectangle = GMSPolyline()
    var rectangle2 = GMSPolyline()
    
    @IBOutlet weak var cyclingButton: UIButton!
    @IBOutlet weak var runningButton: UIButton!
    @IBOutlet weak var skatingButton: UIButton!
    
    var discipline = "" //discipline selected
    
    @IBOutlet weak var disciplinesView: UIView!
    
    @IBOutlet weak var MapView: GMSMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Check if its first time openning app
        //If it is, I will launch the login screen
        
        if(UserDefaults.standard.bool(forKey: "HasLaunchedOnce"))
        {
             self.dismiss(animated: true, completion: nil)
            // app already launched
            let storyBoard : UIStoryboard = UIStoryboard(name: "DetalleRuta", bundle:nil)
            let launchViewController = storyBoard.instantiateViewController(withIdentifier: "LaunchViewController") as! LaunchViewController
            
            self.present(launchViewController, animated:true, completion:nil)

            
        }
        else
        {
            self.dismiss(animated: true, completion: nil)
            // This is the first launch ever
            // Invokes the launch screen
            let storyBoard : UIStoryboard = UIStoryboard(name: "DetalleRuta", bundle:nil)
            let launchViewController = storyBoard.instantiateViewController(withIdentifier: "LaunchViewController") as! LaunchViewController
            
             self.present(launchViewController, animated:true, completion:nil)
            
            
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
        }
        

        // Do any additional setup after loading the view.
        
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if(CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            self.locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
           
        }
        
        MapView.delegate = self
        
        
        // Loading polylines to mapView
        
        let routeData = RouteDataSource() //initializing the model RouteDataSource
//        routeData.retrievePath(MapView: MapView) //This method draws the routes on map
        routeData.retrievePath(MapView: MapView)
        
        //Rounding borders
        disciplinesView.layer.cornerRadius = 10.0
        disciplinesView.clipsToBounds = true
        
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //Locaciones.append(locations.last!)
        let locValue = locations.last!
        
        
        let long = locValue.coordinate.longitude
        let lat = locValue.coordinate.latitude
        
        //Here is the creation of the initial marker
        if stateForFirstLocation == false{
            initialLocation = CLLocation(latitude: lat, longitude: long)
            let initialMarker = GMSMarker()
            initialMarker.title = "0"
            initialMarker.icon = UIImage(named: "pin2")
            initialMarker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            initialMarker.map = MapView
            
            stateForFirstLocation = true
        }

        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        MapView.camera = camera
        
        MapView.delegate = self
        
        
        MapView.isMyLocationEnabled = true
        
        //view = MapView
        
        locationManager.stopUpdatingLocation()
        
    }
    
    //// Marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        /*
         Given the marker title (route ID), we will call a method on RouteDataSource
         that will draw the given route on the detailViewController, and will center the camera 
         on the route coordinates
        */
        
        var markerId = 0
        markerId = Int(marker.title!)!
        
        let routeData = RouteDataSource()
        routeData.setRouteId(markerId, mapView: MapView)
        

        ////////////
        
        self.dismiss(animated: true, completion: nil)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "DetalleRuta", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsReviewViewController") as! DetailsReviewViewController

        self.navigationController?.pushViewController(nextViewController, animated: true)
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Capturing the discipline buttons info
    

    @IBAction func disciplineSelected(_ sender: UIButton){
        
        let buttonTouched = sender.currentImage!
        
        
        /*
        Pourpose: when a user tap 1 button, we got to query
        the routes based on that category
        */
        
        
        switch buttonTouched {
        case UIImage(named: "bicycle")!:
            cyclingButton.setImage(UIImage(named: "bici-selected"), for: .normal)
            discipline = "cycling"
        case UIImage(named: "icon")!:
            discipline = "running"
        case UIImage(named: "skateboard-2")!:
            discipline = "skating"
        default:
            discipline = ""
        }
        
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

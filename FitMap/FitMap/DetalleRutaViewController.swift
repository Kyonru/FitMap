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
    
    @IBOutlet weak var MapView: GMSMapView!

    
//    @IBOutlet weak var FirstViewContainer: UIView!
//    
//    @IBOutlet weak var SecondViewContainer: UIView!
//    
//    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    
    
    
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
            locationManager.startUpdatingLocation()
           
        }
        
        MapView.delegate = self
        
        
        //Cargar todos los polylines al mapView
        

        let routeData = RouteDataSource() //initializing the model RouteDataSource
        
        routeData.retrievePath(MapView: MapView) //This method draws the routes on map
       
        
        
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
            initialMarker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            initialMarker.map = MapView
            
            stateForFirstLocation = true
        }

        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        MapView.camera = camera
        
        MapView.delegate = self //following market clickable
        
        
        MapView.isMyLocationEnabled = true
        
        //view = MapView
        
        locationManager.stopUpdatingLocation()
        
    }
    

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        self.dismiss(animated: true, completion: nil)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "DetalleRuta", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsReviewViewController") as! DetailsReviewViewController

        self.navigationController?.pushViewController(nextViewController, animated: true)
        return true
    }
    
    @IBAction func DummyButton(_ sender: Any) {
        
        
        //MapView.isMyLocationEnabled = false
        //locationManager.stopUpdatingLocation()
        
//        MapView.isHidden = true
//       
//        SecondViewContainer.isHidden = true
//        FirstViewContainer.isHidden = false
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    
//    
//    //Switching between views (first = details; second = review)
//
//    @IBAction func ChangeView(_ sender: UISegmentedControl) {
//        
//        switch SegmentedControl.selectedSegmentIndex {
//        case 1:
//            FirstViewContainer.isHidden = false
//            SecondViewContainer.isHidden = true
//            break
//            
//        default:
//            FirstViewContainer.isHidden = true
//            SecondViewContainer.isHidden = false
//            
//        }
//        
//    }
//    
//    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

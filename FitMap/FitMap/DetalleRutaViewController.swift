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

class DetalleRutaViewController: UIViewController, CLLocationManagerDelegate {

    //Initializing
    var locationManager = CLLocationManager()


    @IBOutlet weak var MapView: GMSMapView!

    
    @IBOutlet weak var FirstViewContainer: UIView!
    
    @IBOutlet weak var SecondViewContainer: UIView!
    
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    
    
    
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
        
        MapView.isMyLocationEnabled = true

        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //Locaciones.append(locations.last!)
        let locValue = locations.last!
        
        let long = locValue.coordinate.longitude
        let lat = locValue.coordinate.latitude
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        MapView.camera = camera
        
        MapView.isMyLocationEnabled = true
        
        //view = MapView

        locationManager.stopUpdatingLocation()
    }
    

    
    @IBAction func DummyButton(_ sender: Any) {
//        
//        MapView.isHidden = true
//       
//        SecondViewContainer.isHidden = true
//        FirstViewContainer.isHidden = false
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //Switching between views (first = details; second = review)

    @IBAction func ChangeView(_ sender: UISegmentedControl) {
        
        switch SegmentedControl.selectedSegmentIndex {
        case 1:
            FirstViewContainer.isHidden = false
            SecondViewContainer.isHidden = true
            break
            
        default:
            FirstViewContainer.isHidden = true
            SecondViewContainer.isHidden = false
            
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

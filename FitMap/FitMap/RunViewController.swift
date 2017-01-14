//
//  RunViewController.swift
//  FitMap
//
//  Created by fitmap on 1/11/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import UIKit
import GoogleMaps

class RunViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var doRouteButton: UIButton!
    @IBOutlet weak var MapView: GMSMapView!
    @IBOutlet weak var currentDistanceLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var doneRouteButton: UIButton!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        doRouteButton.isHidden = false
        doneRouteButton.isHidden = true
        
        //LOCATIONMANAGER
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if(CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            self.locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        
        locationManager.stopUpdatingLocation()
        cleanData()
        let storyBoard : UIStoryboard = UIStoryboard(name: "DetalleRuta", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RouteSummaryViewController") as! RouteSummaryViewController
        
        doneRouteButton.isHidden = true
        doRouteButton.isHidden = false
        
        self.present(nextViewController, animated:true, completion:nil)
        
    }

    @IBAction func doButton(_ sender: UIButton) {
        doneRouteButton.isHidden = false
        doRouteButton.isHidden = true
        sender.setTitle("Stop", for:.normal)
        locationManager.startUpdatingLocation()
        startingTime = DispatchTime.now()
        
       
        
    }
    
    
    func cleanData(){
        path = GMSMutablePath()
        trackedLocations = []
        trackedDistance = 0.00
        currentSpeed = 0.00
        stateForFirstLocation = false
        currentDistanceLabel.text = " 0.00 m"
        currentTimeLabel.text = " 00 s "
        MapView.clear()
        
    }
    
    //++
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let locValue = locations.last!
        
        //Updating data in the UI
        currentSpeed = locValue.speed
        trackedDistance = locValue.distance(from: initialLocation)
        //currentSpeedLabel.text = "\(currentSpeed)" + " m/s"
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

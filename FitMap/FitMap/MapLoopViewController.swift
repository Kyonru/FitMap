//
//  MapLoopViewController.swift
//  FitMap
//
//  Created by Jhonny Bill Mena on 1/8/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Alamofire


class MapLoopViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBAction func loopButton(_ sender: UIButton) {
        self.addOverlayToMapView()
        
        
        
    }
    var locationManager = CLLocationManager()
    let path = GMSMutablePath()
    var pathString = GMSPath()
    
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
            locationManager.startUpdatingLocation()
            
        //Cosa
            //callWebService()
           // addOverlayToMapView()
    }
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
        
        //path.add(locValue.coordinate)
        
        /*
        let path: GMSPath = GMSPath(fromEncodedPath: "kyzoBd|~iLyc@aBoIWa@Eq@I@LLB\\DbDJ~ZhAp\\nApHV`@LNNFVPVJj@Dr@QfN@bADpAPnA\\rAj@hANWOUa@_AKa@")!
       
        rectangle = GMSPolyline(path: path)
        rectangle.map = MapView*/
        //locationManager.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addOverlayToMapView(){
        
        let directionURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(18.492516),\(-69.958859)&destination=\(18.488095),\(-69.964144)&mode=walking&key=AIzaSyBDw7YtmcgAElskM3KKE0jXWt8gMQeBeYU"
        
        Alamofire.request(directionURL, method: .get, parameters: nil).responseJSON { response in
           
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let  cjson = response.result.value as? NSDictionary{
                print("JSON: \(cjson)")
                print(2312)
            }
            
            let json = "\(response.result.value)"
            let routesArray = json.components(separatedBy: "\"")
            let Camino = self.search(withPath: routesArray)
            let a = "kyzoBd|~iLyc@aBoIWa@Eq@I@LLB\\DbDJ~ZhAp\\nApHV`@LNNFVPVJj@Dr@QfN@bADpAPnA\\rAj@hANWOUa@_AKa@"
       
            //self.pathString = GMSPath(fromEncodedPath: Camino.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)!
            self.pathString = GMSPath(fromEncodedPath: Camino)!
            self.DummysetMapviewPath()
            
        }
    
    }
    
    func DummysetMapviewPath(){
        
        rectangle = GMSPolyline(path: pathString)
        rectangle.map = MapView
        
        
    }
    
    
    //Func search for routePath
    func search(withPath: [String])->String{
        let encodedpoints = ""
        let objetive = "overview_polyline"
        
        for i in 0..<withPath.count{
            print("\(i)" + withPath[i])
            if(withPath[i] == objetive){
                let a = withPath[i+2]
                return a.replacingOccurrences(of: "\\\\",with: "\\")
                
            }
        }
        return encodedpoints
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

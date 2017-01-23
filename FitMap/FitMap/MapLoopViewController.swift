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
       // self.addOverlayToMapView()
        self.calculaWaypoints()
        MapView.clear()
    }
    
    var locationManager = CLLocationManager()
    let path = GMSMutablePath()
    var pathString = GMSPath()
    
    
    var longFinal = CLLocationDegrees()
    var latFinal = CLLocationDegrees()
    
    var longInicial = CLLocationDegrees()
    var latInicial = CLLocationDegrees()
    
    var longFirswaypoint = CLLocationDegrees()
    var latFirstwaypoint = CLLocationDegrees()
    
    var longSecondwaypoint = CLLocationDegrees()
    var latSecondwaypoint = CLLocationDegrees()
    
    var longThirdwaypoint = CLLocationDegrees()
    var latThirdwaypoint = CLLocationDegrees()
    
    var firstCoordinate = CLLocationCoordinate2D()
    var secondCoordinate = CLLocationCoordinate2D()
    var thirdCoordinate = CLLocationCoordinate2D()
    var move = CLLocationCoordinate2D()
    
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
            
    }
}

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //Locaciones.append(locations.last!)
        
        let locValue = locations.last!
        
        longInicial = (locations.first?.coordinate.longitude)!
        latInicial=(locations.first?.coordinate.latitude)!
        
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
    
    func LoadLoop(){
        
    }
    
    func addOverlayToMapView(lat: CLLocationDegrees, long: CLLocationDegrees, latFinal: CLLocationDegrees, longFinal: CLLocationDegrees){
        
        let firstCoordinate = CLLocationCoordinate2DMake(latFinal, longFinal)
        
        let directionURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(lat),\(long)&destination=\(firstCoordinate.latitude),\(firstCoordinate.longitude)&mode=walking&key=AIzaSyBDw7YtmcgAElskM3KKE0jXWt8gMQeBeYU"
        
        print (directionURL)
        Alamofire.request(directionURL, method: .get, parameters: nil).responseJSON { response in
        
            
            let json = "\(response.result.value)"
            
            print (json)
            
            let routesArray = json.components(separatedBy: "\"")
            let Camino = self.search(withPath: routesArray)
            self.pathString = GMSPath(fromEncodedPath: Camino)!
            self.DummysetMapviewPath()
            
        }
    
    }
    
    func locationWithBearing(bearing:Double, distanceMeters:Double, origin:CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let distRadians = distanceMeters / (6372797.6)
        
        let rbearing = bearing * M_PI / 180.0
        
        let lat1 = origin.latitude * M_PI / 180
        let lon1 = origin.longitude * M_PI / 180
        
        let lat2 = asin(sin(lat1) * cos(distRadians) + cos(lat1) * sin(distRadians) * cos(rbearing))
        let lon2 = lon1 + atan2(sin(rbearing) * sin(distRadians) * cos(lat1), cos(distRadians) - sin(lat1) * sin(lat2))
        
        return CLLocationCoordinate2D(latitude: lat2 * 180 / M_PI, longitude: lon2 * 180 / M_PI)
    }
    
    
    
    func calcularFirstwaypoint(bearing: Float, distanceMeters: Float){
        firstCoordinate = CLLocationCoordinate2DMake(latInicial, longInicial)
        move = locationWithBearing(bearing: Double(bearing), distanceMeters: Double(distanceMeters), origin: firstCoordinate)
        
        latFirstwaypoint = move.latitude
        longFirswaypoint = move.longitude
        
        self.addOverlayToMapView(lat: latInicial, long: longInicial, latFinal: latFirstwaypoint, longFinal: longFirswaypoint)
    }
    
    func calcularSecondwaypoint(bearing: Float, distanceMeters: Float){
        secondCoordinate = CLLocationCoordinate2DMake(latFirstwaypoint, longFirswaypoint)
        move = locationWithBearing(bearing: Double(bearing), distanceMeters: Double(distanceMeters), origin: secondCoordinate)
        
        latSecondwaypoint = move.latitude
        longSecondwaypoint = move.longitude
        
        
        self.addOverlayToMapView(lat: latFirstwaypoint, long: longFirswaypoint, latFinal: latSecondwaypoint, longFinal: longSecondwaypoint)
        
    }
    
    func calcularThirdwaypoint(bearing: Float, distanceMeters: Float){
        
        thirdCoordinate = CLLocationCoordinate2DMake(latSecondwaypoint, longSecondwaypoint)
        move = locationWithBearing(bearing: Double(bearing), distanceMeters: Double(distanceMeters), origin: thirdCoordinate)
        
        latThirdwaypoint = move.latitude
        longThirdwaypoint = move.longitude
        
        addOverlayToMapView(lat: latSecondwaypoint, long: longSecondwaypoint, latFinal: latThirdwaypoint, longFinal: longThirdwaypoint)
        
    }
    func calculaWaypoints(){
        
        calcularFirstwaypoint(bearing: 0,distanceMeters: 0)
        calcularSecondwaypoint(bearing: 0,distanceMeters: 0)
        calcularThirdwaypoint(bearing: 0,distanceMeters: 0)
        
        
        //Regresar al inicio
        //////////////////////////////
        latFinal = latInicial
        longFinal = longInicial

        addOverlayToMapView(lat: latThirdwaypoint, long: longThirdwaypoint, latFinal: latFinal, longFinal: longFinal)
        //////////////////////////////
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
           // print("\(i)" + withPath[i])
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

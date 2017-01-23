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
    
    
    let directionkey = "AIzaSyCh8ryDtzhxTmOQx8MyS2aybz14oi1M2-w"
    
    var stateForFirstLocation = false
    var camera = GMSCameraPosition()
    
    var locationManager = CLLocationManager()
    let path = GMSMutablePath()
    var pathString = GMSPath()
    
    var rectangle = GMSPolyline()
    
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
    
    var minimo = Int()
    var maximo = Int()
    
    @IBAction func loopButton(_ sender: UIButton) {
        // self.addOverlayToMapView()
        
        self.calculaWaypoints()
        MapView.clear()
    }
    
    @IBOutlet weak var MapView: GMSMapView!
    
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
    //////////////////////////////
    ///////Track User/////////////
    //////////////////////////////
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //Locaciones.append(locations.last!)
        
        let locValue = locations.last!
        var initialLocation = CLLocation(latitude: 0.00, longitude: 0.00)
        
        
        longInicial = (locations.first?.coordinate.longitude)!
        latInicial=(locations.first?.coordinate.latitude)!
        
        let long = locValue.coordinate.longitude
        let lat = locValue.coordinate.latitude
        //        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        
        if stateForFirstLocation == false{
            
            initialLocation = CLLocation(latitude: lat, longitude: long)
            let initialMarker = GMSMarker()
            initialMarker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            initialMarker.icon = UIImage(named: "pin2")
            initialMarker.map = MapView
            
            
            camera = GMSCameraPosition.camera(withLatitude: latInicial, longitude: longInicial, zoom: 15.0)
            
            MapView.camera = camera
            
            stateForFirstLocation = true
        }
        
        //Following the user location
        let updateCam = GMSCameraUpdate.setTarget(locations.last!.coordinate)
        MapView.animate(with: updateCam)
        
        
        
        MapView.isMyLocationEnabled = true
        
        path.add(locValue.coordinate)
        rectangle = GMSPolyline(path: path)
        rectangle.geodesic = true
        rectangle.strokeColor = UIColor.orange
        rectangle.strokeWidth = 2
        rectangle.map = MapView
        
        
        //        MapView.camera = camera
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
    
    
    //////////////////////////////
    ///////Instancia/////////////
    //////////////////////////////
    
    @IBAction func Cerrar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func LoadLoop(min: Int, max: Int){
        minimo = min
        maximo = max
        minimo = minimo * 100
        maximo = maximo * 250
        print("//////////////////////////////////////////////")
        print(minimo)
        print(maximo)
    }
    
    
    //////////////////////////////
    ///////Request JSON///////////
    //////////////////////////////
    
    func addOverlayToMapView(lat: CLLocationDegrees, long: CLLocationDegrees, latFinal: CLLocationDegrees, longFinal: CLLocationDegrees){
        
        let firstCoordinate = CLLocationCoordinate2DMake(latFinal, longFinal)
        
        let directionURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(lat),\(long)&destination=\(firstCoordinate.latitude),\(firstCoordinate.longitude)&mode=walking&key=\(directionkey)"
        
        print (directionURL)
        Alamofire.request(directionURL, method: .get, parameters: nil).responseJSON { response in
            
            
            let json = "\(response.result.value)"
            
            print (json)
            
            let routesArray = json.components(separatedBy: "\"")
            let Camino = self.search(withPath: routesArray)
            //Camino.replacingOccurrences(of: " ", with: "+")
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
        // Random Number
        var randomNum = arc4random_uniform(360)
        var bearing = Float(randomNum)
        var elegir = Int(arc4random_uniform(2))
        if(elegir==1){
            bearing = bearing * -1
        }
        randomNum = arc4random_uniform(UInt32(Int(maximo/4)))
        var distanceMeters = Float(randomNum + UInt32(Int(minimo/4)))
        
        calcularFirstwaypoint(bearing: bearing,distanceMeters: distanceMeters)
        
        randomNum = arc4random_uniform(360)
        bearing = Float(randomNum)
        elegir = Int(arc4random_uniform(2))
        if(elegir==1){
            bearing = bearing * -1
        }
        randomNum = arc4random_uniform(UInt32(Int(maximo/4)))
        distanceMeters = Float(randomNum + UInt32(Int(minimo/4)))
        
        calcularSecondwaypoint(bearing: bearing,distanceMeters: distanceMeters)
        
        randomNum = arc4random_uniform(360)
        bearing = Float(randomNum)
        elegir = Int(arc4random_uniform(2))
        if(elegir==1){
            bearing = bearing * -1
        }
        
        randomNum = arc4random_uniform(UInt32(Int(maximo/4)))
        distanceMeters = Float(randomNum + UInt32(Int(minimo/4)))
        
       // randomNum = arc4random_uniform(500)
       // distanceMeters = Float(randomNum + 150)
        
        
        calcularThirdwaypoint(bearing: bearing,distanceMeters: distanceMeters)
        
        
        //Regresar al inicio
        //////////////////////////////
        latFinal = latInicial
        longFinal = longInicial
        
        addOverlayToMapView(lat: latThirdwaypoint, long: longThirdwaypoint, latFinal: latFinal, longFinal: longFinal)
        //////////////////////////////
        
        print("//////////////////////////////////////////////")
        print(minimo)
        print(maximo)
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
            let m = " =             {\n"+"points = "
            // print("\(i)" + withPath[i])
            if(withPath[i] == objetive){
                if(withPath[i+1] != m){
                    let a = withPath[i+2]
                    return a.replacingOccurrences(of: "\\\\",with: "\\")
                }else{
                    let a = " =             {\n"+"points = "
                    let b = ";\n"+"};\n"+"summary ="
                    
                    let c = withPath[i+1]
                    c.replacingOccurrences(of: a, with: "")
                    c.replacingOccurrences(of: b, with: "")
                    
                    return c
                }
            
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

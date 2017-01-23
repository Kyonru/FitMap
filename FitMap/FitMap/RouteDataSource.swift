//
//  RouteDataSource.swift
//  FitMap
//
//  Created by fitmap on 1/12/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps
import Alamofire

class RouteDataSource {

    
    var routesArray: [[CLLocationCoordinate2D]] = []
    var locationsArray: [CLLocationCoordinate2D] = []
    
    var routesList : [Int] = []
    var x : [String] = []    /*
     *   I guess: we will have an instance of our API, we will call it
     *   it will return us an array of array of coordinates (CLLocationCoordinate2D).
     *   When our viewDidLoad calls our retrievePath wrapper, this will invoke our retrievePath method
     *   with the array returned by our API, plus the mapView from the wrapper
     *
     */
    
    //Por cada resultado del query, creo un objeto ruta con su id. Por cada ruta, hago un query 
    // que me traiga los puntos de esa ruta ID, y mando ese arreglo de arreglo de coordenadas (todas las rutas) a retrieve path, que la dibujara en el map 
    
    //Creo objetos rutas a partir del query, y ahí mismo pongo la data
    let testRoute = Route();
    let testRoute2 = Route();
    
    func retrieveRoute(MapView: GMSMapView!){
        
        
        let urlString = "http://54.244.37.198/api/v1/routes/unique/id"
        
        _ = Alamofire.request(urlString, method: .get).responseJSON(completionHandler:{                   Respuesta in

            DispatchQueue.main.async {

                print("\(Respuesta.result.value)")
                self.routesList = Respuesta.result.value as! [Int]
                self.retrievePath(MapView: MapView)
            }
        } )
    }
    
    //wrapper
    func retrievePath(MapView: GMSMapView!) {
        for route in routesList{
            let urlString = "http://54.244.37.198/api/v1/points/"
            let parameters:Parameters = [
                "idRoute" : "\(route)"]
            
            _ = Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON(completionHandler:{Respuesta in
                
                DispatchQueue.main.async {
                    self.x = Respuesta.result.value as! [String]
                    for i in self.x{
                        let coordinateArr = i.components(separatedBy: ",")
                        let coordinate = CLLocationCoordinate2DMake(Double(coordinateArr[1])!, Double(coordinateArr[0])!)
                        self.self.locationsArray.append(coordinate)
                    }
                    self.routesArray.append(self.locationsArray)
                    

                    let yy = self.locationsArray
                    self.retrievePath([yy], map: MapView, route: route)
                    self.locationsArray = []
                }
            } )
            
        
        }


        

        
//        retrievePath(routesArray, map: MapView, route: testRoute2)
        
    }
    
    
    private func retrievePath(_ routes: [[CLLocationCoordinate2D]], map MapView: GMSMapView!, route: Int) {
        
        for array in routes {
            
            let path = GMSMutablePath()
            var polyline = GMSPolyline()
            
            for coordinate in array {
                path.add(coordinate)
                polyline = GMSPolyline(path: path)
            }
            
            polyline.strokeWidth = 4
            polyline.geodesic = true
            polyline.strokeColor = UIColor.red//(red:96, green: 255, blue: 29, alpha: 1.0)
            polyline.map = MapView
            
//            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
           print(array.count)
            
            setMarker(route: array, map: MapView, routeInfo: route)
            
        }
        
    }
    
    
    private func setMarker(route: [CLLocationCoordinate2D], map MapView: GMSMapView!, routeInfo: Int) {
        
//        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
//        for p in route {
//            print(p.longitude)
//            print(p.latitude)
//        }
        
        if (route.last != nil){
            let initialLocation = route.last!
            let initialMarker = GMSMarker()
            
            //Set the marketTitle equals the routeID
            
            
            //        if initialMarker.title == "\(id)" {
            initialMarker.title = "\(routeInfo)"
            //        }else{
            //            initialMarker.title = "0"
            //        }
            
            initialMarker.icon = UIImage(named: "pin2")
            initialMarker.position = CLLocationCoordinate2D(latitude:initialLocation.latitude, longitude: initialLocation.longitude)
            initialMarker.map = MapView
        }

        
        
    }
    

    
    
    //This func draw a route, and center the camera map on it
    
    func drawRoute(route: Int, map mapView: GMSMapView){
        
        /*
         Given that ID we got to query the route, AKA:
         retrieve the coordinates array of that route from API (who is connected to our DB)
        */
        
        //Init: Chunk used for testing
        locationsArray.append(CLLocationCoordinate2D(latitude: 18.488031, longitude: -69.963176))
        locationsArray.append(CLLocationCoordinate2D(latitude: 18.487952, longitude: -69.963170))
        locationsArray.append(CLLocationCoordinate2D(latitude: 18.487548, longitude: -69.963169))
        locationsArray.append(CLLocationCoordinate2D(latitude: 18.487439, longitude: -69.963059))
        //End: Chunk used for testing

        
        drawRoute(locationsArray, map: mapView, routeInfo: route)
        
    }
    
     //This func draw a route given the ID of that route, and center the camera map on it
    private func drawRoute(_ route: [CLLocationCoordinate2D], map mapView: GMSMapView, routeInfo : Int) {
        
        let path = GMSMutablePath()
        var polyline = GMSPolyline()
        
        setMarker(route: route, map: mapView, routeInfo: routeInfo)
        
        
        for coordinate in route {
            
            path.add(coordinate)
            polyline = GMSPolyline(path: path)
            
        }
        
        polyline.map = mapView
        
        
        //center the camera
        let camera = GMSCameraPosition.camera(withLatitude: route.first!.latitude, longitude: route.last!.longitude, zoom: 18.0)
        mapView.camera = camera
        
        
    }
    
    
    //Retrieve from database routeData, and send it to the viewController
    
    
    
    
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    ///Get and set the routeId given a marker title
    var routeId = 0
    func setRouteId(_ id: Int, mapView: GMSMapView) {
        routeId = id
        
        //Llamar funcion que traiga toda la info de la ruta para crear el objeto ruta
        
        //dibujar en base a ese objeto ruta
        retrievePath(MapView: mapView)
    }
    
    func getRouteId() -> Int {
        return routeId
    }
    ///////
    
    
    
    /*
     * Once I got the routeID, I query all the route info based on that ID
     * And send that route object to detailViewController
     */
    
  
    
    
    
    
    

}

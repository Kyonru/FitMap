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


class RouteDataSource {

    
    var routesArray: [[CLLocationCoordinate2D]] = []
    var locationsArray: [CLLocationCoordinate2D] = []
    
    
    /* 
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
        
        
        testRoute.id = 0
        testRoute.discipline = "cycling"
        testRoute.rating = 4
        testRoute.name = "First Test Route"
        testRoute.distance = 102
        testRoute.recordTime = 45454
        testRoute.avgTime = 5466543
        testRoute.comment = "It was an awesome route"
        
        testRoute2.id = 1
        testRoute2.discipline = "skating"
        testRoute2.rating = 3
        testRoute2.name = "Second Test Route"
        testRoute2.distance = 200
        testRoute2.recordTime = 4545443543
        testRoute2.avgTime = 5466543453
        testRoute2.comment = "It was an awesome route"

        retrievePath(MapView: MapView)
    }
    
    //wrapper
    func retrievePath(MapView: GMSMapView!) {
        
        //Init: Chunk used for testing
        var locationsArray: [CLLocationCoordinate2D] = []
        var locationsArray2: [CLLocationCoordinate2D] = []
        var routesArray: [[CLLocationCoordinate2D]] = []
        
        
        locationsArray.append(CLLocationCoordinate2D(latitude: 18.488031, longitude: -69.963176))
        locationsArray.append(CLLocationCoordinate2D(latitude: 18.487952, longitude: -69.963170))
        locationsArray.append(CLLocationCoordinate2D(latitude: 18.487548, longitude: -69.963169))
        locationsArray.append(CLLocationCoordinate2D(latitude: 18.487439, longitude: -69.963059))
        
        locationsArray2.append(CLLocationCoordinate2D(latitude: 18.488282, longitude: -69.960865))
        locationsArray2.append(CLLocationCoordinate2D(latitude: 18.488292, longitude: -69.960334))
        locationsArray2.append(CLLocationCoordinate2D(latitude: 18.488352, longitude: -69.960038))
        
        routesArray.append(locationsArray)
        routesArray.append(locationsArray2)
        //End: Chunk used for testing
        
        retrievePath(routesArray, map: MapView, route: testRoute)
        
        retrievePath(routesArray, map: MapView, route: testRoute2)
        
    }
    
    
    private func retrievePath(_ routes: [[CLLocationCoordinate2D]], map MapView: GMSMapView!, route: Route) {
        
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
            setMarker(route: array, map: MapView, routeInfo: route)
            
        }
        
    }
    
    
    private func setMarker(route: [CLLocationCoordinate2D], map MapView: GMSMapView!, routeInfo: Route) {
        
        let initialLocation = route.first!
        let initialMarker = GMSMarker()
        
        //Set the marketTitle equals the routeID
        
  
//        if initialMarker.title == "\(id)" {
            initialMarker.title = "\(routeInfo.id)"
//        }else{
//            initialMarker.title = "0"
//        }
    
        initialMarker.icon = UIImage(named: "pin2")
        initialMarker.position = CLLocationCoordinate2D(latitude:initialLocation.latitude, longitude: initialLocation.longitude)
        initialMarker.map = MapView
        
        
    }
    

    
    
    //This func draw a route, and center the camera map on it
    
    func drawRoute(route: Route, map mapView: GMSMapView){
        
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
    private func drawRoute(_ route: [CLLocationCoordinate2D], map mapView: GMSMapView, routeInfo : Route) {
        
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

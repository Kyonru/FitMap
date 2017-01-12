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
    

    func retrievePath(MapView: GMSMapView!) {
        
        //Init Chunk used for testing
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
        //End Chunk used for testing
        
        retrievePath(routesArray, map: MapView)
        
    }
    
    private func retrievePath(_ routes: [[CLLocationCoordinate2D]], map MapView: GMSMapView!) {
        
        
        for array in routes {
            
            let path = GMSMutablePath()
            var polyline = GMSPolyline()
            
            for route in array {
                
                path.add(route)
                polyline = GMSPolyline(path: path)
            }
            polyline.map = MapView
            setMarker(route: array, map: MapView)
            
        }
        
    }
    
    
    private func setMarker(route: [CLLocationCoordinate2D], map MapView: GMSMapView!) {
        
        let initialLocation = route.first!
        let initialMarker = GMSMarker()
    
        initialMarker.position = CLLocationCoordinate2D(latitude:initialLocation.latitude, longitude: initialLocation.longitude)
        initialMarker.map = MapView

        
    }

}

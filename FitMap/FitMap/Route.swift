//
//  Route.swift
//  FitMap
//
//  Created by Jhonny Bill Mena on 1/13/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import Foundation
import CoreLocation

class Route {
    
    var routeId : Int {
        set(id){
            self.routeId = id
        }
        
        get {
            return self.routeId
        }
    }
    
    var routeName : String {
        
        set(name){
            self.routeName = name
        }
        get{
            return getRouteName(id: self.routeId)
        }
    }
    
    
    var routeDiscipline : String {
        
        set(discipline){
            self.routeDiscipline = discipline
        }
        get{
            return getRouteDiscipline(routeId: self.routeId)
        }
        
    }
    
    
    var routeDistance : Int {
        
        set(distance){
            self.routeDistance = distance
        }
        get{
            return getRouteDistance(routeId: self.routeId)
        }
        
    }
    
    var path: [CLLocationCoordinate2D] {
        
        set(coordinates){
            self.path = coordinates
        }
        get{
            return getRoutePath(routeId: self.routeId)
        }
    }
    
    var recordTime: Int64 {
        set(time){
            self.recordTime = time
        }
        get{
            return getRouteRecordTime(routeId: self.routeId)
        }
    }
    
    var avgTime: Int64 {
        set(time){
            self.recordTime = time
        }
        get{
            return getRouteAverageTime(routeId: self.routeId)
        }
    }
    
    var rating : Int {
        set(val){
            self.rating = val
        }
        get{
            return getRouteRating(routeId: self.routeId)
        }
    }
    
    
    
    
    
    //////////////////////////////////////////////////////////////
    
    
    func getRouteName(id: Int) -> String {
        
        //Query
        
        //DummyValue
        let name = "DummyName"
        
        return name
    }
    
    
    func getRouteDiscipline(routeId: Int) -> String {
        
        //Query
        
        //DummyValue
        let discipline = "Cycling"
        return discipline
    }
    
    func getRouteDistance(routeId: Int) -> Int {
        
        //Query
        
        //DummyValue
        let distance = 64
        return distance
    }
    
    func getRoutePath(routeId: Int) -> [CLLocationCoordinate2D] {
        
        
        //Query to retrieve array from the DB
        
        
        // Dummy
        var locationsArray: [CLLocationCoordinate2D] = []

        locationsArray.append(CLLocationCoordinate2D(latitude: 18.488031, longitude: -69.963176))
        locationsArray.append(CLLocationCoordinate2D(latitude: 18.487952, longitude: -69.963170))
        locationsArray.append(CLLocationCoordinate2D(latitude: 18.487548, longitude: -69.963169))
        locationsArray.append(CLLocationCoordinate2D(latitude: 18.487439, longitude: -69.963059))

        
        return locationsArray
        
    }
    
    func getRouteRecordTime(routeId: Int) -> Int64 {
        
        //Query to retrieve record time from the DB
        
        
        // Dummy
        
        let time: Int64 = 87325917368
        return time
        
    }
    
    func getRouteAverageTime(routeId: Int) -> Int64 {
        
        //Query to retrieve average time from the DB
        
        
        // Dummy
        
        let time: Int64 = 8732591798436983
        return time
        
    }
    
    func getRouteRating(routeId: Int) -> Int {
        
        //Query to retrieve rating from the DB
        
        
        // Dummy
        let rating = 4
        return rating
        
    }

    
    
    
}

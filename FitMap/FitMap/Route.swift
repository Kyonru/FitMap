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
    
    var id = 0
    var discipline = " "
    var name = " "
    var distance = 0.0
    var path : [CLLocationCoordinate2D] = []
    var recordTime: Int64 = 0
    var avgTime: Int64 = 0
    var time: Int64 = 0
    var rating = 0
    var comment = " "
    
    
    
    
    
    
    func setRouteId(id: Int) {
        self.id = id
    }

    func setName(name: String) {
        self.name = name
    }
    func getName(routeId: Int) -> String {
        return getRouteName(id: routeId)
    }
    
    
    func setDiscipline(discipline: String) {
        self.discipline = discipline
    }
    func getDiscipline(routeId: Int) -> String {
        return getRouteDiscipline(routeId: routeId)
    }
    
    
    func setDistance(distance: Double){
        self.distance = distance
    }
    func getDistance(routeId: Int) -> Double {
        return getRouteDistance(routeId: routeId)
    }
    
    
    func setPath(coordinates: CLLocationCoordinate2D) {
        self.path = [coordinates]
    }
    func getPath(routeId: Int) -> [CLLocationCoordinate2D] {
        return getRoutePath(routeId: routeId)
    }
    
    func setRecordTime(record: Int64) {
        self.recordTime = record
    }
    func getRecordTime(routeId: Int) -> Int64 {
        return getRouteRecordTime(routeId: routeId)
    }
    
    
    func setAverageTime(average: Int64) {
        self.avgTime = average
    }
    func getAverageTime(routeId: Int) -> Int64 {
        return getRouteAverageTime(routeId: routeId)
    }
    
    
    func setTime(time: Int64) {
        self.time = time
    }
    func getTime(routeId: Int) -> Int64 {
        return getRouteTime(routeId: routeId)
    }

    
    func setRating(rating: Int) {
        self.rating = rating
    }
    func getRating(routeId: Int) -> Int {
        return getRouteRating(routeId: routeId)
    }
    
    func setCommet(comment: String) {
        self.comment = comment
    }
    func getComment(routeId: Int) -> String {
        return getRouteCommets(routeId: routeId)
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
    
    func getRouteDistance(routeId: Int) -> Double {
        
        //Query
        
        //DummyValue
        let distance = 64.0
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
    
    func getRouteTime(routeId: Int) -> Int64 {
        
        //Query to retrieve average time from the DB
        
        
        // Dummy
        
        let time: Int64 = 87325917984356983
        return time
        
    }

    
    func getRouteRating(routeId: Int) -> Int {
        
        //Query to retrieve rating from the DB
        
        
        // Dummy
        let rating = 4
        return rating
        
    }

    func getRouteCommets(routeId: Int) -> String {
        
        //Query to retrieve all comments
        
        
        //Dummy comment
        let comment = "Awesome route!"
        return comment
        
    }
    
    
    
}

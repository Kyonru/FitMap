//
//  RunSpeedTimeDistance.swift
//  FitMap
//
//  Created by fitmap on 1/16/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import Foundation

class RunSpeedTimeDistance{
    
    var speed: Double = 0.0
    var distance: Double = 0.0
    
    func distance(Distance: Double) -> String{
        return "\(Double(round(1000*Distance)/1000))"
    }
    
    func nanoToSeconds (seconds : Double) -> String {
        
        return printSecondsToHoursMinutesSeconds(seconds: seconds/1000000000)
    }
    
    func secondsToHoursMinutesSeconds (seconds : Double) -> (Int, Int, Int) {
        return (Int(dividir(first: seconds, second:3600.0)), Int(dividir(first: Double(mod(firs:seconds, second:3600.0)),second: 60.0)), Int(mod(firs: seconds, second:  3600) % 60))
    }
    
    func dividir(first: Double, second: Double) -> Double{
        return first/second;
    }
    
    func mod(firs: Double, second:Double) -> Int{
        return Int(firs.truncatingRemainder(dividingBy: second))
    }
    
    func mayorcero(numero: Int) -> String{
        if(numero < 10){
            return "0\(numero)"
        }
        else{
            return "\(numero)"
        }
    }
    
    func printSecondsToHoursMinutesSeconds (seconds: Double) -> String {
        let (h, m, s) = secondsToHoursMinutesSeconds (seconds: seconds)
        return (mayorcero(numero:h) + ":" + mayorcero(numero: m) + ":" + mayorcero(numero: s))
    }
    
}

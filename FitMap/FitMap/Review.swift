//
//  Review.swift
//  FitMap
//
//  Created by Jhonny Bill Mena on 1/21/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import Foundation

class Review {
    
    var userId : Int = 0
    var routeId : Int = 0
    var comment : String = ""
    var rating : Int = 0
    var date: String = ""
    
    func Review(idUser: Int, idRoute: Int, comm: String, rat: Int, dat: String){
        
        self.userId = idUser
        self.routeId = idRoute
        self.comment = comm
        self.rating = rat
        self.date = dat
        
    }
    
    
}

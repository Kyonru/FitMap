//
//  User.swift
//  FitMap
//
//  Created by Jhonny Bill Mena on 1/22/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import Foundation


class User{
    
    var id = 0
    var name = ""
    var lastName = ""
    
    func user(){
        
    }
    
    func User(id: Int, name: String, lastNam: String){
        
        self.id = id
        self.name = name
        self.lastName = lastNam
        
    }
    
    func getId()-> Int{
        return self.id
    }
    
    
}

//
//  UserSaving.swift
//  FitMap
//
//  Created by Jhonny Bill Mena on 1/22/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class UserSaving{
    
    var userObject = User(); // User to save
    
    var userIdOnDataBase = 0
    
    //Obtengo el objeto user, e inserto ese user en la base de datos
    // Obtendo el id que le asigno la base de datos al user
    //guardo ese int en el iphone con core data
    
    @available(iOS 10.0, *)
    func user(user: User) {

        userObject = user
        saveUser(id: userObject.id)
        _ = getUserId()
        
    }
    
    
    
    ///INSERTO EL USER EN LA BASE DE DATOS
    
    // HAGO QUERY PARA OBTENER EL ID DEL USUARIO EN LA BASE DE DATOS
    
    
    //Una vez tengo el id del usuario, guardo ese int en el iphone con CoreData
    

    ///////////
    @available(iOS 10.0, *)
    func saveUser(id: Int) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedObjectContext = appDelegate.managedObjectContext
        
         let context = appDelegate.managedObjectContext
//        let context = getContext()
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "UserData", in: context)
        
        let usr = NSManagedObject(entity: entity!, insertInto: context)
        
        //set the entity values
        usr.setValue(id, forKey: "userID")
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!SAVING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
//        transc.setValue(audioFileUrlString, forKey: "audioFileUrlString")
//        transc.setValue(textFileUrlString, forKey: "textFileUrlString")
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    
    /////////////////////////////////////////////////////////////////////////
    //                         RETRIEVE USER ID                           //
    ////////////////////////////////////////////////////////////////////////
    
    @available(iOS 10.0, *)
    func getUserId() -> Int {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let context = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "UserData", in: context)
        
        let usr = NSManagedObject(entity: entity!, insertInto: context)
        
        
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        
        // Helpers
        var result = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
        
        do {
            // Execute Fetch Request
            let records = try managedObjectContext.fetch(fetchRequest)
            
            if let records = records as? NSManagedObject {
                result = records
            }
            
        } catch {
            print("Unable to fetch managed objects for entity UserData.")
        }
        
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        
        print(result.value(forKey: "userID")!)
        
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        
        
        return (result.value(forKey: "userID")! as! Int)
        
    }
    
    
    
    
}

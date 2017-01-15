//
//  EditarRutaViewController.swift
//  FitMap
//
//  Created by Rafael Suazo on 1/11/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import UIKit
import Cosmos

class EditarRutaViewController: UIViewController {
    
    var route = Route() //Route instance. Object to be stored on DB (passed to the model)
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var starView: CosmosView!
    
    @IBOutlet weak var routeNameTextField: UITextField!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    var discipline = " "
    
    var timeRecorded: Int64 = 0
    var distanceRecorded: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)


        // Do any additional setup after loading the view.
        
        
        //Capturing the rating data
        
        // Called when user finishes changing the rating by lifting the finger from the view.
        // This may be a good place to save the rating in the database or send to the server.
//        cosmosView.didFinishTouchingCosmos = { rating in  //route.rating = x }
        
        
        timeLabel.text =  "\(timeRecorded)"
        distanceLabel.text = "\(distanceRecorded)"
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.bottomConstraint?.constant = 0.0
            } else {
                self.bottomConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    
    @IBAction func disciplineButton(_ sender: UIButton) {
        
        let buttonTouched = sender.currentTitle!
        
        /*
         Pourpose: when a user tap 1 button, we got to query
         the routes based on that category
         */
        
        switch buttonTouched {
        case "Cycling":
//            route.routeDiscipline = "cycling"
           discipline = "cycling"

        case "Running":
//            route.routeDiscipline =  "running"
            discipline = "running"
        case "Skating":
//            route.routeDiscipline =  "skating"
            discipline = "skating"
        default:
//            route.routeDiscipline = ""
            discipline = " "
        }

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func submitAction(_ sender: UIButton) {
        
        if routeNameTextField.text != nil{
//            route.routeName = routeNameTextField.text!
        }
        
        
//        starView.didFinishTouchingCosmos = { rating in self.route.rating = Int(self.starView.rating)}
        //Use a f$%@$ slider to catch review value
        
        route.time = Int64(timeLabel.text!)!
        route.distance = Double(distanceLabel.text!)!
        route.discipline = discipline
       
        // Send this route object to the model, to insert it into the database
        let save = routeSaving()
        save.insertRoute(route: route)
        
        
        self.dismiss(animated: true, completion: nil)

        
    }
    

    func getRouteData(route: Route){
        
        timeRecorded = route.time
        distanceRecorded = route.distance
        
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

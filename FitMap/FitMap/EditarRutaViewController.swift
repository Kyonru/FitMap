//
//  EditarRutaViewController.swift
//  FitMap
//
//  Created by Rafael Suazo on 1/11/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire
import GoogleMaps

class EditarRutaViewController: UIViewController {
    
    var route = Route() //Route instance. Object to be stored on DB (passed to the model)
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var starView: CosmosView!
    
    @IBOutlet weak var routeNameTextField: UITextField!
    
    @IBOutlet weak var cyclingButton: UIButton!
    @IBOutlet weak var runningButton: UIButton!
    @IBOutlet weak var skatingButton: UIButton!
    
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!

    
    @IBOutlet weak var routeCommentTextField: UITextField!
    
    var myPoints : [CLLocation] = []
    var discipline = ""
    
    var timeRecorded: Int64 = 0
    var distanceRecorded: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)


        // Do any additional setup after loading the view.
        
        
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
        
        let buttonTouched = sender.currentImage!
        
        
        
        /*
         Pourpose: when a user tap 1 button, we got to query
         the routes based on that category
         */
        
        switch buttonTouched {
        case UIImage(named: "bicycle")!:
            cyclingButton.setImage(UIImage(named: "bici-selected"), for: .normal)
            runningButton.setImage(UIImage(named: "icon"), for: .normal)
            skatingButton.setImage(UIImage(named: "skateboard-2"), for: .normal)
            
            discipline = "cycling"
            
        case UIImage(named: "icon")!:
            cyclingButton.setImage(UIImage(named: "bicycle"), for: .normal)
            runningButton.setImage(UIImage(named: "run-selected"), for: .normal)
            skatingButton.setImage(UIImage(named: "skateboard-2"), for: .normal)
            
            discipline = "running"
        case UIImage(named: "skateboard-2")!:
            cyclingButton.setImage(UIImage(named: "bicycle"), for: .normal)
            runningButton.setImage(UIImage(named: "icon"), for: .normal)
            skatingButton.setImage(UIImage(named: "skate-selected"), for: .normal)
            
            discipline = "skating"
        default:
            discipline = ""
        }
        

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func submitAction(_ sender: UIButton) {

        if routeNameTextField.text != nil{
            route.name = routeNameTextField.text!
        }
        
        route.discipline = self.discipline
        route.rating = Int(starView.rating)
        route.time = Int64(timeLabel.text!)!
        route.distance = Double(distanceLabel.text!)!
        
        if routeCommentTextField.text != nil {
            route.comment = routeCommentTextField.text!
        }
        
        // Send this route object to the model, to insert it into the database
        let save = routeSaving()
        save.insertRoute(route: route)

        //Hay que anadir el id del user
        let parameters: Parameters = [
            "idUser": "\(46)",
            "name": "\(route.name)",
            "time": "\(route.time)",
            "rating": "\(route.rating)",
            "comment": "\(route.comment)",
            "discipline": "\(route.discipline)"
        ]
        
        
        let urlString = "http://0.0.0.0:80/api/v1/routes/"
        
        _ = Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON(completionHandler:{            Respuesta in
            print("\(Respuesta.result.value)")
            
            DispatchQueue.main.async {
                            self.route.id = Int((String("\(Respuesta)")?.replacingOccurrences(of: "SUCCESS: ", with: ""))!)!
                            self.insertPoints()
            }

            
            } )

        self.dismiss(animated: true, completion: nil)

    }
    

    
    
    func getRouteData(route: Route){
        
        timeRecorded = route.time
        distanceRecorded = route.distance
        
    }
    
    func getPoints(trackedLocations: [CLLocation]){
        myPoints = trackedLocations
    }
    
    func insertPoints(){
        for point in myPoints{
            let parp: Parameters = [
                "idRoute": "\(route.id)",
                "longitude": "\(point.coordinate.longitude)",
                "latitude": "\(point.coordinate.latitude)"
            ]
            _ = Alamofire.request("http://0.0.0.0:80/api/v1/points/",method: .post, parameters: parp)
            
        }
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

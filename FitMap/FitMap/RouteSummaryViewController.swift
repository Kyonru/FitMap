//
//  RouteSummaryViewController.swift
//  FitMap
//
//  Created by fitmap on 1/11/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import UIKit
import Cosmos

class RouteSummaryViewController: UIViewController {

    @IBOutlet weak var starView: CosmosView! //Missing method for data capture from stars
    
     var route = Route() //Route instance. Object to be stored on DB (passed to the model)
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var timeRecorded: Int64 = 0
    var distanceRecorded: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        timeLabel.text =  "\(timeRecorded)"
        distanceLabel.text = "\(distanceRecorded)"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func submitButton(_ sender: UIButton) {
//        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "DetalleRuta", bundle:nil)
//        
//        let prevViewController = storyBoard.instantiateViewController(withIdentifier: "RunViewController") as! RunViewController
//        
//        prevViewController.dismiss(animated: true, completion: nil)
        
        self.dismiss(animated: true, completion: nil)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "DetalleRuta", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    
        
        navigationController?.pushViewController(nextViewController, animated: true)
//        self.present(nextViewController, animated:true, completion:nil)
    
        
        
        
        
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

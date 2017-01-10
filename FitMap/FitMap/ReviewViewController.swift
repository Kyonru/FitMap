//
//  ReviewViewController.swift
//  FitMap
//
//  Created by fitmap on 1/10/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import UIKit
import Cosmos

class ReviewViewController: UIViewController{

    @IBOutlet weak var starView: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        starView.settings.updateOnTouch = false
        
        starView.rating = 4
        
        starView.didFinishTouchingCosmos { }
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

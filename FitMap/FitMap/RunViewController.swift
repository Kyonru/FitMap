//
//  RunViewController.swift
//  FitMap
//
//  Created by fitmap on 1/11/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import UIKit

class RunViewController: UIViewController {

    @IBOutlet weak var doRouteButton: UIButton!
    
    @IBOutlet weak var doneRouteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        doRouteButton.isHidden = false
        doneRouteButton.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "DetalleRuta", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RouteSummaryViewController") as! RouteSummaryViewController
        self.present(nextViewController, animated:true, completion:nil)
        
    }

    @IBAction func doButton(_ sender: UIButton) {
        doneRouteButton.isHidden = false
        doRouteButton.isHidden = true
        
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

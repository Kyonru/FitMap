//
//  LaunchViewController.swift
//  FitMap
//
//  Created by Jhonny Bill Mena on 1/22/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        doneButton.isHidden = true
//        nextButton.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        
//        self.dismiss(animated: true, completion: nil)
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "LaunchScreenStoryboard", bundle:nil)
//        let launchViewController = storyBoard.instantiateViewController(withIdentifier: "LaunchViewController") as! LaunchViewController
//        self.navigationController?.pushViewController(launchViewController, animated: true)
        
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "DetalleRuta", bundle:nil)
        let launchRutaViewController = storyBoard.instantiateViewController(withIdentifier: "LaunchViewController2") as! LaunchViewController
        
        self.present(launchRutaViewController, animated:true, completion:nil)
        
//            self.navigationController?.pushViewController(launchRutaViewController, animated: true)
        
//        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        //Cierro todo esto
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "LaunchScreen", bundle:nil)
        
        
        self.dismiss(animated: true, completion: nil)
        
//        doneButton.isHidden = false
//        nextButton.isHidden = true
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "DetalleRuta", bundle:nil)
        let detalleRutaViewController = storyBoard.instantiateViewController(withIdentifier: "DetalleRutaViewController") as! DetalleRutaViewController
        
        //
//        let storyBoard2 : UIStoryboard = UIStoryboard(name: "DetalleRuta", bundle:nil)
//        let launchViewController = storyBoard2.instantiateViewController(withIdentifier: "LaunchViewController") as! LaunchViewController
//        
//            launchViewController.navigationController?.dismiss(animated: true, completion: nil)
//        
        self.navigationController?.pushViewController(detalleRutaViewController, animated: true)

    
    }
    
    
    @IBAction func doneButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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

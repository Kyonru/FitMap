//
//  LaunchViewController.swift
//  FitMap
//
//  Created by Jhonny Bill Mena on 1/22/17.
//  Copyright © 2017 FormuladoresDiscretos. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var user = User();
    override func viewDidLoad() {
        super.viewDidLoad()
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        


        // Do any additional setup after loading the view.
  
//        self.nextButton.isHidden = false
//        
//        self.doneButton.isHidden = true
    
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func nextButtonAction(_ sender: Any) {
   
        let storyBoard : UIStoryboard = UIStoryboard(name: "DetalleRuta", bundle:nil)
        let launchRutaViewController = storyBoard.instantiateViewController(withIdentifier: "LaunchViewController2") as! LaunchViewController
        
        self.present(launchRutaViewController, animated:true, completion:nil)
     }


    
    @available(iOS 10.0, *)
    @IBAction func registerButton(_ sender: AnyObject) {
        
//        //
//        doneButton.isHidden = false
//        nextButton.isHidden = true
        
        //Capturing first and last name
        let firstName = "Rafael"
        let lastName = "Suazo"
        
        user.User(id: 0, name: firstName, lastNam: lastName)
        
        //Send this user object to the UserSaving moddel
        let saving = UserSaving();
        saving.user(user: user)
        
        
        
        self.dismiss(animated: true, completion: nil)
        
        //        doneButton.isHidden = false
        //        nextButton.isHidden = true
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "DetalleRuta", bundle:nil)
        let detalleRutaViewController = storyBoard.instantiateViewController(withIdentifier: "DetalleRutaViewController") as! DetalleRutaViewController
       
        //
//        doneButton.isHidden = false
//        nextButton.isHidden = true
        self.navigationController?.pushViewController(detalleRutaViewController, animated: true)
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

 
    @IBAction func doneButtonAction(_ sender: UIButton) {
    
        self.dismiss(animated: true, completion: nil)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch textField.tag {
            
        case 0:
            
            print ("do nothing")
            
        default:
            
            scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
            
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        scrollView.setContentOffset(CGPoint(x: 0, y:0), animated: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == 0{
            
            firstNameTextField.becomeFirstResponder()
            
        }else if textField.tag == 1 {
            
            lastNameTextField.becomeFirstResponder()
            
        }
        
        return true
        
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



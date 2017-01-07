//
//  LoopViewController.swift
//  FitMap
//
//  Created by fitmap on 12/13/16.
//  Copyright © 2016 FormuladoresDiscretos. All rights reserved.
//

import UIKit

class LoopViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    @IBOutlet weak var KilometersPicker: UIPickerView!  //Second Picker, which is for the Kilometers
    private var pickerDataKilometers: [[Int]] = [[Int]]()           //DataArray for the Kilometers
   
      override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        
        
        //Data for the pickers
        for j in 0...1{
            var columnaDatos: [Int] = [Int]()
            if(j == 0){
                var k = 0
                while k <= 500{
                    columnaDatos.append(k)
                    k += 5
                }
            }
            else{
                var k = 0
                while k <= 750{
                    columnaDatos.append(k)
                    k += 250
                }
            }
            pickerDataKilometers.append(columnaDatos)
        }
        
        
        //Connecting the pickers
        //Making this view controler as the delegate(o sea, this is the controller which is going to implement the methods,)
        // and also we make this is the controller which going to provide the data, i think so, as to Abraham for more information
        self.KilometersPicker.delegate = self
        self.KilometersPicker.dataSource = self
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerDataKilometers.count
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataKilometers[component].count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerDataKilometers[component][row])"
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    
    
    
    @IBAction func fooAction(_ sender: AnyObject) {
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

//
//  DoubleComponentPickerViewController.swift
//  Picker
//
//  Created by Emily on 2/19/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import UIKit

class DoubleComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var doublePicker: UIPickerView!
    private let fillingComponent = 0
    private let breadComponent = 1
    private let fillingTypes = ["Ham", "Turkey", "Peanut Butter", "Tuna Salad", "Chicken Salad", "Roast Beef", "Vegemite"]
    private let breadTypes = ["White", "Whole Wheat", "Rye", "Sourdough", "Seven Grain"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let fillingRow = doublePicker.selectedRow(inComponent: fillingComponent)
        let breadRow = doublePicker.selectedRow(inComponent: breadComponent)
        
        let filling = fillingTypes[fillingRow]
        let bread = breadTypes[breadRow]
        let massage = "Your \(filling) in \(bread) bread well be right up."
        
        let alert = UIAlertController(title:"Thank you for your order", message: massage, preferredStyle: .alert)
        let action = UIAlertAction(title:"Great", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == breadComponent){
            return breadTypes.count
        }else{
            return fillingTypes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == breadComponent){
            return breadTypes[row]
        }else{
            return fillingTypes[row]
        }
    }

}

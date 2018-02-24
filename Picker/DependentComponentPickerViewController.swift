//
//  DependentComponentPickerViewController.swift
//  Picker
//
//  Created by Emily on 2/19/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import UIKit

class DependentComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var dependentPicker: UIPickerView!
    private let stateComponent = 0
    private let zipComponent = 1
    private var stateZips:[String:[String]]!
    private var states:[String]!
    private var zips:[String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = Bundle.main
        let plistURL = bundle.url(forResource: "statedictionary", withExtension: "plist")
        stateZips = NSDictionary.init(contentsOf: (plistURL)!) as! [String: [String]]
        let allStates = stateZips.keys
        states = allStates.sorted()
        let selctedState = states[0]
        zips = stateZips[selctedState]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let stateRow = dependentPicker.selectedRow(inComponent: stateComponent)
        let zipRow = dependentPicker.selectedRow(inComponent: zipComponent)
        let state = states[stateRow]
        let zip = zips[zipRow]
        
        let title = "You selcected zip code \(zip)"
        let masseage = "\(zip) is in \(state)"
        let alert = UIAlertController(title: title, message: masseage, preferredStyle: .alert)
        let action = UIAlertAction(title:"OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == stateComponent) {
            return states.count
        }else{
            return zips.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == stateComponent){
            return states[row]
        }else{
            return zips[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if(component == stateComponent){
            let selectedState = states[row]
            zips = stateZips[selectedState]
            dependentPicker.reloadComponent(zipComponent)
            dependentPicker.selectRow(0, inComponent: zipComponent, animated: true)
        }
    }
    
    internal func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let pickerWidth = pickerView.bounds.size.width
        if(component == zipComponent){
            return pickerWidth/3
        }else{
            return 2 * pickerWidth / 3
        }
    }

}

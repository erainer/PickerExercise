//
//  CustomPickerViewController.swift
//  Picker
//
//  Created by Emily on 2/19/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import UIKit
import AVFoundation

class CustomPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private var images:[UIImage]!

    @IBOutlet weak var winLabel: UILabel!
    
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var customPicker: UIPickerView!
    
    private var winSound = AVAudioPlayer()
    private var crunchSound = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        images = [UIImage(named: "seven")!, UIImage(named: "bar")!, UIImage(named: "crown")!, UIImage(named: "cherry")!, UIImage(named: "lemon")!, UIImage(named: "apple")!]
        
        winLabel.text = " "
        arc4random_stir()
        
        do{
            try winSound = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "win", ofType: "wav")!) as URL)
            
        } catch{
            NSLog("Error sounds aren't working")
        }
        do{
            try crunchSound = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "crunch", ofType: "wav")!) as URL)
            
        } catch{
            NSLog("Error sounds aren't working")
        }
    }
    
    @IBAction func onbuttonPressed(_ sender: UIButton) {
        var win = false
        var numInRow = -1
        var lastVal = -1
        crunchSound.play()
        for i in 0..<5{
            let newValue = Int(arc4random_uniform(UInt32(images.count)))
            if(newValue == lastVal){
                numInRow += 1
            }else{
                numInRow = 1
            }
            lastVal = newValue
            
            customPicker.selectRow(newValue, inComponent: i, animated: true)
            customPicker.reloadComponent(i)
            
            if(numInRow >= 3){
                win = true
            }
        }
        
        
        
        if(win){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.winSound.play()
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showButton()
        }
            winLabel.text = " "
        }
        
        winLabel.text = win ? "WINNER!":" "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let image = images[row]
        let imageView = UIImageView(image:image)
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return 64
    }
    
    func showButton(){
        spinButton.isHidden = false
    }

}

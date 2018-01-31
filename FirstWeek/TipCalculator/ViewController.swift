//
//  ViewController.swift
//  TipCalculator
//
//  Created by Stan on 2018-01-31.
//  Copyright © 2018 stan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputTF: UITextField!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var priceLbael: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var tipSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func inputTFChangeValue(_ sender: UITextField) {
        updateData(tipSlider)
    }
    
    @IBAction func changeSliderValue(_ sender: UISlider) {
        updateData(sender)
    }
    
    fileprivate func updateData(_ slider: UISlider) {
        let tipPercent = slider.value * 100
        
        let inputNumber = NSDecimalNumber(string: inputTF.text)
        
        let tipPrice = (inputNumber.floatValue * tipPercent) / 100
        
        percentLabel.text = "Tip %" + String.init(format: "%.2f", tipPercent)
        priceLbael.text = "$" + String.init(format: "%.2f", tipPrice)
        totalPriceLabel.text = "$" + String.init(format: "%.2f", tipPrice + inputNumber.floatValue)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


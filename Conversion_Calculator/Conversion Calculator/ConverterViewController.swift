//
//  ConverterViewController.swift
//  Conversion Calculator
//
//  Created by Chris Rehagen on 10/25/18.
//  Copyright © 2018 Chris Rehagen. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    
    
    //globals
    var enteredNumber: String = ""
    var negativeNumber = false
    var decimal = false
    
    
    
    struct Converter {
        let label: ConverterType

        let inputUnit: String
        let outputUnit: String

    }

    
    //make strings
    enum ConverterType: String {
        case fahrenheitToCelsius = "Fahrenheit to Celsius"
        case celsiusToFahrenheit = "Celsius to Fahrenheit"
        case kilometersToMiles = "Kilometers to Miles"
        case milesToKilometers = "Miles to Kilometers"
    }
    
    
    
    //action sheet
    var option: Converter = Converter(label: ConverterType.fahrenheitToCelsius, inputUnit: "°F", outputUnit: "°C")
    
    let converterArray = [Converter(label: ConverterType.fahrenheitToCelsius, inputUnit: "°F", outputUnit: "°C"),
                          Converter(label: ConverterType.celsiusToFahrenheit, inputUnit: "°C", outputUnit: "°F"),
                          Converter(label: ConverterType.milesToKilometers, inputUnit: "mi", outputUnit: "km"),
                          Converter(label: ConverterType.kilometersToMiles, inputUnit: "km", outputUnit: "mi")]
    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for converter in converterArray {
            actionSheet.addAction(UIAlertAction(title: converter.label.rawValue, style: .default, handler: { (_) in
                self.option = converter
                
                self.convert()
            }))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // enters numbers 0-9
    @IBAction func numberButtons(_ sender: UIButton) {
        enteredNumber += String(sender.tag)
        convert()
    }
    
    
    // pulls up action sheet
    @IBAction func converterButton(_ sender: Any) {
        self.present(actionSheet, animated: true, completion: nil)
        outputDisplay.text = option.outputUnit
        inputDisplay.text = option.inputUnit
    }
    
    
    // clears text fields
    @IBAction func clearButton(_ sender: Any) {
        
        //        outputDisplay.text = ""
        //        inputDisplay.text = ""
        
        outputDisplay.text = option.outputUnit
        enteredNumber = ""
        inputDisplay.text = option.inputUnit
    }
    
    
    // makes input number negative
    @IBAction func positiveNegativeButton(_ sender: Any) {
        if !enteredNumber.isEmpty {
            
            if !negativeNumber{
                
                negativeNumber = true
                enteredNumber = "-" + enteredNumber
            } else {
                
                negativeNumber = false
            }
            convert()
        }
    }
    
    //adds deciaml
    @IBAction func decimalButton(_ sender: Any) {
        if !enteredNumber.contains("."){                //only 1 decimal can be added
        
            if decimal {
                
                return
            }
            else{
                
                enteredNumber += "."
                
                decimal = true
                convert()
                decimal = false
            }
        }
    }
    
    
    func convert() {
        inputDisplay.text = enteredNumber + option.inputUnit
        outputDisplay.text = option.outputUnit
        
        guard let preConvert = Double(enteredNumber)
            else {
                
                return
        }
        var postConvert: Double? = nil
        
        switch option.label {
            
            case .fahrenheitToCelsius: postConvert = (preConvert - 32) * 5/9
            case .celsiusToFahrenheit: postConvert = (preConvert * 9/5) + 32
            case .milesToKilometers: postConvert = (preConvert / 0.62137)
            case .kilometersToMiles: postConvert = (preConvert * 0.62137)
            
        }
        
        outputDisplay.text = String(postConvert!) + option.outputUnit
        }
        
    }



    //////////////////////
    


//
//    @IBAction func numbers(_ sender: UIButton) {
//        inputDisplay.text = inputDisplay.text! + String(sender.tag)
//
//        let inputValue = Double(inputDisplay.text!)
//
//        let outputValue = (inputValue! - 32) * 5/9 // F -> C
//        //print(outputValue)
//
//        outputDisplay.text = String(outputValue)
//
//    }
//
//    @IBAction func buttonPressed(_ sender: Any) {
//        print("converter button pressed")
//        inputDisplay.text = ""
//
//
//    let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
//
//
//        alert.addAction(UIAlertAction(title: "Fahrenheit to Celcius", style: UIAlertAction.Style.default, handler: {
//            (alertAction) -> Void in
//
//
//
//
////            self.inputDisplay.text = String("°F")
////            self.outputDisplay.text = String("°C")
//
//            self.inputDisplay.text = self.inputDisplay.text
//            self.outputDisplay.text = self.outputDisplay.text
//
//        }))
//
//
//        alert.addAction(UIAlertAction(title: "Celcius to Fahrenheit", style: UIAlertAction.Style.default, handler: {
//            (alertAction) -> Void in
//
//
//
////            self.inputDisplay.text = String("°C")
////            self.outputDisplay.text = String("°F")
//
//
//
//        }))
//
//
//        alert.addAction(UIAlertAction(title: "Miles to Kilometers", style: UIAlertAction.Style.default, handler: {
//            (alertAction) -> Void in
//
//            self.inputDisplay.text = String("mi")
//            self.outputDisplay.text = String("km")
//
//        }))
//        alert.addAction(UIAlertAction(title: "Kilometers to Miles", style: UIAlertAction.Style.default, handler: {
//            (alertAction) -> Void in
//
//
//            self.inputDisplay.text = String("km")
//            self.outputDisplay.text = String("mi")
//        }))
//
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//
//        self.present(alert, animated: true, completion: nil)
//    }

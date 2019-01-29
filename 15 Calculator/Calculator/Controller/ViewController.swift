//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var isFinishedTypingNumber: Bool = true
    
    private var calculator = CalculatorLogic()
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!)
                else {
                    fatalError("Couldn't cast display label number.")
            }
            
            return number
        }
        set {
            displayLabel.text = String(newValue)
        }
    }

    @IBOutlet weak var displayLabel: UILabel!
    
    
    // MARK: - Handlers
    // Handler for all non-number keys
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
            
        }
    }

    
    // Handler for numbers 0-9 and .
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if let numValue = sender.currentTitle {
            
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            }
            else {
                
                if numValue == "." {

                    let isInt = floor(displayValue) == displayValue
                    
                    // Don't add a decimal if there already is one.
                    if !isInt {
                        return
                    }
                        
                    // Only allow one decimal
                    else if displayLabel.text!.contains(".") {
                        return
                    }
                }
                
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }

}


//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Kevin Jackson on 1/28/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    private var number: Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    mutating func calculate(symbol: String) -> Double? {
        
        if let number = number {
            if symbol == "AC" {
                return 0
            }
            else if symbol == "+/-" {
                return number * -1
            }
            else if symbol == "%" {
                return number / 100
            }
            else if symbol == "=" {
                return performTwoNumberCalculation(n2: number)
            }
            else {
                intermediateCalculation = (n1: number, calcMethod: symbol)
            }
        }
        
        return nil
    }
    
    private func performTwoNumberCalculation(n2: Double) -> Double? {
        
        if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.calcMethod {
            
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "×":
                return n1 * n2
            case "÷":
                return n1 / n2
            default:
                fatalError("Unknown operation.")
            }
        }
        
        return nil
    }
    
}

//
//  ViewController.swift
//  Calculator
//
//  Created by Stasiek Abyszkin on 28/01/16.
//  Copyright © 2016 Stasiek Abyszkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    var dotUsed: Bool = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit

        }
        else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    @IBAction func appendSpecialSymbol(sender: UIButton) {
        let symbol = sender.currentTitle!
        switch symbol {
        case "Π":
            display.text = M_PI.description
            enter()
        default:
            display.text = "Error"
        }
    }
    
    @IBAction func appendDot() {
        if !dotUsed {
            display.text = display.text! + "."
            dotUsaed = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            }else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        dotUsed = false
        
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        }else {
            displayValue = 0
        }

    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}


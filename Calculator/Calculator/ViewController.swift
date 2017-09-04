//
//  ViewController.swift
//  Calculator
//
//  Created by Asmita Gosavi on 5/10/17.
//  Copyright © 2017 Asmita Gosavi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet private weak var display: UILabel!
    
    private var  userIsInTheMiddleOfTyping = false
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle
        if userIsInTheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit!
            
            //        print("touched \(digit ?? "")")
        }
        else {
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
        
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
        
    }
    
    private var mind = CalculatorMind()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            mind.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        
        if  let mathematicalSymbol = sender.currentTitle{
            
            
            mind.performOperation(symbol: mathematicalSymbol)

            //            if mathematicalSymbol == "π"{
            //                displayValue = M_PI
            //                //self.display.text = String(Double.pi)
            //
            //            } else if mathematicalSymbol == "✔️" {
            //                displayValue = sqrt(displayValue)
            //            }
            
        }
        displayValue = mind.result
        
        
    }
    
    
    
    
    
    
    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        // Do any additional setup after loading the view, typically from a nib.
    //    }
    //
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }
    
    
}


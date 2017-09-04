//
//  CalculatorMind.swift
//  Calculator
//
//  Created by Asmita Gosavi on 5/16/17.
//  Copyright © 2017 Asmita Gosavi. All rights reserved.
//

import Foundation

func multiply(op1: Double,op2: Double) -> Double{
    return op1 * op2
}

class CalculatorMind{
    
    private  var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    private  var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(.pi),
        "e" : Operation.Constant(M_E),
        "AC" : Operation.Constant(0.0),
        "±" : Operation.UnaryOperation({ -$0 }),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "sin" : Operation.UnaryOperation(sin),
        "ln" : Operation.UnaryOperation(log),
        "%" : Operation.BinaryOperation({$0.truncatingRemainder(dividingBy: $1)}),
        "×" : Operation.BinaryOperation({ $0 * $1}),
        "+" : Operation.BinaryOperation({ $0 + $1}),
        "−" : Operation.BinaryOperation({ $0 - $1}),
        "÷" : Operation.BinaryOperation({ $0 / $1}),
        "=" : Operation.Equals
    ]
    
    //enum discrete set of values
    // Pass by Value
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String) {
        if  let operation = operations[symbol]{
            switch operation {
            case .Constant(let associatedConstantVale): accumulator = associatedConstantVale
            case .UnaryOperation(let associatedfunction): accumulator = associatedfunction(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals: executePendingBinaryOperation()
                
            }
        }
        
        //        switch symbol {
        //        case "π": accumulator = .pi
        //        case "√": accumulator = sqrt(accumulator)
        //        default:break
        //        }
    }
    
    private func executePendingBinaryOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction : (Double, Double) -> Double
        var firstOperand : Double
    }
    
    
    var result: Double {
        get {
            return accumulator
        }
        
    }
    
}

//
//  ViewController.swift
//  Calculator
//
//  Created by Ayca Akman on 21.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var AClabel: UIButton!
    
    var newOperation = true
    var number1: Double?
    var operation: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func addedNumber(number: String) {
        var inputNumber = String(resultLabel.text!)
        if newOperation {
            inputNumber = ""
            newOperation = false
        }
        inputNumber = inputNumber + number
        resultLabel.text = inputNumber
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        AClabel.titleLabel!.text = "C"
        let currentButtonTitle = sender.titleLabel!.text
        //print(currentButtonTitle!)
        
        if let number = Int(currentButtonTitle!) {
            addedNumber(number: "\(number)")
        } else {
            switch currentButtonTitle {
            case "x", "-", "+", "÷":
                operation = currentButtonTitle == "x" ? "*" : currentButtonTitle
                number1 = Double(resultLabel.text!)
                newOperation = true
            case "AC", "C":
                resultLabel.text = "0"
                newOperation = true
            case "+/-":
                let textNumber = String(resultLabel.text!)
                resultLabel.text = "-\(textNumber)"
            case "%":
                let number = Double(resultLabel.text!)! / 100.0
                resultLabel.text = String(number)
                newOperation = true
            case ",":
                addedNumber(number: ".")
            default:
                print("error")
            }
        }
        
    }
    
    
    func calculatedResult(number1: Double, number2: Double, operation: String) -> Double? {
        switch operation {
        case "*":
            return number1 * number2
        case "÷":
            return number2 == 0.0 ? nil : number1 / number2
        case "-":
            return number1 - number2
        case "+":
            return number1 + number2
        default:
            return nil
        }
    }
    
    
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        let number2 = Double(resultLabel.text!)
        
        if let result = calculatedResult(number1: number1!, number2: number2!, operation: operation!) {
            if result.truncatingRemainder(dividingBy: 1) == 0 {  //3.0 -> 3
                resultLabel.text = String(format: "%.0f", result)
            } else {
                //This helps to round the result to the desired format and remove consecutive zeros.
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.maximumFractionDigits = 10
                formatter.minimumFractionDigits = 0
                formatter.roundingMode = .halfUp
                
                resultLabel.text = formatter.string(from: NSNumber(value: result))
            }
        } else {
            resultLabel.text = "Error"
        }
        
        newOperation = true
        
    }
    
}







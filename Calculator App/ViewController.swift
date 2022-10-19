//
//  ViewController.swift
//  Calculator App
//
//  Created by Shahzaib Mumtaz on 24/02/2022.
//

import UIKit

class ViewController: UIViewController
{
    //************************************************//
    // MARK:- Creating Outlets.
    //************************************************//
    
    @IBOutlet weak var value: UILabel!
    @IBOutlet var numberButtonCollection: [UIButton]!
    @IBOutlet weak var divideMinus: UIButton!
    @IBOutlet weak var percentage: UIButton!
    @IBOutlet weak var divide: UIButton!
    @IBOutlet weak var multiply: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var equal: UIButton!
    
    //************************************************//
    // MARK: Creating properties.
    //************************************************//
    
    var numbersOnScreen = ""
    var previousNumber = ""
    var performOperation = false
    var operation = 0
    
    var val = ""
    var index = 0
    var count = 0
    
    var calculationArray = [String]()
    
    //************************************************//
    // MARK:- View life Cycle
    //************************************************//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        divideMinus.layer.cornerRadius = divideMinus.frame.size.height / 2
        percentage.layer.cornerRadius = percentage.frame.size.height / 2
        divide.layer.cornerRadius = divide.frame.size.height / 2
        multiply.layer.cornerRadius = multiply.frame.size.height / 2
        minus.layer.cornerRadius = minus.frame.size.height / 2
        plus.layer.cornerRadius = plus.frame.size.height / 2
        equal.layer.cornerRadius = equal.frame.size.height / 2
        
        for item in numberButtonCollection{
            item.layer.cornerRadius = item.frame.size.height / 2
        }
        
        value.text = "0"
        previousNumber = "0"
        numbersOnScreen = "0"
        operation = 0
        
        plus.titleLabel?.textColor = .white
        minus.titleLabel?.textColor = .white
        multiply.titleLabel?.textColor = .white
        divide.titleLabel?.textColor = .white
    }
    
    //************************************************//
    // MARK:- Custom methods, IBActions.
    //************************************************//
    
    @IBAction func buttonNumbers(_ sender: UIButton) {
        
        divide.backgroundColor = .orange
        multiply.backgroundColor = .orange
        minus.backgroundColor = .orange
        plus.backgroundColor = .orange
        equal.backgroundColor = .orange
        
        divide.isPointerInteractionEnabled = true
        multiply.isPointerInteractionEnabled = true
        minus.isPointerInteractionEnabled = true
        plus.isPointerInteractionEnabled = true
        equal.isPointerInteractionEnabled = true
        
        plus.titleLabel?.textColor = .white
        minus.titleLabel?.textColor = .white
        multiply.titleLabel?.textColor = .white
        divide.titleLabel?.textColor = .white
        
        if performOperation == true
        {
            value.text = String(sender.tag-1)
            val = value.text ?? "0"
            numbersOnScreen = val
            print("Current Number: \(numbersOnScreen)")
            calculationArray.append(numbersOnScreen)
            
            calculate(previous: previousNumber, screenNumber: numbersOnScreen)
            
            performOperation = false
        }
        
        else
        {
            value.text = ""
            value.text = value.text! + String(sender.tag-1)
            val = value.text ?? "0"
            numbersOnScreen = val
            calculationArray.append(numbersOnScreen)
            print("Current Number: \(numbersOnScreen)")
        }
    }
    
    //************************************************//
    
    @IBAction func buttonOperators(_ sender: UIButton) {
        
        if value.text != nil && sender.tag != 11 && sender.tag != 16
        {
            
            if value.text == "-" || value.text == "+" || value.text == "*" || value.text == "/" {
                print("Operater in label")
            }
            
            else
            {
                previousNumber = value.text ?? "0"
                print("Previous: \(previousNumber)")
            }
            
            if sender.tag == 12 // Divide
            {
                value.text = ""
                value.text = "/"
                calculationArray.append(value.text!)
                
                plus.backgroundColor = .orange
                minus.backgroundColor = .orange
                multiply.backgroundColor = .orange
                divide.backgroundColor = .white
                
                plus.titleLabel?.textColor = .white
                minus.titleLabel?.textColor = .white
                multiply.titleLabel?.textColor = .white
                divide.titleLabel?.textColor = .gray
                
            }
            
            else if sender.tag == 13 // Multiply
            {
                value.text = ""
                value.text = "*"
                
                calculationArray.append(value.text!)
                
                plus.backgroundColor = .orange
                minus.backgroundColor = .orange
                multiply.backgroundColor = .white
                divide.backgroundColor = .orange
                
                plus.titleLabel?.textColor = .white
                minus.titleLabel?.textColor = .white
                multiply.titleLabel?.textColor = .gray
                divide.titleLabel?.textColor = .white
            }
            
            else if sender.tag == 14 // Minus
            {
                value.text = ""
                value.text = "-"
                
                calculationArray.append(value.text!)
                
                plus.backgroundColor = .orange
                minus.backgroundColor = .white
                multiply.backgroundColor = .orange
                divide.backgroundColor = .orange
                
                plus.titleLabel?.textColor = .white
                minus.titleLabel?.textColor = .gray
                multiply.titleLabel?.textColor = .white
                divide.titleLabel?.textColor = .white
            }
            
            else if sender.tag == 15 // Plus
            {
                value.text = ""
                value.text = "+"
                
                plus.backgroundColor = .white
                minus.backgroundColor = .orange
                multiply.backgroundColor = .orange
                divide.backgroundColor = .orange
                
                plus.titleLabel?.textColor = .gray
                minus.titleLabel?.textColor = .white
                multiply.titleLabel?.textColor = .white
                divide.titleLabel?.textColor = .white
                
                calculationArray.append(value.text!)
            }
            
            operation = sender.tag
            performOperation = true
        }
        
        else if sender.tag == 16 // Equal to
        {
            calculate(previous: previousNumber, screenNumber: numbersOnScreen)
        }
    }
    
    //************************************************//
    
    // Mark:- Calculate Method.
    
    func calculate(previous:String, screenNumber:String) {
        
        if operation == 12
        {
            if let p = Int(previousNumber),
               let n = Int(numbersOnScreen) {
                
                let total = p/n
                value.text = String(total)
                
                count = calculationArray.count
                index = count
                
            } else {
                print("Error while Dividing")
            }
        }
        else if operation == 13
        {
            if let p = Int(previousNumber),
               let n = Int(numbersOnScreen) {
                
                let total = p*n
                value.text = String(total)
                
                count = calculationArray.count
                index = count
                
            } else {
                print("Error while Multiplying")
            }
        }
        
        else if operation == 14
        {
            if let p = Int(previousNumber),
               let n = Int(numbersOnScreen) {
                
                let total = p-n
                value.text = String(total)
                
                count = calculationArray.count
                index = count
                
            } else {
                print("Error while Subtracting")
            }
        }
        
        else if operation == 15
        {
            if let p = Int(previousNumber),
               let n = Int(numbersOnScreen) {
                
                let total = p+n
                value.text = String(total)
                
                count = calculationArray.count
                index = count
                
            } else {
                print("Error while Adding")
            }
        }
    }
    
    //************************************************//
    
    @IBAction func buttonClearScreen(_ sender: Any) {
        
        divide.isPointerInteractionEnabled = true
        multiply.isPointerInteractionEnabled = true
        minus.isPointerInteractionEnabled = true
        plus.isPointerInteractionEnabled = true
        equal.isPointerInteractionEnabled = true
        
        value.text = "0"
        previousNumber = "0"
        numbersOnScreen = "0"
        operation = 0
        calculationArray.removeAll()
    }
    
    //************************************************//
    
    @IBAction func btnback(_ sender: UIButton) {
        
        if index == 0 {
            print("Array Empty")
        }
        else {
            index = index - 1
            value.text = calculationArray[index]
        }
    }
    
    //************************************************//
}











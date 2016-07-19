//
//  ViewController.swift
//  Calculator
//
//  Created by Ivan Akulov on 22/03/16.
//  Copyright © 2016 Ivan Akulov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var displayResultLabel: UILabel!
  var stillTyping = false
  var dotIsPlaced = false
  var firstOperand: Double = 0
  var secondOperand: Double = 0
  var operationSign: String = ""
  
  var currentInput: Double {
    get {
      return Double(displayResultLabel.text!)!
    }
    
    set {
      let value = "\(newValue)"
      let valueArray = value.componentsSeparatedByString(".")
      if valueArray[1] == "0" {
        displayResultLabel.text = "\(valueArray[0])"
      } else {
        displayResultLabel.text = "\(newValue)"
      }
      stillTyping = false
    }
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  @IBAction func numberPressed(sender: UIButton) {
    
    let number = sender.currentTitle!
    
    if stillTyping {
      if displayResultLabel.text?.characters.count < 20 {
        displayResultLabel.text = displayResultLabel.text! + number
      }
    } else {
      displayResultLabel.text = number
      stillTyping = true
    }
  }
  
  @IBAction func twoOperandsSignPressed(sender: UIButton) {
    operationSign = sender.currentTitle!
    firstOperand = currentInput
    stillTyping = false
    dotIsPlaced = false
  }
  
  
  func operateWithTwoOperands(operation: (Double, Double) -> Double) {
    currentInput = operation(firstOperand, secondOperand)
    stillTyping = false
  }
  
  @IBAction func equalitySignPressed(sender: UIButton) {
    
    if stillTyping {
      secondOperand = currentInput
    }
    
    dotIsPlaced = false
    
    switch operationSign {
    case "+":
      operateWithTwoOperands{$0 + $1}
    case "-":
      operateWithTwoOperands{$0 - $1}
    case "×":
      operateWithTwoOperands{$0 * $1}
    case "÷":
      operateWithTwoOperands{$0 / $1}
    default: break
      
    }
  }
  
  @IBAction func clearButtonPressed(sender: UIButton) {
    firstOperand = 0
    secondOperand = 0
    currentInput = 0
    displayResultLabel.text = "0"
    stillTyping = false
    dotIsPlaced = false
    operationSign = ""
  }
  
  @IBAction func plusMinusButtonPressed(sender: UIButton) {
    currentInput = -currentInput
  }
  
  @IBAction func percentageButtonPressed(sender: UIButton) {
    if firstOperand == 0 {
      currentInput = currentInput / 100
    } else {
      secondOperand = firstOperand * currentInput / 100
    }
    stillTyping = false
  }
  
  @IBAction func squareRootButtonPressed(sender: UIButton) {
    
    currentInput = sqrt(currentInput)
  }
  
  @IBAction func dotButtonPressed(sender: UIButton) {
    if stillTyping && !dotIsPlaced {
      displayResultLabel.text = displayResultLabel.text! + "."
      dotIsPlaced = true
    } else if !stillTyping && !dotIsPlaced {
      displayResultLabel.text = "0."
    }
  }
}


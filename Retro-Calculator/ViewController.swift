//
//  ViewController.swift
//  Retro-Calculator
//
//  Created by Ozan Demirel on 28.01.2016.
//  Copyright © 2016 Ozan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var monitoringProcess: UILabel!
    
    enum Operation: String {
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case Empty = ""
        case Equal = "="
    }
    
    var btnSound: AVAudioPlayer!
    var firstNum: Double = 0
    var secondNum: Double = 0
    var result: Double = 0
    var panelNumber: String = ""
    var currentOperation: Operation = Operation.Empty

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let soundPath = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: soundPath!)
        
        do {
            
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onNumberPressed (btn: UIButton!) {
        playSound()
        panelNumber += "\(btn.tag)"
        monitoringProcess.text = panelNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(Operation.Equal)
    }
    
    func processOperation(op: Operation) {
        
        playSound()
        
        if panelNumber != "" {
            
            if currentOperation != Operation.Empty {
                
                secondNum = Double(panelNumber)!
                panelNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = firstNum * secondNum
                } else if currentOperation == Operation.Add {
                    result = firstNum + secondNum
                } else if currentOperation == Operation.Subtract {
                    result = firstNum - secondNum
                } else if currentOperation == Operation.Divide {
                    result = firstNum / secondNum
                }
                
                firstNum = result
                monitoringProcess.text = String(result)
                currentOperation = op
                
                if op == Operation.Equal {
                    currentOperation = Operation.Empty
                    panelNumber = ""
                    firstNum = 0
                    secondNum = 0
                    result = 0
                }
                
            } else {
                
                firstNum = Double(panelNumber)!
                panelNumber = ""
                currentOperation = op
                
            }
            
        }
        
    }
    
    func playSound() {
        
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
        
    }

}


//
//  ViewController.swift
//  VisualCalc
//
//  Created by Matthew E Robbins on 11/27/18.
//  Copyright © 2018 Matthew E Robbins. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NumberDelegate {
    
    @IBOutlet weak var numberInput: Number!
    @IBOutlet weak var tensLabel: UILabel!
    @IBOutlet weak var plusLabel: UILabel!
    @IBOutlet weak var onesLabel: UILabel!
    
    @IBOutlet weak var sumStack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        numberInput.delegate = self
    }

    func numberSet(_ view: Number, setTens tens: Int, setOnes ones: Int) {
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: {
            self.tensLabel.isHidden = tens <= 0
            self.plusLabel.isHidden = tens <= 0
            
            self.tensLabel.text = "\(tens)"
            self.onesLabel.text = "\(ones)"
        }, completion: nil)
        
    }
    
    func addNumber(_ view: Number) {
        //let v = view.copy()
        let n = Number()
        n.delegate = self
        view.delegate = nil
        n.isHidden = true
        self.sumStack.insertArrangedSubview(n, at: 0)
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            n.isHidden = false
        }, completion: nil)
        
    }
    
    @IBOutlet weak var emitterView: EmitterView!
}


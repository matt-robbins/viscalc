//
//  ViewController.swift
//  VisualCalc
//
//  Created by Matthew E Robbins on 11/27/18.
//  Copyright © 2018 Matthew E Robbins. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NumberDelegate {
    
    @IBOutlet weak var numberInput: NumberView!
    @IBOutlet weak var emitterView: EmitterView!
    
    @IBOutlet weak var sumStack: NumberStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //numberInput = sumStack.arrangedSubviews[0]
        
        emitterView.delegate = sumStack
    }
    
    func addNumber(_ view: NumberVisualView) {
        //let v = view.copy()
        let n = NumberView()
        n.delegate = self
        //view.delegate = nil
        n.isHidden = true
        self.sumStack.insertArrangedSubview(n, at: 0)
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            n.isHidden = false
        }, completion: nil)

    }
    
    
}


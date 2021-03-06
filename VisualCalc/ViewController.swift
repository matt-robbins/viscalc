//
//  ViewController.swift
//  VisualCalc
//
//  Created by Matthew E Robbins on 11/27/18.
//  Copyright © 2018 Matthew E Robbins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numberInput: NumberView!
    @IBOutlet weak var emitterView: EmitterView!
    
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var sumStack: NumberStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //numberInput = sumStack.arrangedSubviews[0]
        
        //emitterView.delegate = sumStack
        
        //let v = sumStack.arrangedSubviews[0] as? NumberView
        //v?.visView.addDelegate = self
        
        
    }
    
//    func addNumber(_ view: NumberVisualView) {
//        //let v = view.copy()
//        let n = NumberView()
//        n.delegate = self
//        //view.delegate = nil
//        n.isHidden = true
//        self.sumStack.insertArrangedSubview(n, at: 0)
//        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
//            n.isHidden = false
//        }, completion: nil)
//
//    }
    
    @IBAction func reset(_ sender: UIButton) {
        
        let n = sumStack.arrangedSubviews.count
        for k in 0 ... n-2
        {
            sumStack.removeArrangedSubview(sumStack.arrangedSubviews[k])
        }
    }
    
}


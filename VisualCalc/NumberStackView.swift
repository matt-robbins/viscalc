//
//  NumberStackView.swift
//  VisualCalc
//
//  Created by Matthew E Robbins on 12/10/18.
//  Copyright © 2018 Matthew E Robbins. All rights reserved.
//

import UIKit

@IBDesignable
class NumberStackView: UIStackView, NumberDelegate, NewNumberDelegate {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //var emitter: EmitterView = EmitterView()
    var number: NumberView = NumberView()
    
    func setup()
    {
//        emitter.backgroundColor = UIColor.clear
//        emitter.autoresizingMask = [.flexibleWidth,.flexibleHeight]
//        insertSubview(emitter, at: 0)
        
        addArrangedSubview(number)
        addArrangedSubview(UIView())
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func addNumber(_ view: NumberVisualView) {
        //let v = view.copy()
        let n = NumberView()
        n.delegate = self
        //view.delegate = nil
        n.isHidden = true
        insertArrangedSubview(n, at: 0)
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            n.isHidden = false
        }, completion: nil)
        
    }
    
    func numberSet(_ view: EmitterView, setNumber number: Int) {
        self.number.visView.number = number
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(self.hitTest(touches.first!.location(in: self), with: event))
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        let curr = self.hitTest(touches.first!.location(in: self), with: event) as? NumberView
//        let prev = self.hitTest(touches.first!.previousLocation(in: self), with: event)
//        
//
//    }
}

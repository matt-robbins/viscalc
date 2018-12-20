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
        
//        var num = NumberView()
//        num.N = 13
        
        //number.N = 5
        addArrangedSubview(number)
        number.visView.addDelegate = self
        //addArrangedSubview(num)
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
    
    func dragNumber(_ view: NumberVisualView, point: CGPoint) {
        let nv = view.superview!
        let w = nv.frame.width
        let h = nv.frame.height
        
        var y = nv.layer.position.y
        
//        nv.addConstraint(NSLayoutConstraint(item: nv,
//                                              attribute: .width,
//                                              relatedBy: .equal,
//                                              toItem: nil,
//                                              attribute: .width,
//                                              multiplier: 1.0,
//                                              constant: w))
//
//        nv.addConstraint(NSLayoutConstraint(item: nv,
//                                            attribute: .height,
//                                            relatedBy: .equal,
//                                            toItem: nil,
//                                            attribute: .height,
//                                            multiplier: 1.0,
//                                            constant: h))
        
        if (superview?.subviews.index(of: nv) != nil)
        {
            superview?.addSubview(nv)
            superview?.bringSubviewToFront(nv)
            nv.layer.position.y = 10
        }
//        var p = nv.layer.position
//        p.x = point.x
//        p.y = point.y
        var p = point
        p.y = y
        nv.layer.position = p
        
        
        
    }
    
    func numberSet(_ view: EmitterView, setNumber number: Int) {
        self.number.visView.number = number
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(self.hitTest(touches.first!.location(in: self), with: event))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        let curr = self.hitTest(touches.first!.location(in: self), with: event)
        let prev = self.hitTest(touches.first!.previousLocation(in: self), with: event)
        let tv = curr as? TenView
        
        if (tv != nil && prev != curr)
        {
            
            let loc = touches.first!.location(in: tv!)
            print(loc.x)
            let l_r = loc.x > tv!.frame.width / 2
            print(l_r)
            let vv = (tv!).superview as! NumberVisualView
            
            var ix = vv.arrangedSubviews.firstIndex(of: tv!)
            let ix2 = vv.arrangedSubviews.firstIndex(of: vv.ones!)!
            if (ix! >= ix2)
            {
                return
            }
            
            if (l_r || ix == 0) { ix = ix! + 1 }
            
            UIView.animate(withDuration: 0.1, animations: {
                vv.insertArrangedSubview(vv.space!, at: ix!)
                vv.space!.isHidden = false
            })
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}

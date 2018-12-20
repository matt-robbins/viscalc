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
    
    func dragStart(_ view: NumberView, point: CGPoint) {
        UIView.animate(withDuration: 0.1, animations: {
            view.isHidden = true
        })
        view.isHidden = false
        self.removeArrangedSubview(view)
        superview?.addSubview(view)
        superview?.bringSubviewToFront(view)
        view.layer.position.y = 10
        
        let w = view.frame.width
        let h = view.frame.height
        print("hi!!!!!")
        
//        view.addConstraint(NSLayoutConstraint(item: view,
//                                                      attribute: .width,
//                                                      relatedBy: .equal,
//                                                      toItem: nil,
//                                                      attribute: .width,
//                                                      multiplier: 0.9,
//                                                      constant: w*0.9))
        
        view.addConstraint(NSLayoutConstraint(item: view,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .height,
                                                    multiplier: 0.9,
                                                    constant: h))
        dragMove(view, point: point)
    }
    
    func dragMove(_ view: NumberView, point: CGPoint) {
        let y = view.layer.position.y
    
        var p = point
        p.y = y
        view.layer.position = p
        
        print(point)
        
        for v in self.arrangedSubviews {
            print(v)
            let nv = v as? NumberView
            
            if (nv != nil)
            {
                nv!.isSelected = v.frame.contains(point)
            }
        }
        
        print(self.arrangedSubviews.count)
    }
    
    func dragEnd(_ view: NumberView, point: CGPoint) {
        
        var ix = 1
        for v in self.arrangedSubviews[0...self.arrangedSubviews.count-2] {
            print(v.frame.minX)
            if (point.x > v.frame.maxX)
            {
                ix = arrangedSubviews.index(of: v)! + 1
            }
            let nv = v as? NumberView
            if (nv != nil)
            {
                nv?.isSelected = false
            }
        }
        
        view.isHidden = true
        UIView.animate(withDuration: 0.1, animations: {
            view.removeConstraint(view.constraints[0])
            self.insertArrangedSubview(view, at: ix)
            view.isHidden = false
        })
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

//
//  EmitterView.swift
//  VisualCalc
//
//  Created by Matthew E Robbins on 11/30/18.
//  Copyright © 2018 Matthew E Robbins. All rights reserved.
//

import UIKit

protocol NewNumberDelegate: class {
    func numberSet(_ view: EmitterView, setNumber number: Int)
}

@IBDesignable
class EmitterView: UIView {
    var N: Int = 10
    
    var delegate: NewNumberDelegate?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(UIColor.lightGray.cgColor)
            context.setLineWidth(20)
            context.fill(CGRect(x: bounds.minX, y: bounds.maxY/2, width: bounds.width, height: bounds.height/2))
            
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(4)
            context.move(to: CGPoint(x: 0, y: 0))
            context.addLine(to: CGPoint(x: 0, y: bounds.height))
            context.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
            context.addLine(to: CGPoint(x: bounds.width, y: 0))
            context.addLine(to: CGPoint(x: 0, y: 0))
            context.strokePath()
        }
    }
    
    private func setup()
    {
        //layer.addSublayer(CALayer())
        self.backgroundColor = UIColor.clear
    }
    
//    override func layoutSublayers(of layer: CALayer) {
//        let sl = layer.sublayers!.first!
//
//        let offset = layer.bounds.width/4
//
//        sl.frame = CGRect(x: layer.bounds.minX + offset, y: layer.bounds.maxX - offset, width: layer.bounds.width/2, height: layer.bounds.height/2)
//        sl.backgroundColor = UIColor.lightGray.cgColor
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let ones = Int(CGFloat(N) * (1 - touches.first!.location(in: self).y / frame.height))
//        print(ones)
//        //        let tens = Int((touches.first!.location(in: self).x) / ones.frame.width)
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        let ones = min(N - 1, Int(CGFloat(N) * (1 - touches.first!.location(in: self).y / frame.height))) + 1
//        print(ones)
//        let tens = Int((touches.first!.location(in: self).x) / frame.width)
//        
//        //print(tens*N + ones + 1)
//        if (delegate != nil)
//        {
//            delegate?.numberSet(self, setNumber: tens*N + ones)
//        }
//        //print(ones)
//    }
}

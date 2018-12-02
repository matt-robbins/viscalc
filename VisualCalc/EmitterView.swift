//
//  EmitterView.swift
//  VisualCalc
//
//  Created by Matthew E Robbins on 11/30/18.
//  Copyright © 2018 Matthew E Robbins. All rights reserved.
//

import UIKit

@IBDesignable
class EmitterView: UIView {

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
    
}

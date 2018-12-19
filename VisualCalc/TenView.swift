//
//  TenView.swift
//  VisualCalc
//
//  Created by Matthew E Robbins on 11/27/18.
//  Copyright © 2018 Matthew E Robbins. All rights reserved.
//

import UIKit

class UnitView: UIView {
    
    private var l = CALayer()
    func setup()
    {
        layer.addSublayer(l)
        l.backgroundColor = UIColor.clear.cgColor
    }
    
    override func layoutSublayers(of layer: CALayer) {
        
        let b = layer.bounds
        
        l.frame = CGRect(x: b.minX + b.width/6, y: b.minY + b.height/6, width: b.width/1.5, height: b.height/1.5)
        //l.backgroundColor = UIColor.black.cgColor
        l.cornerRadius = b.width/3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setColor(color: CGColor)
    {
        l.backgroundColor = color
    }
    
}

@IBDesignable
class TenView: UIStackView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var touched = false
    var n = 0 {
        didSet {
            touched = true
            layoutSubviews()
        }
    }
    let N = 10
    var isAnimating = false
    
    var ones = [UnitView]()
    
    func setup()
    {
        self.axis = .vertical
        for k in 0 ..< N {
            let v = UnitView()
            //            v.layer.borderColor = UIColor.gray.cgColor
            //            v.layer.borderWidth = 1
            
            //v.layer.cornerRadius = self.frame.width
            v.backgroundColor = UIColor.clear
            
            if (k < n)
            {
                
            }
            
            ones.append(v)
            
            self.insertArrangedSubview(ones.last!, at: 0)
        }
        self.distribution = UIStackView.Distribution.fillEqually
        
//        let subview = UIView(frame: bounds)
//        subview.backgroundColor = UIColor.lightGray
//        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        insertSubview(subview, at: 0)
        
        self.addConstraint(NSLayoutConstraint(item: self,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .width,
                                         multiplier: 10.0 / 1.0,
                                         constant: 0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        return
    }
    
    override func awakeFromNib() {
        
    }
    
    override func layoutSubviews() {
        if (touched == false)
        {
            return
        }
        var activeColor = UIColor.red
        if (n > N-1)
        {
            activeColor = UIColor.black
        }
        
        for k in 0 ..< self.N {
            //self.ones[k].layer.cornerRadius = self.frame.width / 2
            if (k < self.n)
            {
                self.ones[k].setColor(color: activeColor.cgColor)
            }
            else
            {
                self.ones[k].setColor(color: UIColor.clear.cgColor)
            }
        }
    }
}

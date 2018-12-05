//
//  NumberEmitter.swift
//  VisualCalc
//
//  Created by Matthew E Robbins on 11/28/18.
//  Copyright © 2018 Matthew E Robbins. All rights reserved.
//

import UIKit

protocol NumberDelegate: class {
    func numberSet(_ view: NumberVisualView, setTens tens: Int, setOnes ones: Int)
    func addNumber(_ view: NumberVisualView)
}

class NumberBackgroundView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(1)
            context.move(to: CGPoint(x: 0, y: bounds.height/2))
            context.addLine(to: CGPoint(x: bounds.width, y: bounds.height/2))
            context.strokePath()
        }
    }
    
}

@IBDesignable
class NumberVisualView: UIStackView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let N = 10
    
    weak var delegate: NumberDelegate?
    
    func setup()
    {
        axis = .horizontal
        distribution = .fill
        
        for k in 0 ..< N {
            let v = TenView()
            
            v.n = 10
            if (k < N) { v.isHidden = true }
            
            if (k == N-1)
            {
                v.n = -1
                v.isHidden = false
            }
            
            addArrangedSubview(v)
        }
        
        //var b = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: 50)
        let subview = NumberBackgroundView(frame: bounds)
        subview.backgroundColor = UIColor.clear
        subview.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        insertSubview(subview, at: 0)
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
    
    override func layoutSubviews() {
        
    }
    
    
    private var isAnimating = false
    
    
    private func setNumber()
    {
        var count = -1
        
        for k in 0 ..< N {
            if (arrangedSubviews[k].isHidden == false)
            {
                count += 1
            }
        }
        
        let n = (subviews.last! as! TenView).n + 1
        
        delegate?.numberSet(self, setTens: Int(count*10), setOnes: n)
        
    }
    
    private func touchesStartedorMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        setNumber()
        
        if (isAnimating)
        {
            return
        }
        
        let ones = arrangedSubviews.last! as! TenView
        
        ones.n = Int(10 * (1 - touches.first!.location(in: self).y / self.frame.height))
        
        if (touches.first!.location(in: self).x > self.frame.width)
        {
            self.isAnimating = true
            let count = (touches.first!.location(in: self).x - self.frame.width) / self.arrangedSubviews.last!.frame.width
            
            var c: CGFloat = 0
            UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: {
                var k = self.arrangedSubviews.count-2
                while k > 0 {
                    k -= 1
                    if (self.arrangedSubviews[k].isHidden)
                    {
                        self.arrangedSubviews[k].isHidden = false
                        c += 1
                        if (c >= count)
                        {
                            break
                        }
                    }
                }
            }, completion: { (finished: Bool) in
                self.isAnimating = false
                self.setNumber()
            })
            return
        }
        if (touches.first!.location(in: self).x < self.frame.width - arrangedSubviews.last!.frame.width)
        {
            self.isAnimating = true
            let count = (self.frame.width - touches.first!.location(in: self).x) / arrangedSubviews.last!.frame.width
            var c: CGFloat = 1
            UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: {
                for k in 0 ..< self.arrangedSubviews.count {
                    if (!self.arrangedSubviews[k].isHidden)
                    {
                        self.arrangedSubviews[k].isHidden = true
                        c += 1
                        if (c >= count)
                        {
                            break
                        }
                    }
                }
            }, completion: { (finished: Bool) in
                self.isAnimating = false
                self.setNumber()
            })
            return
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        return touchesStartedorMoved(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        return touchesStartedorMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.addNumber(self)
        
//        // and reset the source view
//        for k in 0 ..< self.arrangedSubviews.count - 1 {
//            self.arrangedSubviews[k].isHidden = true
//        }
//        (self.arrangedSubviews.last! as! TenView).n = -1
    }
        
}


@IBDesignable
class NumberView: UIStackView {
    let N = 10
    
    weak var delegate: NumberDelegate? {
        didSet {
            visView.delegate = delegate
        }
    }
    
    var visView = NumberVisualView()
    var digitView = UIView()
    
    func setup()
    {
        axis = .vertical
        distribution = .fillEqually
        
        addArrangedSubview(visView)
        insertArrangedSubview(digitView, at: 0)
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
}

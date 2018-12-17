//
//  NumberEmitter.swift
//  VisualCalc
//
//  Created by Matthew E Robbins on 11/28/18.
//  Copyright © 2018 Matthew E Robbins. All rights reserved.
//

import UIKit

protocol NumberDelegate: class {
    func addNumber(_ view: NumberVisualView)
}

protocol NumberTextDelegate: class {
    func numberSet(_ view: NumberVisualView, setNumber number: Int)
    func didFinishEntering(_ view: NumberVisualView)
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
    
    var N = 10
    var number: Int = 0 {
        didSet {
            print("setting number to \(number)")
            textDelegate?.numberSet(self, setNumber: number)
            
            let ones = arrangedSubviews.last! as! TenView
            ones.n = number % N
            if (ones.n == 0)
            {
                ones.n = 10
            }
            
            let tens = (self.number-1) / self.N
            
            //UIView.animate(withDuration: 0.01, animations: {
                for k in 0 ..< self.N-1 {
                    self.arrangedSubviews[k].isHidden = k >= tens
                }
            //})
            
        }
    }
    
    weak var addDelegate: NumberDelegate?
    weak var textDelegate: NumberTextDelegate?
    var ones: TenView? = nil
    
    func setup()
    {
        axis = .horizontal
        distribution = .fill
        
        for _ in 0 ..< N {
            let v = TenView()
            v.n = N
            v.isHidden = true
            addArrangedSubview(v)
        }
        
        ones = arrangedSubviews.last! as? TenView
        ones!.n = -1
        ones!.isHidden = false
        
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
    
    init(base: Int)
    {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        N = base
        setup()
    }
    
    
    private var isAnimating = false
    
//    private func touchesStartedorMoved(_ touches: Set<UITouch>, with event: UIEvent?)
//    {
//        let ones = arrangedSubviews.last! as! TenView
//
//        ones.n = Int(CGFloat(N) * (1 - touches.first!.location(in: self).y / self.frame.height))
//        let tens = Int((touches.first!.location(in: self).x) / ones.frame.width)
//
//        number = tens * 10 + ones.n + 1
//
//        for k in 0 ..< self.N-1 {
//            self.arrangedSubviews[k].isHidden = k >= tens
//        }
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        return touchesStartedorMoved(touches, with: event)
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        return touchesStartedorMoved(touches, with: event)
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        addDelegate?.addNumber(self)
//        textDelegate?.didFinishEntering(self)
//        //self.isUserInteractionEnabled = false
//
////        // and reset the source view
////        for k in 0 ..< self.arrangedSubviews.count - 1 {
////            self.arrangedSubviews[k].isHidden = true
////        }
////        (self.arrangedSubviews.last! as! TenView).n = -1
//    }
    
}

class DigitView: UIStackView {
    
    var tensLabel = UILabel()
    var plusLabel = UILabel()
    var onesLabel = UILabel()
    var pad = UIView()
    var B: Int = 10
    
    var editing: Bool = true
    {
        didSet {
            
        }
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
    
    func setup() {
        addArrangedSubview(tensLabel)
        addArrangedSubview(plusLabel)
        addArrangedSubview(onesLabel)
        addArrangedSubview(pad)
        
        pad.isHidden = true
        
        let font = UIFont.systemFont(ofSize: 34)
        tensLabel.text = "10"
        plusLabel.text = "+"
        tensLabel.isHidden = true
        plusLabel.isHidden = true
        onesLabel.text = "0"
        onesLabel.textColor = UIColor.red
        
        tensLabel.font = font
        onesLabel.font = font
        plusLabel.font = font
        onesLabel.adjustsFontSizeToFitWidth = true
        
        alignment = .bottom
        return
    }
    
    func setNumber(_ number: Int)
    {
        var tens = 10 * (number / B)
        if (number == B*B)
        {
            tens = 100
        }
        if (!editing)
        {
            tens /= B
        }
        let ones = number % B
        
        //UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: {
            self.tensLabel.isHidden = tens <= 0
            self.plusLabel.isHidden = tens <= 0 || !editing
//
            self.tensLabel.text = "\(tens)"
            self.onesLabel.text = "\(ones)"
        //}, completion: nil)
        
    }
    
}

@IBDesignable
class NumberView: UIStackView, NumberTextDelegate {
    
    var N: Int = 0
    var B: Int = 10
    
    var editing = true
    
    weak var delegate: NumberDelegate? {
        didSet {
            visView.addDelegate = delegate
        }
    }
    
    var visView: NumberVisualView
    var digitView = DigitView()
    
    func setup()
    {
        digitView.B = B
        axis = .vertical
        distribution = .fillEqually
        
        addArrangedSubview(visView)
        insertArrangedSubview(digitView, at: 0)
        digitView.backgroundColor = UIColor.red
        digitView.distribution = .equalSpacing
        visView.textDelegate = self
    }
    
    override init(frame: CGRect) {
        visView = NumberVisualView(base: B)
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        visView = NumberVisualView(base: B)
        super.init(coder: coder)
        setup()
    }
    
    func numberSet(_ view: NumberVisualView, setNumber number: Int) {
        print(number)
        N = number
        digitView.setNumber(number)
    }
    
    func didFinishEntering(_ view: NumberVisualView) {
        self.digitView.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
        self.digitView.plusLabel.isHidden = true
        self.digitView.distribution = .fill
        self.digitView.tensLabel.text = "\(self.N/self.B)"
        self.digitView.pad.isHidden = false
        self.digitView.alignment = .center
        }, completion: { (finished: Bool) in
            self.visView.isUserInteractionEnabled = false
            self.digitView.plusLabel.isHidden = true
        })
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(self.hitTest(touches.first!.location(in: self), with: event))
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(self.hitTest(touches.first!.location(in: self), with: event))
//    }
}

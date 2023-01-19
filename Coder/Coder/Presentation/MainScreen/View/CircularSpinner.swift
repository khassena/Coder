//
//  CircularSpinner.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 15.12.2022.
//

import UIKit

class CircularSpinner: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
//        layer.addSublayer(backgroundLayer)
//        layer.addSublayer(spinnerLayer)
//        startAnimation()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        setPath()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        startAnimation()
    }

    private func startAnimation() {
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(spinnerLayer)
        spinnerLayer.add(strokeAnimationGroup, forKey: "animate")
        self.rotateAnimation()
    }
    
    private lazy var spinnerLayer: CAShapeLayer = circleLayer(color: Color.purple)
    
    private lazy var backgroundLayer: CAShapeLayer = circleLayer(color: Color.borderColor)
    
    private lazy var strokeStartAnimation = strokeAnimation(keyPath: "strokeStart", beginTime: 0.5)
    
    private lazy var strokeEndAnimation = strokeAnimation(keyPath: "strokeEnd", beginTime: 0)
    
    private lazy var strokeAnimationGroup: CAAnimationGroup = {
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        strokeAnimationGroup.duration = 2
        strokeAnimationGroup.repeatCount = .infinity
        strokeAnimationGroup.speed = 1.5
        strokeAnimationGroup.timingFunction = .init(name: .easeInEaseOut)
        spinnerLayer.add(strokeAnimationGroup, forKey: nil)
        return strokeAnimationGroup
    }()
    
    func setPath() {
        let rect = self.bounds
        let bezierPath = UIBezierPath(ovalIn: rect)
        spinnerLayer.path = bezierPath.cgPath
        backgroundLayer.path = bezierPath.cgPath
    }
}

extension CircularSpinner {
    
    private func circleLayer(color: UIColor) -> CAShapeLayer {
        let circleLayer = CAShapeLayer()
        circleLayer.strokeColor = color.cgColor
        circleLayer.lineWidth = Constants.strokeHeight
        circleLayer.fillColor = UIColor.clear.cgColor
        return circleLayer
    }
    
    private func strokeAnimation(keyPath: String, beginTime: CFTimeInterval) -> CABasicAnimation {
        let strokeAnimation = CABasicAnimation(keyPath: keyPath)
        strokeAnimation.fromValue = 0
        strokeAnimation.toValue = 1
        strokeAnimation.duration = 1.5
        strokeAnimation.beginTime = beginTime
        return strokeAnimation
    }
    
    private func rotateAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = 2 * CGFloat.pi
        rotationAnimation.duration = 3
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.isRemovedOnCompletion = false
        self.layer.add(rotationAnimation, forKey: nil)
    }
}

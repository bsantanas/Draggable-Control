//
//  ButtonView.swift
//  DragToolbox
//
//  Created by Bernardo Santana on 6/23/15.
//  Copyright (c) 2015 bsantana. All rights reserved.
//

import UIKit

class ButtonView: UIView {

    let circlePathLayer = CAShapeLayer()
    let circleRadius: CGFloat = 20.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {

        circlePathLayer.frame = bounds
        //circlePathLayer.lineWidth = 2
        circlePathLayer.fillColor = UIColor.whiteColor().CGColor
        circlePathLayer.strokeColor = UIColor.lightGrayColor().CGColor
        //layer.addSublayer(circlePathLayer)
        backgroundColor = UIColor.clearColor()
        //superview?.layer.mask = circlePathLayer
    }
    
    func circleFrame() -> CGRect {
        var circleFrame = CGRect(x: 0, y: 0, width: 2*circleRadius, height: 2*circleRadius)
        circleFrame.origin.x = CGRectGetMidX(circlePathLayer.bounds) - CGRectGetMidX(circleFrame)
        circleFrame.origin.y = CGRectGetMidY(circlePathLayer.bounds) - CGRectGetMidY(circleFrame)
        return circleFrame
    }
    
    func circlePath() -> UIBezierPath {
        return UIBezierPath(ovalInRect: circleFrame())
    }
    
    func bigCirclePath() -> UIBezierPath {
        let radius = sqrt((center.x*center.x) + (center.y*center.y))
        var circleFrame = CGRect(x: 0, y: 0, width: 2*radius, height: 2*radius)
        circleFrame.origin.x = CGRectGetMidX(bounds) - CGRectGetMidX(circleFrame)
        circleFrame.origin.y = CGRectGetMidY(bounds) - CGRectGetMidY(circleFrame)
        return UIBezierPath(ovalInRect: circleFrame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circlePathLayer.frame = bounds
        circlePathLayer.path = circlePath().CGPath
    }
    
    func reveal() {
        
        // 1
        //backgroundColor = UIColor.whiteColor()
        // 3
        circlePathLayer.removeFromSuperlayer()
        superview?.layer.mask = circlePathLayer
        
        // 1
        let center = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
        let finalRadius = sqrt((center.x*center.x) + (center.y*center.y))
        let radiusInset = finalRadius - circleRadius
        let outerRect = CGRectInset(circleFrame(), -radiusInset, -radiusInset)
        let toPath = bigCirclePath().CGPath
        
        // 2
        let fromPath = circlePathLayer.path
        let fromLineWidth = circlePathLayer.lineWidth
        
        // 3
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        circlePathLayer.lineWidth = 2*finalRadius
        circlePathLayer.path = toPath
        layer.opacity = 0
        CATransaction.commit()

        // 4
        let duration:CFTimeInterval = 0.5
        let lineWidthAnimation = CABasicAnimation(keyPath: "lineWidth")
        lineWidthAnimation.fromValue = fromLineWidth
        lineWidthAnimation.toValue = 2*finalRadius
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = fromPath
        pathAnimation.toValue = toPath
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = duration
        
        // 5
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = duration
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.animations = [pathAnimation, lineWidthAnimation]
        groupAnimation.delegate = self
        circlePathLayer.addAnimation(groupAnimation, forKey: "strokeWidth")
        layer.addAnimation(opacityAnimation, forKey: nil)
    }
    
    func close() {
        
        // 1
        //backgroundColor = UIColor.whiteColor()
        //layer.addSublayer(circlePathLayer)
        circlePathLayer.path = bigCirclePath().CGPath
        circlePathLayer.lineWidth = 1
        superview?.layer.mask = circlePathLayer
        

        let fromPath = bigCirclePath().CGPath
        
        // 2
        let toPath = circlePath().CGPath
        
        // 3
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        circlePathLayer.path = toPath
        CATransaction.commit()
        
        // 4
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = fromPath
        pathAnimation.toValue = toPath
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0
        opacityAnimation.toValue = 1
        
        // 5
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 0.5
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.animations = [pathAnimation]
        groupAnimation.delegate = self
        circlePathLayer.addAnimation(groupAnimation, forKey: "strokeWidth")
    }

    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        //superview?.layer.mask = nil
    }

}

//
//  ViewController.swift
//  DragToolbox
//
//  Created by Bernardo Santana on 6/13/15.
//  Copyright (c) 2015 bsantana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var maskedControlView: ControlView!
    @IBOutlet weak var aView: UIView!
    
    var moving = false
    var open = false
    
    // Control Constraints
    lazy var currentFrame = CGRect()
    let smallW = CGFloat(50)
    let smallH = CGFloat(50)
    let controlW = CGFloat(400)
    let controlH = CGFloat(200)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //controlView.layer.cornerRadius = 5.0
        
        var pan = UIPanGestureRecognizer(target:self, action:"pan:")
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(pan)
        
        
        let tap = UITapGestureRecognizer(target: self, action: "tappedOnControl:")
        tap.numberOfTapsRequired = 1
        controlView.addGestureRecognizer(tap)
        maskedControlView.addGestureRecognizer(tap)
        
        // Create a mask layer and the frame to determine what will be visible in the view.
        let maskLayer = CAShapeLayer()
        
        // Create a path with the circle in it.
        var circleMaskPath = UIBezierPath(roundedRect: CGRectMake(10, 10, 40, 40), cornerRadius: 5)
        // Set the path to the mask layer.
        maskLayer.path = circleMaskPath.CGPath
        
        // Set the mask of the view.
       //maskedControlView.layer.mask = maskLayer
        
        let alayer = CAShapeLayer()
        alayer.path = UIBezierPath(ovalInRect: CGRectMake(0, 0, 30, 30)).CGPath
        aView.layer.mask = alayer
        
    }
    
    func pan(rec:UIPanGestureRecognizer) {
        
        var p:CGPoint = rec.locationInView(self.view)
        
        switch rec.state {
        case .Began:
            let draggableView = view.hitTest(p, withEvent: nil)
            if controlView == draggableView {
                println("began")
                moving = true
            }
        case .Changed:
            if moving {
                println("changed")
                controlView.center = p
            }
        case .Ended:
            println("ended")
            moving = false
        default:
            println("Other state")
        }
    }
    
//    func tappedOnControl(rec:UITapGestureRecognizer) {
//        println("tapped on control")
//        
//        if !open {
//            open = true
//            let control = rec.view
//            let frame = control?.frame
//            currentFrame = frame!
//            let x, y, width: CGFloat
//            let originX = frame!.origin.x
//            let originY = frame!.origin.y
//            
//            if (originX - controlW/2) < 0 {
//                x = 0 + 8
//            } else if (originX + controlW/2) > view.frame.width {
//                x = view.frame.width - controlW - 8
//            } else {
//                x = originX - CGFloat(controlW)/2
//            }
//            
//            if (originY - controlH/2) < 0 {
//                y = 0 + 8
//            } else if (originY + controlH/2) > view.frame.height {
//                y = view.frame.height - controlH - 8
//            } else {
//                y = originY - CGFloat(controlH)/2
//            }
//            
//            let newFrame = CGRect(x: x, y: y, width: controlW, height: controlH)
//            
//            UIView.animateWithDuration(0.1, animations: {
//                self.controlView.frame = newFrame
//            })
//        } else {
//            open = false
//            currentFrame = CGRect()
//            currentFrame.size = CGSize(width: smallW, height: smallH)
//            currentFrame.origin = CGPoint(x: controlView.center.x - CGFloat(smallW/2), y: controlView.center.y - CGFloat(smallH/2))
//            UIView.animateWithDuration(0.1, animations: {
//                self.controlView.frame = self.currentFrame
//            })
//        }
//    }
    func tappedOnControl(rec:UITapGestureRecognizer) {
        maskedControlView.toggleControl()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedonview(sender: AnyObject) {
        aView.layer
        println("yeah")
        
    }

    
}


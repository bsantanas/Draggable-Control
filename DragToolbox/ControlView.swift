//
//  ControlView.swift
//  DragToolbox
//
//  Created by Bernardo Santana on 6/23/15.
//  Copyright (c) 2015 bsantana. All rights reserved.
//

import UIKit

class ControlView: UIView {
    
    // Interface
    let maskingView = ButtonView(frame: CGRectZero)
    let toolboxView = UIView()
    
    // Variables
    var open: Bool = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addSubview(self.maskingView)
        maskingView.frame = bounds
        maskingView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        layer.mask = maskingView.circlePathLayer
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func toggleControl() {
        open ? closeControl() : openControl()
    }
    
    func openControl() {
        maskingView.reveal()
        open = true
    }
    
    func closeControl() {
        maskingView.close()
        open = false
    }
    
}

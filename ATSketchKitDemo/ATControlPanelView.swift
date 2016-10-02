//
//  ATControlPanelView.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 1/12/16.
//  Copyright © 2016 Arnaud Thiercelin. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software
//  and associated documentation files (the "Software"), to deal in the Software without restriction,
//  including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial
//  portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
//  NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

class ATControlPanelView: UIView {
	let collapsedDistance: CGFloat = 36.0
	let previewDistance: CGFloat = 90.0
    let expandedDistance: CGFloat = 250.0
	
	@IBOutlet weak var handleLabel: UILabel!
	@IBOutlet weak var positionConstraint: NSLayoutConstraint!
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let touchPoint = touches.first!.preciseLocation(in: self)
		let handleRect = handleLabel.frame
		
		if handleRect.contains(touchPoint) {
			self.toggleExpandCollapse()
		}
	}
	
	// MARK: - Expand/Collapse controls
	
	func toggleExpandCollapse() {
		let currentPositionConstant = self.positionConstraint.constant
		
		if currentPositionConstant == self.collapsedDistance {
			self.preview()
		} else if currentPositionConstant == self.previewDistance || currentPositionConstant == self.expandedDistance {
			self.collapse()
        }
		// This case here is for smooth drag n drop, split view style. To be implemented AT 01-2016
	}
    
    func toggleShowDetails() {
        let currentPositionConstant = self.positionConstraint.constant
        
        if currentPositionConstant == self.expandedDistance {
            self.preview()
        } else {
            self.expand()
        }
    }
    
    func expand() {
        self.positionConstraint.constant = self.expandedDistance
        UIView.animate(withDuration: 0.3) { () -> Void in
            self.layoutIfNeeded()
        }
    }
	
	func preview() {
		self.positionConstraint.constant = self.previewDistance
		UIView.animate(withDuration: 0.3) { () -> Void in
			self.layoutIfNeeded()
		}
	}
	
	func collapse() {
		self.positionConstraint.constant = self.collapsedDistance
		UIView.animate(withDuration: 0.3) { () -> Void in
			self.layoutIfNeeded()
		}
	}
    
    // MARK: - Custom Drawing
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Draw line to match navigation bar
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        UIColor.lightGray.set()
        path.stroke()
    }
}

//
//  ControlPanelView.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 1/12/16.
//  Copyright © 2016 Arnaud Thiercelin. All rights reserved.
//

import UIKit

class ControlPanelView: UIView {
	let collapsedDistance: CGFloat = 36.0
	let expandedDistance: CGFloat = 250.0
	
	@IBOutlet weak var handleLabel: UILabel!
	@IBOutlet weak var positionConstraint: NSLayoutConstraint!
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		let touchPoint = touches.first!.preciseLocationInView(self)
		let handleRect = handleLabel.frame
		
		if CGRectContainsPoint(handleRect, touchPoint) {
			self.toggleExpandCollapse()
		}
	}
	
	// MARK: - Expand/Collapse controls
	
	func toggleExpandCollapse() {
		let currentPositionConstant = self.positionConstraint.constant
		
		if currentPositionConstant == self.collapsedDistance {
			self.expand()
		} else if currentPositionConstant == self.expandedDistance {
			self.collapse()
		}
		// This case here is for smooth drag n drop, split view style. To be implemented AT 01-2016
		
	}
	
	func expand() {
		self.positionConstraint.constant = self.expandedDistance
		UIView.animateWithDuration(0.3) { () -> Void in
			self.layoutIfNeeded()
		}
	}
	
	func collapse() {
		self.positionConstraint.constant = self.collapsedDistance
		UIView.animateWithDuration(0.3) { () -> Void in
			self.layoutIfNeeded()
		}
	}
}

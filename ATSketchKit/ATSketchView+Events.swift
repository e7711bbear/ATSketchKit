//
//  ATSketchView+Events.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 11/26/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import Foundation

extension ATSketchView {
	
	public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		guard touches.count != 0 else {
			NSLog("No touches")
			return
		}
		
		
		if event != nil {
		}

		let touchPoint = touches.first!.locationInView(self)
		
		self.touchDownPoint = touchPoint
		self.lastKnownTouchPoint = touchPoint
		if self.currentAction == .Draw {
			if self.currentTool == .Pencil {
				self.pointsBuffer.append(touchPoint)
				self.setNeedsDisplay()
			}
		}
	}
	
	public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
		guard touches.count != 0 else {
			NSLog("No touches")
			return
		}
		
		
		if event != nil {
		}
		
		let touchPoint = touches.first!.locationInView(self)
		
		self.touchDownPoint = touchPoint
		self.lastKnownTouchPoint = touchPoint
		if self.currentAction == .Draw {
			if self.currentTool == .Pencil {
				self.pointsBuffer.append(touchPoint)
				self.setNeedsDisplay()
			}
		}
	}
	
	public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		if self.currentAction == .Draw {
			if self.currentTool == .Pencil {
				self.pointsLayers.append([CGPoint](self.pointsBuffer))
				self.pointsBuffer.removeAll()
			}
		}
				
	}
	
	public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
		
	}
}

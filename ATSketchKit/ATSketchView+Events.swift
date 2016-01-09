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

		let touchPoint = touches.first!.preciseLocationInView(self)
		
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
		
		let touchPoint = touches.first!.preciseLocationInView(self)
		
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
				// This is to generate a template
				
				var minX = CGFloat(HUGE)
				var minY = CGFloat(HUGE)
				
				for point in self.pointsBuffer {
					if point.x < minX {
						minX = point.x
					}
					if point.y < minY {
						minY = point.y
					}
				}
				
				NSLog("BEGIN")
				for point in self.pointsBuffer {
					NSLog("%f, %f", point.x - minX, point.y - minY)
				}
				NSLog("END")
				
				self.pointsBuffer.removeAll()
			}
		}
				
	}
	
	public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
		if self.currentAction == .Draw {
			if self.currentTool == .Pencil {
				self.pointsBuffer.removeAll()
			}
		}
	}
}

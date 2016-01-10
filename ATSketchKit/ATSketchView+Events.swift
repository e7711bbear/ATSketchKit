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
				
//				NSLog("BEGIN")
//				for point in self.pointsBuffer {
//					NSLog("%f, %f", point.x - minX, point.y - minY)
//				}
//				NSLog("END")
				let smartPath = ATSmartBezierPath(withPoints: self.pointsBuffer)
				var pathAppended = false
				
				if self.recognizeDrawing {
					let recognizedPathInfo = smartPath.recognizedPath()

					if recognizedPathInfo != nil {
						
						var recognizedPathIsAccepted = false
						if self.delegate != nil && self.delegate!.sketchView(self, shouldAccepterRecognizedPathWithScore: recognizedPathInfo!.score) == true {
							recognizedPathIsAccepted = true
						} else if recognizedPathInfo!.score >= 50.0 {
							recognizedPathIsAccepted = true
						}
						
						if recognizedPathIsAccepted {
							self.addShapeLayer(recognizedPathInfo!.path, lineWidth: self.currentLineWidth, color: self.currentColor)
							pathAppended = true
						}
					}
				}
				
				if pathAppended == false {
					let smoothPath = smartPath.smoothPath(20)

					self.addShapeLayer(smoothPath, lineWidth: self.currentLineWidth, color: self.currentColor)
				}
				self.pointsBuffer.removeAll()
				self.setNeedsDisplay()
				self.layer.setNeedsDisplay()
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

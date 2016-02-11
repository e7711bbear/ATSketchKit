//
//  ATSketchView+Events.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 11/26/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
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

import Foundation

extension ATSketchView {
	
	public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		guard touches.count != 0 else {
			NSLog("No touches")
			return
		}

    self.clearRedo()
		
		if event != nil {
		}
		
		let touchPoint = touches.first!.preciseLocationInView(self)
		
		self.touchDownPoint = touchPoint
		self.lastKnownTouchPoint = touchPoint
		if self.currentTool == .Pencil || self.currentTool == .Eraser || self.currentTool == .SmartPencil {
			self.pointsBuffer.append(touchPoint)
			self.updateTopLayer()
			self.setNeedsDisplay()
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
		if self.currentTool == .Pencil || self.currentTool == .Eraser || self.currentTool == .SmartPencil {
			self.pointsBuffer.append(touchPoint)
			self.updateTopLayer()
			self.setNeedsDisplay()
		}
	}
	
	public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		if self.currentTool == .Pencil || self.currentTool == .Eraser || self.currentTool == .SmartPencil {
			
			self.printTemplateSource(self.pointsBuffer)
			
			let smartPath = ATSmartBezierPath(withPoints: self.pointsBuffer)
			var pathAppended = false
			
			if self.currentTool == .SmartPencil {
				let recognizedPathInfo = smartPath.recognizedPath()
				
				if recognizedPathInfo != nil {
					
					var recognizedPathIsAccepted = false
					if self.delegate != nil && self.delegate!.sketchView(self, shouldAccepterRecognizedPathWithScore: recognizedPathInfo!.score) == true {
						recognizedPathIsAccepted = true
					} else if recognizedPathInfo!.score >= 50.0 {
						recognizedPathIsAccepted = true
					}
					
					if recognizedPathIsAccepted {
						var finalPath = recognizedPathInfo!.path
						
						if let overridenPath = self.delegate?.sketchViewOverridingRecognizedPathDrawing(self) {
							finalPath = overridenPath
						}
						
						self.addShapeLayer(finalPath, lineWidth: self.currentLineWidth, color: self.currentColor)
						self.delegate?.sketchView(self, didRecognizePathWithName: recognizedPathInfo!.template.name)
						pathAppended = true
					}
				}
			}
			
			if pathAppended == false {
				let smoothPath = smartPath.smoothPath(20)
				let finalColor = self.currentTool == .Eraser ? self.eraserColor : self.currentColor
				
				self.addShapeLayer(smoothPath, lineWidth: self.currentLineWidth, color: finalColor)
			}
			self.pointsBuffer.removeAll()
			self.clearTopLayer()
			self.setNeedsDisplay()
			self.layer.setNeedsDisplay()
		}
	}
	
	func printTemplateSource(points: [CGPoint]) {
		var minX = CGFloat(HUGE)
		var minY = CGFloat(HUGE)
		
		for point in points {
			if point.x < minX {
				minX = point.x
			}
			if point.y < minY {
				minY = point.y
			}
		}
		
		NSLog("Copy paste the source below:")
		var sourceCode = "\nnewTemplate.points = ["
		for point in self.pointsBuffer {
			sourceCode += "CGPoint(x: \(point.x - minX), y: \(point.y - minY)),\n"
		}
		sourceCode += "]"
		
		NSLog("\(sourceCode)")
	}
	
	public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
		if self.currentTool == .Pencil || self.currentTool == .Eraser || self.currentTool == .SmartPencil {
			self.pointsBuffer.removeAll()
		}
	}
}

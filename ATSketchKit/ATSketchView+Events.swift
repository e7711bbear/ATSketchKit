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
						self.addShapeLayer(recognizedPathInfo!.path, lineWidth: self.currentLineWidth, color: self.currentColor)
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

//
//  ATSketchView.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 11/26/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import UIKit

@IBDesignable
class ATSketchView: UIView {

	enum Tools {
		case Finger
		case Pencil
	}
	
	enum Actions {
		case Select
		case Move
		case Draw
	}
	
	var touchDownPoint: CGPoint!
	var lastKnownTouchPoint: CGPoint!
	
	var topLayer: ATSketchTopLayer!
	
	var currentTool: Tools = .Pencil
	var currentAction: Actions = .Draw
	
	var pointsBuffer = [CGPoint]()
	
	var pointsLayers = [[CGPoint]]()
	
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
//		let context = UIGraphicsGetCurrentContext()
//		
//		CGContextSaveGState(context)
//		UIColor.blackColor().setFill()
		//		for pixel in pixels {
		//			CGContextFillRect(context, CGRectMake(pixel.x, pixel.y, 1, 1))
		//		}
		//		CGContextRestoreGState(context)
		
		let bezierPath = UIBezierPath()
		var isFirstPixel = true
		for pixel in pointsBuffer {
			if isFirstPixel {
				bezierPath.moveToPoint(pixel)
				isFirstPixel = false
			} else {
				bezierPath.addLineToPoint(pixel)
			}
		}
		UIColor.redColor().setStroke()
		bezierPath.lineWidth = 1
		bezierPath.stroke()
		
		for points in pointsLayers {
		let bezierPath = UIBezierPath()
		var isFirstPixel = true
		for pixel in points {
			if isFirstPixel {
				bezierPath.moveToPoint(pixel)
				isFirstPixel = false
			} else {
				bezierPath.addLineToPoint(pixel)
			}
		}
		UIColor.blackColor().setStroke()
		bezierPath.lineWidth = 1
		bezierPath.stroke()
		}
	}
	

}

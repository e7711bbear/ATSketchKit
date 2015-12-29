//
//  ATSketchView.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 11/26/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import UIKit

@IBDesignable
public class ATSketchView: UIView {

	public enum Tools {
		case Finger
		case Pencil
	}
	
	public enum Actions {
		case Select
		case Move
		case Draw
	}
	
	var touchDownPoint: CGPoint!
	var lastKnownTouchPoint: CGPoint!
	
	var topLayer: ATSketchTopLayer!
	
	public var currentTool: Tools = .Pencil
	public var currentAction: Actions = .Draw
	
	var pointsBuffer = [CGPoint]()
	
	var pointsLayers = [[CGPoint]]()
	
    public override func drawRect(rect: CGRect) {		
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

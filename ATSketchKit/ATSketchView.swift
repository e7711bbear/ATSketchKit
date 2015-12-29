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
		var bezierPath = self.smoothPath(pointsBuffer, granularity: 20)

		UIColor.redColor().setStroke()
		bezierPath.lineWidth = 1
		bezierPath.stroke()
		
		for points in pointsLayers {
			bezierPath = smoothPath(points, granularity: 20)

			UIColor.blackColor().setStroke()
			bezierPath.lineWidth = 1
			bezierPath.lineCapStyle = .Round
			bezierPath.stroke()
		}
	}
	
	func smoothPath(originalPoints: [CGPoint], granularity: Int) -> UIBezierPath {
		var points = originalPoints
		if points.count < 4 {
			var newPath = UIBezierPath()
			
			if points.count > 0 {
				for index in 0...points.count - 1 {
					if index == 0 {
						newPath.moveToPoint(points[index])
					} else {
						newPath.addLineToPoint(points[index])
					}
				}
			}
			
			return newPath
		}
		
		// Add control points
		points.insert(points[0], atIndex: 0)
		points.append(points.last!)
		
		var newPath = UIBezierPath()
		newPath.moveToPoint(points[0])
		
		for pointIndex in 1...points.count - 3 {
			let point0 = points[pointIndex - 1]
			let point1 = points[pointIndex]
			let point2 = points[pointIndex + 1]
			let point3 = points[pointIndex + 2]
			
			// now we add n points starting at point1 + dx/dy up until point2 using Catmull-Rom splines
			for index in 1...granularity {
				let t = CGFloat(index) * (1.0 / CGFloat(granularity))
				let tt = CGFloat(t * t)
				let ttt = CGFloat(tt * t)
				
				var intermediatePoint = CGPoint()
				
				let xt = (point2.x - point0.x) * t
				let xtt = (2 * point0.x - 5 * point1.x + 4 * point2.x - point3.x) * tt
				let xttt = (3 * point1.x - point0.x - 3 * point2.x + point3.x) * ttt
				intermediatePoint.x = 0.5 * (2 * point1.x + xt + xtt + xttt )
				let yt = (point2.y - point0.y) * t
				let ytt = (2 * point0.y - 5 * point1.y + 4 * point2.y - point3.y) * tt
				let yttt = (3 * point1.y - point0.y - 3 * point2.y + point3.y) * ttt
				intermediatePoint.y = 0.5 * (2 * point1.y + yt + ytt + yttt)
				newPath.addLineToPoint(intermediatePoint)
			}
			newPath.addLineToPoint(point2)
		}
		newPath.addLineToPoint(points.last!)
		
		return newPath
	}

}

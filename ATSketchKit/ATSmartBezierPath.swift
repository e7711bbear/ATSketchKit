//
//  ATSmartBezierPath.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 12/29/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import UIKit

class ATSmartBezierPath: UIBezierPath {

	var unistrokeTemplates = [ATUnistrokeTemplate]()
	var points = [CGPoint]()
	
	convenience init(withPoints points: [CGPoint]) {
		self.init()
		self.points = points		
	}
	
	override func moveToPoint(point: CGPoint) {
		self.points.removeAll()
		self.points.append(point)
		super.moveToPoint(point)
	}

	override func addLineToPoint(point: CGPoint) {
		self.points.append(point)
		super.addLineToPoint(point)
	}
	
	override func addCurveToPoint(endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
		self.points.append(endPoint)
		super.addCurveToPoint(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
	}
	
	override func addQuadCurveToPoint(endPoint: CGPoint, controlPoint: CGPoint) {
		self.points.append(endPoint)
		super.addQuadCurveToPoint(endPoint, controlPoint: controlPoint)
	}
}

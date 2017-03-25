//
//  ATSmartBezierPath.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 12/29/15.
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

import UIKit

class ATSmartBezierPath: UIBezierPath {

	var unistrokeTemplates = [ATUnistrokeTemplate]()
	var points = [CGPoint]()
	
	convenience init(withPoints points: [CGPoint]) {
		self.init()
		self.points = points
		
		self.loadTemplates()
	}
	
	override func move(to point: CGPoint) {
		self.points.removeAll()
		self.points.append(point)
		super.move(to: point)
	}

	override func addLine(to point: CGPoint) {
		self.points.append(point)
		super.addLine(to: point)
	}
	
	override func addCurve(to endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
		self.points.append(endPoint)
		super.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
	}
	
	override func addQuadCurve(to endPoint: CGPoint, controlPoint: CGPoint) {
		self.points.append(endPoint)
		super.addQuadCurve(to: endPoint, controlPoint: controlPoint)
	}
	
	override var description: String {
		get {
			return self.debugDescription
		}
	}
	
	override var debugDescription: String{
		get {
			return "ATSmartBezierPath \n" +
			"Points: \(self.points)\n" +
			"UnistrokeTemplates: \(self.unistrokeTemplates)\n"
		}
	}
}

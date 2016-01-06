//
//  ATSmartBezierPath+UnistrokeRecognizer.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 12/29/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//
// This dollar unistroke recognizer implementation was inspired by the work of 
// Chris Miles - https://github.com/chrismiles/CMUnistrokeGestureRecognizer
// Adam Preble - https://github.com/preble/GLGestureRecognizer

import Foundation

extension ATSmartBezierPath {
	
	func recognizedPath() -> UIBezierPath {
		
		return UIBezierPath()
	}
	
	func resamplePath(pointsCount size: Int) -> [CGPoint] {
		return [CGPoint]()
	}
	
	// MARK: - Transformations
	
	func translate(sample: [CGPoint], deltaX: CGFloat, deltaY: CGFloat) -> [CGPoint] {
		var newSample = [CGPoint]()
		
		for point in sample {
			let newPoint = CGPointMake(point.x+deltaX, point.y+deltaY)

			newSample.append(newPoint)
		}
		return newSample
	}

	func rotate(sample: [CGPoint], angle: CGFloat) -> [CGPoint] {
		let rotationTransform = CGAffineTransformMakeRotation(angle)
		
		var newSample = [CGPoint]()
		for point in sample {
			let newPoint = CGPointApplyAffineTransform(point, rotationTransform)
			
			newSample.append(newPoint)
		}
		
		return newSample
	}
	
	func scale(sample: [CGPoint], xScale: CGFloat, yScale: CGFloat) -> [CGPoint] {
		let scaleTransform = CGAffineTransformMakeScale(xScale, yScale)
		
		var newSample = [CGPoint]()
		for point in sample {
			let newPoint = CGPointApplyAffineTransform(point, scaleTransform)
			
			newSample.append(newPoint)
		}
		
		return newSample
	}
	
}
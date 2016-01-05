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
		return [CGPoint]()
	}
	
	func scale(sample: [CGPoint], scale: CGFloat) -> [CGPoint] {
		return [CGPoint]()
	}

}
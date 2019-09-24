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

extension ATSmartBezierPath {
	
	func recognizedPath() -> ATRecognizedPathResult? {
		
		let sampleSize = 128 // arbitrary value
		var sample = self.resamplePath(pointsCount: sampleSize)
		var center = self.centroid(sample)
		
		sample = self.translate(sample, deltaX: -center.x, deltaY: -center.y)
		
		let firstPoint = sample.first!
		let firstPointAngle = atan2(firstPoint.y, firstPoint.x)
		
		sample = self.rotate(sample, angle: -firstPointAngle)
		
		let boundaries = self.boundaries(sample)
		let boundariesDeltaX = boundaries.topRight.x - boundaries.bottomLeft.x
		let boundariesDeltaY = boundaries.topRight.y - boundaries.bottomLeft.y
		let scale = 2.0 / (boundariesDeltaX < boundariesDeltaY ? boundariesDeltaY : boundariesDeltaX )
		
		sample = self.scale(sample, xScale: scale, yScale: scale)
		
		center = self.centroid(sample)
		sample = self.translate(sample, deltaX: -center.x, deltaY: -center.y)
		
		// comparing now:
		
		var bestTemplate: ATUnistrokeTemplate?
		var bestScore = CGFloat(HUGE)
		for template in self.unistrokeTemplates {
			// Maybe a resampling here of the template too.
			
			let score = self.distanceAtBestAngle(sample, template: template.points)
			if score < bestScore {
				bestScore = score
				bestTemplate = template
			}
		}
		
		if bestTemplate != nil {
			let pathRect = self.smoothPath(20).bounds
			let finalPath = bestTemplate!.recognizedPathWithRect(pathRect)
			let result = ATRecognizedPathResult()
			
			result.center = center
			result.angle = firstPointAngle
			result.score = bestScore
			result.path = finalPath
			result.template = bestTemplate!
			
			return result
		} else {
			return nil
		}
	}
	
	func resamplePath(pointsCount size: Int) -> [CGPoint] {
		var newSample = [CGPoint]()
		
		for index in 0..<self.points.count {
			let computedIndex = (self.points.count - 1) * index / (size - 1)
			let newIndex = 0 < computedIndex ? computedIndex : 0
			
			if newIndex < self.points.count {
				let newPoint = self.points[newIndex]
				
				newSample.append(newPoint)
			}
		}
		
		return newSample
	}
	
	// MARK: - Transformations
	
	func centroid(_ sample: [CGPoint]) -> CGPoint {
		var xSum: CGFloat = 0
		var ySum: CGFloat = 0;
		let pointCount = CGFloat(sample.count)
		
		for point in sample {
			xSum += point.x
			ySum += point.y
		}
		return CGPoint(x: xSum / pointCount, y: ySum / pointCount)
	}
	
	func translate(_ sample: [CGPoint], deltaX: CGFloat, deltaY: CGFloat) -> [CGPoint] {
		var newSample = [CGPoint]()
		
		for point in sample {
			let newPoint = CGPoint(x: point.x+deltaX, y: point.y+deltaY)
			
			newSample.append(newPoint)
		}
		return newSample
	}
	
	func rotate(_ sample: [CGPoint], angle: CGFloat) -> [CGPoint] {
		let rotationTransform = CGAffineTransform(rotationAngle: angle)
		
		var newSample = [CGPoint]()
		for point in sample {
			let newPoint = point.applying(rotationTransform)
			
			newSample.append(newPoint)
		}
		
		return newSample
	}
	
	func scale(_ sample: [CGPoint], xScale: CGFloat, yScale: CGFloat) -> [CGPoint] {
		let scaleTransform = CGAffineTransform(scaleX: xScale, y: yScale)
		
		var newSample = [CGPoint]()
		for point in sample {
			let newPoint = point.applying(scaleTransform)
			
			newSample.append(newPoint)
		}
		
		return newSample
	}
	
	// MARK: - Distance calculations
	
	func distance(_ point1: CGPoint, point2: CGPoint) -> CGFloat {
		let deltaX = point1.x - point2.x
		let deltaY = point2.y - point2.y
		
		return sqrt(deltaX * deltaX + deltaY * deltaY)
	}
	
	func pathDistance(_ path1: [CGPoint], path2: [CGPoint]) -> CGFloat {
		// Normally these should be the same, but just in case we protect against it.
		let count = path1.count > path2.count ? path2.count : path1.count
		var distanceSum: CGFloat = 0
		
		for index in 0..<count {
			let point1 = path1[index]
			let point2 = path2[index]
			
			distanceSum += self.distance(point1, point2: point2)
		}
		
		return distanceSum / CGFloat(count)
	}
	
	func distanceAtAngle(_ path: [CGPoint], template: [CGPoint], angle: CGFloat) -> CGFloat {
		let newPath = self.rotate(path, angle: angle)
		
		return self.pathDistance(newPath, path2: template)
	}
	
	func distanceAtBestAngle(_ path: [CGPoint], template: [CGPoint]) -> CGFloat {
		var a: CGFloat = -0.25 * CGFloat(Double.pi)
		var b: CGFloat = -a
		let threshold: CGFloat = 0.1
		let phi: CGFloat = 0.5 * (-1.0 + sqrt(5.0)) // Golden Ratio
		var x1: CGFloat = phi * a + (1.0 - phi) * b
		var f1: CGFloat = distanceAtAngle(path, template: template, angle: x1)
		var x2: CGFloat = (1.0 - phi) * a + phi * b
		var f2: CGFloat = distanceAtAngle(path, template: template, angle: x2)
		
		while abs(b - a) > threshold {
			if f1 < f2 {
				b = x2
				x2 = x1
				f2 = f1
				x1 = phi * a + (1.0 - phi) * b
				f1 = distanceAtAngle(path, template: template, angle: x1)
			} else {
				a = x1
				x1 = x2
				f1 = f2
				x2 = (1.0 - phi) * a + phi * b;
				f2 = distanceAtAngle(path, template: template, angle: x2)
			}
		}
		return f1 < f2 ? f1 : f2
	}
	
	// MARK: - 
	
	func boundaries(_ path: [CGPoint]) -> (bottomLeft: CGPoint, topRight: CGPoint) {
		var bottomLeft = CGPoint.zero
		var topRight = CGPoint.zero
		
		for index in 0..<path.count {
			let point = path[index]
			
			if point.x < bottomLeft.x {
				bottomLeft.x = point.x
			}
			if point.y < bottomLeft.y {
				bottomLeft.y = point.y
			}
			if point.x > topRight.x {
				topRight.x = point.x
			}
			if point.y > topRight.y {
				topRight.y = point.y
			}
		}
		return (bottomLeft, topRight)
	}
}

//
//  ATSmartBezierPath+RecognizerTemplates.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 1/8/16.
//  Copyright © 2016 Arnaud Thiercelin. All rights reserved.
//

import Foundation

extension ATSmartBezierPath {
	
	func createRectTemplates() {
		let templateName = "Rectangle"
		let newRectTemplate = ATUnistrokeTemplate()
		
		newRectTemplate.name = templateName
		newRectTemplate.points = [
			CGPoint(x: 0.000000, y:7.000000),
			CGPoint(x: 0.000000, y:9.000000),
			CGPoint(x: 0.000000, y:10.000000),
			CGPoint(x: 0.000000, y:15.000000),
			CGPoint(x: 0.000000, y:19.000000),
			CGPoint(x: 0.000000, y:26.000000),
			CGPoint(x: 0.000000, y:32.000000),
			CGPoint(x: 0.000000, y:39.000000),
			CGPoint(x: 0.000000, y:46.000000),
			CGPoint(x: 0.000000, y:55.000000),
			CGPoint(x: 0.000000, y:62.000000),
			CGPoint(x: 0.000000, y:72.000000),
			CGPoint(x: 0.000000, y:79.000000),
			CGPoint(x: 0.000000, y:83.000000),
			CGPoint(x: 0.000000, y:87.000000),
			CGPoint(x: 0.000000, y:91.000000),
			CGPoint(x: 0.000000, y:93.000000),
			CGPoint(x: 0.000000, y:96.000000),
			CGPoint(x: 0.000000, y:99.000000),
			CGPoint(x: 0.000000, y:101.000000),
			CGPoint(x: 0.000000, y:103.000000),
			CGPoint(x: 0.000000, y:104.000000),
			CGPoint(x: 0.000000, y:105.000000),
			CGPoint(x: 1.000000, y:106.000000),
			CGPoint(x: 3.000000, y:106.000000),
			CGPoint(x: 7.000000, y:107.000000),
			CGPoint(x: 11.000000, y:108.000000),
			CGPoint(x: 18.000000, y:108.000000),
			CGPoint(x: 28.000000, y:108.000000),
			CGPoint(x: 52.000000, y:109.000000),
			CGPoint(x: 62.000000, y:109.000000),
			CGPoint(x: 73.000000, y:110.000000),
			CGPoint(x: 82.000000, y:110.000000),
			CGPoint(x: 91.000000, y:110.000000),
			CGPoint(x: 98.000000, y:110.000000),
			CGPoint(x: 103.000000, y:110.00000),
			CGPoint(x: 106.000000, y:110.00000),
			CGPoint(x: 108.000000, y:111.00000),
			CGPoint(x: 110.000000, y:111.00000),
			CGPoint(x: 112.000000, y:111.00000),
			CGPoint(x: 116.000000, y:111.00000),
			CGPoint(x: 118.000000, y:111.00000),
			CGPoint(x: 120.000000, y:111.00000),
			CGPoint(x: 122.000000, y:111.00000),
			CGPoint(x: 123.000000, y:111.00000),
			CGPoint(x: 124.000000, y:111.00000),
			CGPoint(x: 125.000000, y:111.00000),
			CGPoint(x: 125.000000, y:110.00000),
			CGPoint(x: 125.000000, y:106.00000),
			CGPoint(x: 124.000000, y:100.00000),
			CGPoint(x: 123.000000, y:91.000000),
			CGPoint(x: 121.000000, y:86.000000),
			CGPoint(x: 121.000000, y:77.000000),
			CGPoint(x: 120.000000, y:72.000000),
			CGPoint(x: 119.000000, y:65.000000),
			CGPoint(x: 118.000000, y:60.000000),
			CGPoint(x: 118.000000, y:55.000000),
			CGPoint(x: 117.000000, y:48.000000),
			CGPoint(x: 117.000000, y:43.000000),
			CGPoint(x: 116.000000, y:38.000000),
			CGPoint(x: 113.000000, y:33.000000),
			CGPoint(x: 113.000000, y:29.000000),
			CGPoint(x: 112.000000, y:25.000000),
			CGPoint(x: 112.000000, y:23.000000),
			CGPoint(x: 112.000000, y:22.000000),
			CGPoint(x: 112.000000, y:21.000000),
			CGPoint(x: 112.000000, y:20.000000),
			CGPoint(x: 112.000000, y:18.000000),
			CGPoint(x: 112.000000, y:15.000000),
			CGPoint(x: 112.000000, y:12.000000),
			CGPoint(x: 112.000000, y:9.000000),
			CGPoint(x: 112.000000, y:7.000000),
			CGPoint(x: 111.000000, y:5.000000),
			CGPoint(x: 111.000000, y:4.000000),
			CGPoint(x: 111.000000, y:3.000000),
			CGPoint(x: 111.000000, y:2.000000),
			CGPoint(x: 111.000000, y:1.000000),
			CGPoint(x: 110.000000, y:1.000000),
			CGPoint(x: 109.000000, y:0.000000),
			CGPoint(x: 107.000000, y:0.000000),
			CGPoint(x: 102.000000, y:0.000000),
			CGPoint(x: 97.000000, y:0.000000),
			CGPoint(x: 89.000000, y:0.000000),
			CGPoint(x: 78.000000, y:0.000000),
			CGPoint(x: 68.000000, y:0.000000),
			CGPoint(x: 59.000000, y:1.000000),
			CGPoint(x: 49.000000, y:1.000000),
			CGPoint(x: 41.000000, y:2.000000),
			CGPoint(x: 35.000000, y:2.000000),
			CGPoint(x: 28.000000, y:3.000000),
			CGPoint(x: 23.000000, y:3.000000),
			CGPoint(x: 19.000000, y:3.000000),
			CGPoint(x: 16.000000, y:3.000000),
			CGPoint(x: 13.000000, y:3.000000),
			CGPoint(x: 10.000000, y:3.000000),
			CGPoint(x: 8.000000, y:3.000000),
			CGPoint(x: 6.000000, y:3.000000),
			CGPoint(x: 5.000000, y:3.000000)
		]
		newRectTemplate.recognizedPathWithRect = { (rect: CGRect) -> UIBezierPath in
			return UIBezierPath(rect: rect)
		}
		
		self.unistrokeTemplates.append(newRectTemplate)
		
	}
	
	func createCircleTemplates() {
		
	}
}
//
//  ATSmartBezierPath+RecognizerTemplates.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 1/8/16.
//  Copyright © 2016 Arnaud Thiercelin. All rights reserved.
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
	
	func createRectTemplates() {
		let templateName = "Rectangle"
		var newRectTemplate = ATUnistrokeTemplate()
		
		newRectTemplate.name = templateName
		newRectTemplate.recognizedPathWithRect = { (rect: CGRect) -> UIBezierPath in
			return UIBezierPath(rect: rect)
		}
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
		self.unistrokeTemplates.append(newRectTemplate)
		
		newRectTemplate = ATUnistrokeTemplate()
		newRectTemplate.name = templateName
		newRectTemplate.recognizedPathWithRect = { (rect: CGRect) -> UIBezierPath in
			return UIBezierPath(rect: rect)
		}
		newRectTemplate.points = [CGPoint(x: 373.0, y: 12.0),
			CGPoint(x: 356.5, y: 14.5),
			CGPoint(x: 340.0, y: 19.0),
			CGPoint(x: 320.5, y: 19.0),
			CGPoint(x: 295.5, y: 19.0),
			CGPoint(x: 202.5, y: 16.0),
			CGPoint(x: 104.5, y: 5.0),
			CGPoint(x: 38.0, y: 5.0),
			CGPoint(x: 14.5, y: 2.0),
			CGPoint(x: 4.5, y: 2.0),
			CGPoint(x: 3.0, y: 0.0),
			CGPoint(x: 3.0, y: 4.0),
			CGPoint(x: 3.0, y: 16.5),
			CGPoint(x: 0.0, y: 77.5),
			CGPoint(x: 0.0, y: 138.5),
			CGPoint(x: 0.0, y: 190.0),
			CGPoint(x: 8.5, y: 262.5),
			CGPoint(x: 11.0, y: 279.0),
			CGPoint(x: 16.0, y: 325.5),
			CGPoint(x: 17.0, y: 338.0),
			CGPoint(x: 18.5, y: 368.5),
			CGPoint(x: 18.5, y: 379.5),
			CGPoint(x: 18.5, y: 381.0),
			CGPoint(x: 18.5, y: 393.5),
			CGPoint(x: 17.0, y: 418.5),
			CGPoint(x: 16.0, y: 439.0),
			CGPoint(x: 16.0, y: 459.0),
			CGPoint(x: 16.0, y: 480.0),
			CGPoint(x: 16.0, y: 482.5),
			CGPoint(x: 16.0, y: 483.5),
			CGPoint(x: 17.0, y: 483.5),
			CGPoint(x: 24.0, y: 483.5),
			CGPoint(x: 85.0, y: 481.0),
			CGPoint(x: 120.0, y: 479.5),
			CGPoint(x: 193.5, y: 479.5),
			CGPoint(x: 247.0, y: 476.0),
			CGPoint(x: 290.0, y: 476.0),
			CGPoint(x: 316.0, y: 476.0),
			CGPoint(x: 334.0, y: 476.0),
			CGPoint(x: 342.0, y: 473.5),
			CGPoint(x: 350.5, y: 473.5),
			CGPoint(x: 367.0, y: 473.5),
			CGPoint(x: 385.0, y: 473.5),
			CGPoint(x: 399.0, y: 476.0),
			CGPoint(x: 408.5, y: 478.0),
			CGPoint(x: 415.5, y: 479.5),
			CGPoint(x: 417.0, y: 479.5),
			CGPoint(x: 420.5, y: 480.5),
			CGPoint(x: 422.0, y: 480.5),
			CGPoint(x: 423.5, y: 480.5),
			CGPoint(x: 423.5, y: 478.5),
			CGPoint(x: 423.5, y: 467.5),
			CGPoint(x: 415.0, y: 381.5),
			CGPoint(x: 402.5, y: 306.5),
			CGPoint(x: 396.5, y: 230.5),
			CGPoint(x: 395.0, y: 175.0),
			CGPoint(x: 396.5, y: 136.0),
			CGPoint(x: 399.5, y: 122.0),
			CGPoint(x: 400.5, y: 115.5),
			CGPoint(x: 400.5, y: 110.0),
			CGPoint(x: 400.5, y: 83.5),
			CGPoint(x: 400.5, y: 62.5),
			CGPoint(x: 400.5, y: 44.0),
			CGPoint(x: 400.5, y: 37.0),
			CGPoint(x: 400.5, y: 35.5),
			CGPoint(x: 400.5, y: 35.0),
			CGPoint(x: 400.5, y: 34.0),
			CGPoint(x: 400.5, y: 28.5),
			CGPoint(x: 400.5, y: 22.5),
			CGPoint(x: 400.5, y: 20.0),
			CGPoint(x: 400.5, y: 18.0),
			CGPoint(x: 400.5, y: 14.0),
			CGPoint(x: 399.5, y: 11.0),
			CGPoint(x: 399.5, y: 10.0),
			CGPoint(x: 398.0, y: 10.0),
			CGPoint(x: 396.5, y: 10.0),
			CGPoint(x: 391.0, y: 10.0),
			CGPoint(x: 388.5, y: 10.0),
			CGPoint(x: 382.5, y: 10.0),
			CGPoint(x: 378.0, y: 10.0),
			CGPoint(x: 375.5, y: 10.0)
		]
		
		self.unistrokeTemplates.append(newRectTemplate)
	}
	
	func createCircleTemplates() {
		let templateName = "Circle"
		let newTemplate = ATUnistrokeTemplate()
		newTemplate.name = templateName
		newTemplate.recognizedPathWithRect = { (rect: CGRect) -> UIBezierPath in
			let maxValue = rect.size.height > rect.size.width ? rect.size.height : rect.size.width
			let circleRect = CGRectMake(rect.origin.x, rect.origin.y, maxValue, maxValue)
			
			return UIBezierPath(ovalInRect: circleRect)
		}
		newTemplate.points = [CGPoint(x: 43.5, y: 12.0),
			CGPoint(x: 42.5, y: 12.0),
			CGPoint(x: 41.0, y: 12.0),
			CGPoint(x: 37.0, y: 12.0),
			CGPoint(x: 32.5, y: 12.0),
			CGPoint(x: 24.5, y: 12.0),
			CGPoint(x: 20.0, y: 13.5),
			CGPoint(x: 14.0, y: 20.5),
			CGPoint(x: 10.0, y: 27.5),
			CGPoint(x: 4.0, y: 35.0),
			CGPoint(x: 2.5, y: 42.0),
			CGPoint(x: 0.0, y: 53.0),
			CGPoint(x: 0.0, y: 57.5),
			CGPoint(x: 0.0, y: 60.0),
			CGPoint(x: 0.0, y: 68.0),
			CGPoint(x: 0.0, y: 75.0),
			CGPoint(x: 0.0, y: 82.0),
			CGPoint(x: 0.0, y: 87.5),
			CGPoint(x: 1.0, y: 97.0),
			CGPoint(x: 5.0, y: 104.0),
			CGPoint(x: 10.5, y: 109.5),
			CGPoint(x: 21.0, y: 117.0),
			CGPoint(x: 29.5, y: 121.5),
			CGPoint(x: 42.0, y: 125.5),
			CGPoint(x: 52.0, y: 129.0),
			CGPoint(x: 62.0, y: 130.5),
			CGPoint(x: 77.0, y: 130.5),
			CGPoint(x: 87.0, y: 130.5),
			CGPoint(x: 95.5, y: 129.0),
			CGPoint(x: 108.0, y: 122.0),
			CGPoint(x: 111.0, y: 119.5),
			CGPoint(x: 117.5, y: 103.5),
			CGPoint(x: 117.5, y: 92.5),
			CGPoint(x: 120.0, y: 76.0),
			CGPoint(x: 121.5, y: 70.5),
			CGPoint(x: 121.5, y: 60.0),
			CGPoint(x: 121.5, y: 42.0),
			CGPoint(x: 121.5, y: 34.0),
			CGPoint(x: 120.5, y: 28.0),
			CGPoint(x: 116.5, y: 21.5),
			CGPoint(x: 112.5, y: 15.5),
			CGPoint(x: 107.0, y: 11.5),
			CGPoint(x: 97.0, y: 7.0),
			CGPoint(x: 90.0, y: 4.0),
			CGPoint(x: 83.0, y: 3.0),
			CGPoint(x: 72.5, y: 1.5),
			CGPoint(x: 65.5, y: 0.0),
			CGPoint(x: 58.5, y: 0.0),
			CGPoint(x: 54.0, y: 0.0),
			CGPoint(x: 48.5, y: 0.0),
			CGPoint(x: 43.0, y: 0.0),
			CGPoint(x: 38.5, y: 0.0),
			CGPoint(x: 35.5, y: 0.0),
			CGPoint(x: 33.0, y: 1.5),
			CGPoint(x: 30.5, y: 4.0),
			CGPoint(x: 27.5, y: 5.5),
			CGPoint(x: 26.5, y: 8.0),
			CGPoint(x: 26.5, y: 9.0),
		]
		
		self.unistrokeTemplates.append(newTemplate)
	}
}
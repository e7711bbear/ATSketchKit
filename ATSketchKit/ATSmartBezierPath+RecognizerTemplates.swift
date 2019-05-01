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
	
	func loadTemplates() {
		do {
            let pathToTemplates = (Bundle.main.bundlePath) + "/Templates"
	 		let templateFiles = try FileManager.default.contentsOfDirectory(atPath: pathToTemplates)

			for filePath in templateFiles {
				let newTemplate = ATUnistrokeTemplate(json: filePath)
                self.unistrokeTemplates.append(newTemplate)
			}
		} catch {
			print("Error trying to load templates - \(error)")
		}
	}
	
	//	func createCircleTemplates() {
		//		let templateName = "Circle"
		//		let newTemplate = ATUnistrokeTemplate()
		//		newTemplate.name = templateName
		//		newTemplate.recognizedPathWithRect = { (rect: CGRect) -> UIBezierPath in
		//			let maxValue = rect.size.height > rect.size.width ? rect.size.height : rect.size.width
		//			let circleRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: maxValue, height: maxValue)
		//
		//			return UIBezierPath(ovalIn: circleRect)
		//		}
		//		newTemplate.points = [CGPoint(x: 43.5, y: 12.0))
		//			CGPoint(x: 42.5, y: 12.0))
		//			CGPoint(x: 41.0, y: 12.0))
		//			CGPoint(x: 37.0, y: 12.0))
		//			CGPoint(x: 32.5, y: 12.0))
		//			CGPoint(x: 24.5, y: 12.0))
		//			CGPoint(x: 20.0, y: 13.5))
		//			CGPoint(x: 14.0, y: 20.5))
		//			CGPoint(x: 10.0, y: 27.5))
		//			CGPoint(x: 4.0, y: 35.0))
		//			CGPoint(x: 2.5, y: 42.0))
		//			CGPoint(x: 0.0, y: 53.0))
		//			CGPoint(x: 0.0, y: 57.5))
		//			CGPoint(x: 0.0, y: 60.0))
		//			CGPoint(x: 0.0, y: 68.0))
		//			CGPoint(x: 0.0, y: 75.0))
		//			CGPoint(x: 0.0, y: 82.0))
		//			CGPoint(x: 0.0, y: 87.5))
		//			CGPoint(x: 1.0, y: 97.0))
		//			CGPoint(x: 5.0, y: 104.0))
		//			CGPoint(x: 10.5, y: 109.5))
		//			CGPoint(x: 21.0, y: 117.0))
		//			CGPoint(x: 29.5, y: 121.5))
		//			CGPoint(x: 42.0, y: 125.5))
		//			CGPoint(x: 52.0, y: 129.0))
		//			CGPoint(x: 62.0, y: 130.5))
		//			CGPoint(x: 77.0, y: 130.5))
		//			CGPoint(x: 87.0, y: 130.5))
		//			CGPoint(x: 95.5, y: 129.0))
		//			CGPoint(x: 108.0, y: 122.0))
		//			CGPoint(x: 111.0, y: 119.5))
		//			CGPoint(x: 117.5, y: 103.5))
		//			CGPoint(x: 117.5, y: 92.5))
		//			CGPoint(x: 120.0, y: 76.0))
		//			CGPoint(x: 121.5, y: 70.5))
		//			CGPoint(x: 121.5, y: 60.0))
		//			CGPoint(x: 121.5, y: 42.0))
		//			CGPoint(x: 121.5, y: 34.0))
		//			CGPoint(x: 120.5, y: 28.0))
		//			CGPoint(x: 116.5, y: 21.5))
		//			CGPoint(x: 112.5, y: 15.5))
		//			CGPoint(x: 107.0, y: 11.5))
		//			CGPoint(x: 97.0, y: 7.0))
		//			CGPoint(x: 90.0, y: 4.0))
		//			CGPoint(x: 83.0, y: 3.0))
		//			CGPoint(x: 72.5, y: 1.5))
		//			CGPoint(x: 65.5, y: 0.0))
		//			CGPoint(x: 58.5, y: 0.0))
		//			CGPoint(x: 54.0, y: 0.0))
		//			CGPoint(x: 48.5, y: 0.0))
		//			CGPoint(x: 43.0, y: 0.0))
		//			CGPoint(x: 38.5, y: 0.0))
		//			CGPoint(x: 35.5, y: 0.0))
		//			CGPoint(x: 33.0, y: 1.5))
		//			CGPoint(x: 30.5, y: 4.0))
		//			CGPoint(x: 27.5, y: 5.5))
		//			CGPoint(x: 26.5, y: 8.0))
		//			CGPoint(x: 26.5, y: 9.0))
		//		]
		//		
		//		self.unistrokeTemplates.append(newTemplate)
	//}
}

//
//  ATUnistrokeTemplate.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 12/31/15.
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

class ATUnistrokeTemplate: NSObject {
	var name = "Unnamed"
	var points = [CGPoint]()
	
	var recognizedPathWithRect: ((_ rect: CGRect) -> UIBezierPath)!
	
	convenience init(json filePath: String) {
		self.init()
		
		let fileURL = URL(fileURLWithPath: filePath)
		
		do {
			let fileData = try Data(contentsOf: fileURL)
			let jsonObject = try JSONSerialization.jsonObject(with: fileData, options: .mutableContainers) as! Dictionary <String, AnyObject>
			
			self.name = jsonObject["name"] as! String

			let jsonPoints = jsonObject["points"] as! [Dictionary <String, Double>]
			for point in jsonPoints {
				let x = point["x"]!
				let y = point["y"]!

				self.points.append(CGPoint(x: x, y: y))
			}
		} catch {
			// Error handling here if necessary
		}
	}
	
	override var description: String {
		get {
			return self.debugDescription
		}
	}
	
	override var debugDescription: String{
		get {
			return "ATUnistrokeTemplate \n" +
				"Name: \(self.name)\n" +
			"Point: \(self.points)\n" +
			"Clean Path Making Closure: \(self.recognizedPathWithRect)\n"
		}
	}
}

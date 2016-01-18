//
//  ATUnistrokeTemplate.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 12/31/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import UIKit

class ATUnistrokeTemplate: NSObject {
	var name = "Unnamed"
	var points = [CGPoint]()
	
	var recognizedPathWithRect: ((rect: CGRect) -> UIBezierPath)!
	
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

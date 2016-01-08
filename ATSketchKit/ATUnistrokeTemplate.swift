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
}

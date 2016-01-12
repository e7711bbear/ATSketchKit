//
//  ATRecognizedPathResult.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 1/11/16.
//  Copyright © 2016 Arnaud Thiercelin. All rights reserved.
//

import UIKit

class ATRecognizedPathResult: NSObject {
	var center: CGPoint!
	var angle: CGFloat!
	var score: CGFloat!
	var template: ATUnistrokeTemplate!
	var path: UIBezierPath!
}

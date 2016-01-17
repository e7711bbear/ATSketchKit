//
//  ATColorSwatch.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 1/17/16.
//  Copyright © 2016 Arnaud Thiercelin. All rights reserved.
//

import UIKit

/** 
This class allows to show within a view a color
*/
public class ATColorSwatch: UIView {

	public var color: UIColor = UIColor.whiteColor()
	
	public override func drawRect(rect: CGRect) {
		let context = UIGraphicsGetCurrentContext()
		
		color.setFill()
		CGContextFillRect(context, rect)
	}
}

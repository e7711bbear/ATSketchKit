//
//  ATBrushButton.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 1/26/16.
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

import UIKit

@IBDesignable
class ATBrushButton: UIButton {

	var _selectedWidth = CGFloat(1.0)
	@IBInspectable var selectedWidth: CGFloat {
		get {
			return _selectedWidth
		}
		set {
			_selectedWidth = newValue
			self.setNeedsDisplay()
		}
	}
    
    var _selectedColor = UIColor.blue
    @IBInspectable var selectedColor: UIColor {
        get {
            return _selectedColor
        }
        set {
            _selectedColor = newValue
            self.setNeedsDisplay()
        }
    }
	
	override func draw(_ rect: CGRect) {
        let colorPath = UIBezierPath(arcCenter: CGPoint(x: rect.width/2, y: rect.height/2),
            radius: self.selectedWidth/2,
            startAngle: 0,
            endAngle: 7,
            clockwise: true)
		self.selectedColor.setFill()
		colorPath.fill()
		
		let borderPath = UIBezierPath(ovalIn: rect.insetBy(dx: 1.0, dy: 1.0))
		borderPath.lineWidth = 2.0
		UIColor.lightGray.setStroke()
		
		borderPath.stroke()
	}
}

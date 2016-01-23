//
//  ATColorPicker.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 1/17/16.
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

/**
This class provides a basic view to pick a new color using a color map
*/
@IBDesignable
public class ATColorPicker: UIView {

	public var delegate: ATColorPickerDelegate?
	
	public enum ColorSpace {
		case HSV
		case Custom
	}
	
	public var colorSpace = ColorSpace.HSV
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.configure()
	}
	
	func configure() {
		
	}
	
	// MARK: - Drawing
	public override func drawRect(rect: CGRect) {
		self.drawColorMap(rect)
	}
	
	func drawColorMap(rect: CGRect) {
		let context = UIGraphicsGetCurrentContext()
		
		for x in 0..<Int(rect.size.width) {
			for y in 0..<Int(rect.size.height) {
				let point = CGPoint(x: CGFloat(x), y: CGFloat(y))
				let color = colorAtPoint(point, inRect: rect)
				
				color.setFill()
				let rect = CGRectMake(CGFloat(x), CGFloat(y), 1.0, 1.0)
				CGContextFillRect(context, rect)
			}
		}
	}
	
	// MARK: - Event handling
	
	public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		// kickstart the flow.
	}
	
	public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
		let point = touches.first!.locationInView(self)
		let color = self.colorAtPoint(point, inRect: self.bounds)
		
			NSLog("Color At Point[\(point.x),\(point.y)]: \(color)")
		if self.delegate != nil {
			self.delegate!.colorPicker(self, didChangeToSelectedColor: color)
		}
	}
	
	public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		let point = touches.first!.locationInView(self)
		let color = self.colorAtPoint(point, inRect: self.bounds)

		if self.delegate != nil {
			self.delegate!.colorPicker(self, didEndSelectionWithColor: color)
		}
	}
	
	// MARK: - Convenience color methods
	
	func colorAtPoint(point: CGPoint, inRect rect: CGRect) -> UIColor {
		var color = UIColor.whiteColor()
		switch colorSpace {
		case .HSV:
			color = self.hsvColorAtPoint(point, inRect: rect)
		default:
			color = self.customColorAtPoint(point, inRect: rect)
		}
		return color
	}
	
	func customColorAtPoint(point: CGPoint, inRect rect: CGRect) -> UIColor {
		let x = point.x
		let y = point.y
		
		let redValue = (y/rect.size.height + (rect.size.width - x)/rect.size.width) / 2
		let greenValue = ((rect.size.height - y)/rect.size.height + (rect.size.width - x)/rect.size.width) / 2
		let blueValue = (y/rect.size.height + x/rect.size.width) / 2
		let color = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
		
		return color
	}
	
	func hsvColorAtPoint(point: CGPoint, inRect rect: CGRect) -> UIColor {
		return UIColor(hue: point.x/rect.size.width, saturation: point.y/rect.size.height, brightness: 1.0, alpha: 1.0)
	}
	
	public override var description: String {
		get {
			return self.debugDescription
		}
	}
	
	public override var debugDescription: String{
		get {
			return "ATColorPicker \n" +
			"ColorSpace: \(self.colorSpace)\n"
		}
	}
}

//
//  ATColorPicker.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 1/17/16.
//  Copyright © 2016 Arnaud Thiercelin. All rights reserved.
//

import UIKit

/**
This class provides a basic view to pick a new color using a color map
*/
@IBDesignable
public class ATColorPicker: UIView {

	public var delegate: ATColorPickerDelegate?
	
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
				let color = self.colorAtPoint(CGPoint(x: CGFloat(x), y: CGFloat(y)), inRect: rect)
				
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
		let x = point.x
		let y = point.y
		
		let redValue = (y/rect.size.height + (rect.size.width - x)/rect.size.width) / 2
		let greenValue = ((rect.size.height - y)/rect.size.height + (rect.size.width - x)/rect.size.width) / 2
		let blueValue = (y/rect.size.height + x/rect.size.width) / 2
		let color = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
		
		return color
	}
	
}

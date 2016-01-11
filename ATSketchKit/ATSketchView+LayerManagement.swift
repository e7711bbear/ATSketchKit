//
//  LayerDeletion.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 11/26/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import Foundation

extension ATSketchView {
	
	func addShapeLayer(shape: UIBezierPath, lineWidth: CGFloat, color: UIColor) {
		let newShapeLayer = ATShapeLayer()
		
		newShapeLayer.path = shape.CGPath
		newShapeLayer.lineWidth = lineWidth
		newShapeLayer.strokeColor = color.CGColor
		newShapeLayer.fillColor = nil
		newShapeLayer.contentsScale = UIScreen.mainScreen().scale
		
		self.layer.insertSublayer(newShapeLayer, atIndex: 0)
		newShapeLayer.setNeedsDisplay()
	}
	
	func findFrontLayerAtPoint(point: CGPoint) -> ATShapeLayer? {
		for layer in self.layer.sublayers! {
			let hitLayer = layer.hitTest(point)
			
			if hitLayer != nil &&
				hitLayer! is ATShapeLayer {
					return hitLayer as? ATShapeLayer
			}
		}
		return nil
	}
	
	/** 
	Returns the number of shape layers within the layer stack
	*/
	public func shapeLayerCount() -> Int {
		var count = 0
		
		for layer in self.layer.sublayers! {
			if layer is ATShapeLayer {
				count++
			}
		}
		return count
	}
}

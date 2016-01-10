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
		
		newShapeLayer.position = shape.bounds.origin
		newShapeLayer.path = shape.CGPath
		newShapeLayer.lineWidth = lineWidth
		newShapeLayer.strokeColor = color.CGColor
		newShapeLayer.fillColor = color.CGColor
		newShapeLayer.contentsScale = UIScreen.mainScreen().scale
		layer.shouldRasterize = false
		
		self.layer.insertSublayer(newShapeLayer, atIndex: 0)
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
	
	func numberOfEntity() -> Int {
		var count = 0
		
		for layer in self.layer.sublayers! {
			if layer is ATShapeLayer {
				count++
			}
		}
		return count
	}
}

//
//  LayerDeletion.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 11/26/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import Foundation

extension ATSketchView {
	
	func findFrontLayerAtPoint(point: CGPoint) -> ATSShapeLayer? {
		for layer in self.layer.sublayers! {
			let hitLayer = layer.hitTest(point)
			
			if hitLayer != nil &&
				hitLayer! is ATSShapeLayer {
					return hitLayer as? ATSShapeLayer
			}
		}
		return nil
	}
	
	func numberOfEntity() -> Int {
		var count = 0
		
		for layer in self.layer.sublayers! {
			if layer is ATSShapeLayer {
				count++
			}
		}
		return count
	}
}

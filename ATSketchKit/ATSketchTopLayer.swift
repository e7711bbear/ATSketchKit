//
//  ATSketchTopLayer.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 11/26/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import UIKit

class ATSketchTopLayer: CALayer {

	var selectionRect: CGRect!
	
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
	override init() {
		super.init()
		self.configLayer()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(layer: aDecoder)
		self.configLayer()
	}
	
	func configLayer() {
		self.shouldRasterize = false;
		self.selectionRect = CGRectNull;
		self.zPosition = 2;
	}
	
	override func drawInContext(ctx: CGContext) {
		// Drawing code here.
		
		for sublayer in self.superlayer!.sublayers! {
			if sublayer is ATSShapeLayer {
				let shapeSubLayer = sublayer as! ATSShapeLayer
				if shapeSubLayer.isSelected {
					CGContextSaveGState(ctx)
					
					let thePath = CGPathCreateWithRect(sublayer.frame, nil)
					
					CGContextBeginPath(ctx)
					CGContextAddPath(ctx, thePath)
					CGContextSetLineWidth(ctx, 5.0)
					CGContextSetStrokeColorWithColor(ctx, UIColor.redColor().CGColor)
					CGContextStrokePath(ctx)
					
					CGContextRestoreGState(ctx)
				}
				if shapeSubLayer.isHovered {
					CGContextSaveGState(ctx)
					
					let thePath = CGPathCreateWithRect(sublayer.frame, nil)
					
					CGContextBeginPath(ctx)
					CGContextAddPath(ctx, thePath)
					CGContextSetLineWidth(ctx, 3.0)
					CGContextSetStrokeColorWithColor(ctx, UIColor.blueColor().CGColor)
					CGContextStrokePath(ctx)
					
					CGContextRestoreGState(ctx)
				}
			}
		}
		
		if !CGRectIsNull(self.selectionRect) {
			CGContextSaveGState(ctx)
			
			let thePath = CGPathCreateWithRect(self.selectionRect, nil)
			
			CGContextBeginPath(ctx)
			CGContextAddPath(ctx, thePath)
			CGContextSetLineWidth(ctx, 1.0)
			let dashPhase = CGFloat(2.0)
			CGContextSetLineDash(ctx, dashPhase, [5,5], 2)
			
			CGContextSetStrokeColorWithColor(ctx, UIColor.lightGrayColor().CGColor)
			CGContextStrokePath(ctx)
			
			CGContextRestoreGState(ctx)
		}
	}

	override func display() {
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		super.display()
		CATransaction.commit()
	}
	
	override func layoutSublayers() {
		super.layoutSublayers()
	}
}

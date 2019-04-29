//
//  LayerDeletion.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 11/26/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
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

import Foundation
import UIKit
import CoreGraphics

public extension ATSketchView {
	
    func addShapeLayer(_ shape: UIBezierPath, lineWidth: CGFloat, color: UIColor) {
		let newShapeLayer = ATShapeLayer()
		newShapeLayer.path = shape.cgPath
		newShapeLayer.lineWidth = lineWidth
		newShapeLayer.strokeColor = color.cgColor
		newShapeLayer.fillColor = nil
		newShapeLayer.contentsScale = UIScreen.main.scale
        
		self.layer.insertSublayer(newShapeLayer, below: self.topLayer)
    	self.delegate?.sketchViewUpdatedUndoRedoState(self)
        
		newShapeLayer.setNeedsDisplay()
	}
    
    internal func drawBoundsOfSketch(_ shape: UIBezierPath) {
        self.sketchBoundsRectShape.path = shape.cgPath
        self.sketchBoundsRectShape.lineWidth = 3.0
        self.sketchBoundsRectShape.strokeColor = UIColor.black.cgColor
        self.sketchBoundsRectShape.fillColor = nil
        self.sketchBoundsRectShape.contentsScale = UIScreen.main.scale
        self.delegate?.sketchViewUpdatedUndoRedoState(self)
        self.sketchBoundsRectShape.setNeedsDisplay()
        
        self.layer.insertSublayer(self.sketchBoundsRectShape, below: self.topLayer)
        if let sublayers = self.layer.sublayers {
            if sublayers.contains(self.sketchBoundsRectShape) {
                
            } else {
                self.delegate?.sketchViewUpdatedUndoRedoState(self)
                self.sketchBoundsRectShape.setNeedsDisplay()
            }
        } else {
            self.layer.insertSublayer(self.sketchBoundsRectShape, below: self.topLayer)
            self.delegate?.sketchViewUpdatedUndoRedoState(self)
            self.sketchBoundsRectShape.setNeedsDisplay()
        }
        
    }
    
    func addImageLayer(_ image: UIImage, rect: CGRect, lineWidth: CGFloat, color: UIColor) {
        let newImageLayer = CALayer()
        
        newImageLayer.frame = rect
        newImageLayer.contents = image.cgImage
        newImageLayer.borderWidth = lineWidth
        newImageLayer.borderColor = color.cgColor
        newImageLayer.contentsScale = UIScreen.main.scale
        
        // Should insert the photo beneath the most recent drawing but above other photos...
        if let sublayerCount = layer.sublayers?.count {
            if sublayerCount > 2 {
                let newSublayerIndex = UInt32(sublayerCount - 2)
                layer.insertSublayer(newImageLayer, at: newSublayerIndex)
            } else {
                layer.insertSublayer(newImageLayer, below: topLayer)
            }
        } else {
            layer.insertSublayer(newImageLayer, below: topLayer)
        }
        
        delegate?.sketchViewUpdatedUndoRedoState(self)
        pointsBuffer.removeAll()
        clearTopLayer()
        
        // Calling set needs display triggers a UIKit redraw and clears out the image from the layer
        // Thus, it is not necessary to request the layer to request display updates -- the superview should handle this appropriately. Making the setNeedsDisplay() call could result in unintended consequences.
        
        // Send the rectangle over to the delegate for safe-keeping
        if let sizeDelegate = sizingDelegate {
            sizeDelegate.sketchViewUpdatedDrawingBounds(self, drawingBounds: newImageLayer.frame)
        } else {
            self.updatedDrawingBounds(newImageLayer.frame)
        }
    }
	
	/// This method returns the most recently created layer produced by drawing/erasing
    func mostRecentLayer() -> ATShapeLayer? {
        for index in (0..<self.layer.sublayers!.count).reversed() {
			let layer = self.layer.sublayers![index]
			if layer is ATShapeLayer {
				return layer as? ATShapeLayer
			}
		}
		
		return nil
	}
	
	/// Returns the number of shape layers within the layer stack
    func shapeLayerCount() -> Int {
		var count = 0
		
		for layer in self.layer.sublayers! {
			if layer is ATShapeLayer {
				count += 1
			}
		}
		return count
	}
	
    internal func updateTopLayer() {
		let smartPath = ATSmartBezierPath(withPoints: self.pointsBuffer)
		let smoothPath = smartPath.smoothPath(20)
		self.topLayer.lineWidth = self.currentLineWidth
		
		let strokeColor = (self.currentTool == .eraser ? self.eraserColor : self.currentColor)
		self.topLayer.strokeColor = strokeColor.cgColor
		self.topLayer.fillColor = nil
		self.topLayer.contentsScale = UIScreen.main.scale
		
		self.topLayer.path = smoothPath.cgPath
	}
    
    /// Removes all layers and resets the top layer. This will clear the existing canvas.
    func clearAllLayers() {
        for layer in self.layer.sublayers! {
            if layer is ATShapeLayer {
                layer.removeFromSuperlayer()
            }
        }
        clearTopLayer()
        flushRedoHistory()
        self.delegate?.sketchViewUpdatedUndoRedoState(self)
    }
	
    internal func clearTopLayer() {
		self.topLayer.path = nil
	}
}

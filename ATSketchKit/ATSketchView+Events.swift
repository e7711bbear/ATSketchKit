//
//  ATSketchView+Events.swift
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

extension ATSketchView {
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count != 0 else { return }
        
        self.flushRedoHistory()
        changeLog = changeLog + 1
        
        let touchPoint = touches.first!.preciseLocation(in: self)
        updateDrawLayers(touchPoint)
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count != 0 else { return }
        
        let touchPoint = touches.first!.preciseLocation(in: self)
        let rawPoint = touches.first!.preciseLocation(in: self.superview!)
        
        // So, if the touch is outside of the canvas frame, the draw operation is cut short
        if self.frame.contains(rawPoint) == false { 
            touchesEnded(touches, with: event)
            return
        }
        
        updateDrawLayers(touchPoint)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.currentTool == .finger {
            return
        }
        
        self.printTemplateSource(self.pointsBuffer)
        
        if self.pointsBuffer.count == 1 {
            // The user only tapped the canvas (once)
            // We need to draw a single point the size of the touch target
            let touch = touches.first!
            let pointLocation = touch.location(in: self)
            let pointSize = touch.majorRadius
            let newOval = ATSmartBezierPath.init(ovalIn: CGRect.init(x: pointLocation.x, y: pointLocation.y, width: pointSize*2, height: pointSize*2))
            let finalColor = self.currentTool == .eraser ? self.eraserColor : self.currentColor
            self.addShapeLayer(newOval, lineWidth: self.currentLineWidth, color: finalColor)
        } else {
            let smartPath = ATSmartBezierPath(withPoints: self.pointsBuffer)
            var pathAppended = false
            
            if self.currentTool == .smartPencil {
                print("[ATSketchView] Current tool is a smart pencil... rendering...")
                if let recognizedPathInfo = smartPath.recognizedPath() {
                    var recognizedPathIsAccepted = false
                    if self.delegate != nil && self.delegate!.sketchView(self, shouldAccepterRecognizedPathWithScore: recognizedPathInfo.score) == true {
                        recognizedPathIsAccepted = true
                    } else if recognizedPathInfo.score >= 50.0 {
                        recognizedPathIsAccepted = true
                    }
                    
                    if recognizedPathIsAccepted == true {
                        var finalPath = recognizedPathInfo.path
                        if let overridenPath = self.delegate?.sketchViewOverridingRecognizedPathDrawing(self) {
                            finalPath = overridenPath
                        }
                        
                        self.addShapeLayer(finalPath!, lineWidth: self.currentLineWidth, color: self.currentColor)
                        self.delegate?.sketchView(self, didRecognizePathWithName: recognizedPathInfo.template.name)
                        pathAppended = true
                    }
                }
            }
            
            if pathAppended == false {
                let smoothPath = smartPath.smoothPath(20)
                let finalColor = self.currentTool == .eraser ? self.eraserColor : self.currentColor
                self.addShapeLayer(smoothPath, lineWidth: self.currentLineWidth, color: finalColor)
            }
        }
        
        // Calculate final bounds before things get reset, supply one last point
        self.updateDrawBounds(touches.first!.preciseLocation(in: self))
        
        // Send the rectangle over to the delegate for safe-keeping
        if let sizeDelegate = sizingDelegate {
            sizeDelegate.sketchViewUpdatedDrawingBounds(self, drawingBounds: self.rectToSave)
        } else {
            self.updatedDrawingBounds(self.rectToSave)
        }
        
        // Reset the layer and prepare for a new stroke
        self.pointsBuffer.removeAll()
        self.clearTopLayer()
        self.setNeedsDisplay()
        self.layer.setNeedsDisplay()
    }
    
    fileprivate func printTemplateSource(_ points: [CGPoint]) {
        var minX = CGFloat(HUGE)
        var minY = CGFloat(HUGE)
        
        for point in points {
            if point.x < minX {
                minX = point.x
            }
            if point.y < minY {
                minY = point.y
            }
        }
        
//        print("Copy paste the source below:")
//        var sourceCode = "\nnewTemplate.points = ["
//        for point in self.pointsBuffer {
//            sourceCode += "CGPoint(x: \(point.x - minX), y: \(point.y - minY)),\n"
//        }
//        sourceCode += "]"
//        
//        print("\(sourceCode)")
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.currentTool != .finger {
            self.pointsBuffer.removeAll()
        }
    }
    
    fileprivate func updateDrawLayers(_ touchPoint: CGPoint) {
        self.touchDownPoint = touchPoint
        self.lastKnownTouchPoint = touchPoint
        if self.currentTool != .finger {
            self.pointsBuffer.append(touchPoint)
            self.updateDrawBounds(touchPoint)
            self.updateTopLayer()
            self.setNeedsDisplay()
        }
    }
    
    fileprivate func updateDrawBounds(_ touchPoint: CGPoint) {
        // Set the starting point if one doesn't exist
        if self.pointsBuffer.count <= 1 {
            self.initialPoint = touchPoint
            self.minimumPoint = self.initialPoint
            self.maximumPoint = self.initialPoint
        }
        
        // Now, check if the touchPoint's X is less than the minimum X
        if touchPoint.x < self.minimumPoint.x {
            self.minimumPoint.x = touchPoint.x
        }
        
        // Check if the touchPoint's X is more than the maximum X
        if touchPoint.x > self.maximumPoint.x {
            self.maximumPoint.x = touchPoint.x
        }
        
        // Now, check if the touchPoint's Y is less than the minimum Y
        if touchPoint.y < self.minimumPoint.y {
            self.minimumPoint.y = touchPoint.y
        }
        
        // Check if the touchPoint's Y is more than the maximum Y
        if touchPoint.y > self.maximumPoint.y {
            self.maximumPoint.y = touchPoint.y
        }
        
        let drawingRectangle = CGRect.init(x: min(minimumPoint.x, maximumPoint.x), 
                                           y: min(minimumPoint.y, maximumPoint.y), 
                                           width: abs(maximumPoint.x - minimumPoint.x), 
                                           height: abs(maximumPoint.y - minimumPoint.y))
        self.rectToSave = drawingRectangle
    }
}

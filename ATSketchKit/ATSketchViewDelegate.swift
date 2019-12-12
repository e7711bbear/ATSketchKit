//
//  ATSketchViewDelegate.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 1/10/16.
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

import Foundation
import UIKit
import CoreGraphics

// MARK: - Delegate
@objc public protocol ATSketchViewDelegate {

	/**
	Asks the delegate if the score received during the recognition means the view should accept the recognition.
	
	- Parameter sketchView: the view in which the drawing was performed.
	- Parameter score: the recognizing score. Generally speaking, 50.0 is a decent value for it.
	- Returns: a true/false value to determing whether the sketch view should accept the recognition. */
	func sketchView(_ sketchView: ATSketchView, shouldAccepterRecognizedPathWithScore score: CGFloat) -> Bool
	
	/**
	Notifies the delegate that a path has been recognized and added to the layer stack.
	
	- Parameter sketchView: the view in which the recognized drawing happened.
	- Parameter name: the template name which was recognized. */
	func sketchView(_ sketchView: ATSketchView, didRecognizePathWithName name: String) -> Void
	
	/**
	Allows the delegate to override the default clean drawing from the matching template.
	
	- Parameter sketchView: the view in which the drawing was performed
	- Returns: nil if you wish not to override the drawing, otherwise a clean `UIBezierPath` */
	func sketchViewOverridingRecognizedPathDrawing(_ sketchView: ATSketchView) -> UIBezierPath?

	/**
	Notifies the delegate that the canUndo and canRedo states have been updated.
	
	- Parameter sketchView: the view in which the undo/redo states were updated. */
	func sketchViewUpdatedUndoRedoState(_ sketchView: ATSketchView)
}


// MARK: - Sizing Delegate
/** Provides the reciever with an opportunity to update, calculate, and configure the Sketch View's drawing bounds. This area, within the Sketch View's bounds, is used to perform operations on the Sketch View where sizing is important or memory / efficiency is critical. Specifically, this information is used to determine the size of an image returned from the `produceImage` method. 
 
 If this protocol is not implemented anywhere, `ATSketchView` will do its best to calculate appropriate drawing bounds, but results are not guaranteed. */
@objc public protocol ATSketchViewSizingDelegate {
    
    /**
     Notifies the delegate that the bounds for drawings have been updated.
     
     The delegate should maintain a reference to the passed rectangle and return that information when requested. When the  drawing session has concluded, this information helps calculate the final bounds of the drawing. If this method is not properly implemented, calls to `produceImage` may not produce expected results.
     
     - Parameter sketchView: the view in which the drawing bounds were updated.
     - Parameter drawingBounds: the bounds for the most recent stroke on the canvas. */
    func sketchViewUpdatedDrawingBounds(_ sketchView: ATSketchView, drawingBounds: CGRect)
    
    /**
     Requests that the delegate provide the current bounds for drawings on the canvas.
     
     The delegate should return the maintained reference derived from `sketchViewUpdatedDrawingBounds`.
     
     - Parameter sketchView: the view in which the drawing bounds were updated.
     - Returns: The delegate should provide the maintained and updated bounds, based on what was provided in `sketchViewUpdatedDrawingBounds`.
     - Seealso: sketchViewUpdatedDrawingBounds() */
    func sketchViewRequestedDrawingBounds(_ sketchView: ATSketchView) -> CGRect
    
}


// MARK: - Interaction Delegate
/** Notifies the reciever when specific system or hardware interactions occur on the Sketch View. 
 
 If this protocol is not implemented anywhere, system and hardware interactions, including those from Drag & Drop interactions and the Apple Pencil will be ignored. */
@objc public protocol ATSketchViewInteractionDelegate {
    
    /**
     Gives the delegate an opportunity to insert the dropped image on the canvas.
     
     - parameter sketchView: the view in which the drawing bounds were updated.
     - parameter droppedImage: the UIImage dropped onto the sketch view by the user.
     - parameter location: the location in the view's coordinate system at which the image was dropped. */
    @available(iOS 11.0, *)
    func sketchViewRecievedDropImage(_ sketchView: ATSketchView, droppedImage: UIImage, location: CGPoint)
    
    /**
     Notifies the delegate when the user has changed the input tool to an eraser using his or her connected Apple Pencil.
     
     - parameter sketchView: the view in which the drawing bounds were updated.
     - parameter pencil: the Apple Pencil interaction which triggered the event. */
    @available(iOS 12.1, *)
    func sketchViewChangedToolToEraser(_ sketchView: ATSketchView, pencil: UIPencilInteraction)
    
    /**
     Notifies the delegate when the user has requested to revert to the previous input tool using his or her connected Apple Pencil.
     
     - parameter sketchView: the view in which the drawing bounds were updated.
     - parameter pencil: the Apple Pencil interaction which triggered the event. */
    @available(iOS 12.1, *)
    func sketchViewShouldChangeToPreviousTool(_ sketchView: ATSketchView, pencil: UIPencilInteraction)
    
    /**
     Notifies the delegate when the user has requested to open the color palette using his or her connected Apple Pencil.
     
     - parameter sketchView: the view in which the drawing bounds were updated.
     - parameter pencil: the Apple Pencil interaction which triggered the event. */
    @available(iOS 12.1, *)
    func sketchViewShouldDisplayColorPalette(_ sketchView: ATSketchView, pencil: UIPencilInteraction)
    
}


// MARK: - Unimplemented Delgate Extension

internal extension ATSketchView {
    
    func updatedDrawingBounds(_ drawingBounds: CGRect) {
        strokeBounds.append(drawingBounds)
    }
    
    func requestedDrawingBounds() -> CGRect {
        // Never attempt a save if there have been no changes made. This can result in runtime exceptions.
        guard hasHistory == true && strokeBounds.count > 0 else {
            // If there's no history recorded there are two possible scenarios:
            //  A. The user started creating a note and then cancelled, so there's no content
            //  B. The user was only viewing a note and made no changes
            // In case A we should return a generic CGRect object
            // In case B we should return the original CGRect
            
            if self.hasContent == true {
                // Case B
                return originalStrokeBounds
            } else {
                // Case A
                return self.frame
            }
        }
        
        // Loop through rectangles and form unions between all of them
        var unionizedRectangle = strokeBounds[0]
        for nextRectangle in strokeBounds {
            unionizedRectangle = unionizedRectangle.union(nextRectangle)
        }
        
        return unionizedRectangle
    }
}

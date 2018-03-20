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

public protocol ATSketchViewDelegate {

	/**
	Asks the delegate if the score received during the recognition means the view should accept the recognition.
	
	- Parameter sketchView: the view in which the drawing was performed
	- Parameter score: the recognizing score. Generally speak, 50.0 is a decent value for it.
	- Returns: a true/false value.
	*/
	func sketchView(_ sketchView: ATSketchView, shouldAccepterRecognizedPathWithScore score: CGFloat) -> Bool
	
	/**
	Notifies the delegate that a path has been recognized and added to the layer stack.
	
	- Parameter sketchView: the view in which the recognized drawing happened.
	- Parameter name: the template name which was recognized.
	*/
	func sketchView(_ sketchView: ATSketchView, didRecognizePathWithName name: String) -> Void
	
	/**
	Allows the delegate to override the default clean drawing from the matching template.
	
	- Parameter sketchView: the view in which the drawing was performed
	- Returns: nil if you wish not to override the drawing, otherwise a clean UIBezierPath
	*/
	func sketchViewOverridingRecognizedPathDrawing(_ sketchView: ATSketchView) -> UIBezierPath?

	/**
	Notifies the delegate that the canUndo and canRedo states have been updated.
	
	- Parameter sketchView: the view in which the undo/redo states were updated.
	*/
	func sketchViewUpdatedUndoRedoState(_ sketchView: ATSketchView)
}

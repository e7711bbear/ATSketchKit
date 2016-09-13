//
//  ATSketchView.swift
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

import UIKit

@IBDesignable
public class ATSketchView: UIView {

	public var delegate: ATSketchViewDelegate?
    
    public enum Tools {
        // TODO: Implement the Finger tool
        case finger
        case pencil
        case smartPencil
        case eraser
    }
	
	/**
	The tool to be used in the next drawing event. Should be set by the controller owning the sketchview
	
	**Finger** is currently inactive, but intended to become a moving tool
	
	**Pencil** is the basic tool
	
	**SmartPencil** is tied to the unistroke recognizer
	
	**Eraser** is self explanatory.
     
	*/
    public var currentTool: Tools = .pencil
	
	/**
	The thickness of the line to be drawn. Should be set by the controller owning the sketchview
	
	Defaults to 1.0
	*/
	public var currentLineWidth: CGFloat = 1.0

	/** 
	The color of the line to be drawn. Should be set by the controller owning the sketchview
	
	Defaults to black
	*/
	public var currentColor: UIColor = UIColor.black

	var eraserColor: UIColor {
		get {
			return self.backgroundColor != nil ? self.backgroundColor! : UIColor.white
		}
	}
	
	var touchDownPoint: CGPoint!
	var lastKnownTouchPoint: CGPoint!
	
	var topLayer: ATSketchTopLayer!
	
	var pointsBuffer = [CGPoint]()
	
	// Undo/Redo
	var history = [CALayer]()
	public var allowUndoRedo = true
	public var maxUndoRedoSteps = 30
	// TODO: Implement a max count for these for memory-purpose.
	
	public var canUndo: Bool {
		get {
      return allowUndoRedo && (self.layer.sublayers?.count)! > 1
		}
	}
	
	/** 
	Tells if the sketchview is capable of doing a redo in the future

	Useful to enable undo controls on the controllers
	*/
	
	public var canRedo: Bool {
		get {
			return allowUndoRedo && self.history.count > 0
		}
	}
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureView()
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.configureView()
	}
	
	func configureView() {
		// Insert customization & init here
		self.topLayer = ATSketchTopLayer()
		self.topLayer.fillColor = nil
		self.layer.addSublayer(self.topLayer)
	}
	
	public override func draw(_ rect: CGRect) {
		super.draw(rect)
		
	}
	
	/**
	Produces an image with the current visible content and returns it.
	*/
	
	public func produceImage() -> UIImage {
		UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)
		self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return image!
	}
	
	// MARK: - Description & DebugDescription
	public override var description: String {
		get {
			return self.debugDescription
		}
	}
	
	public override var debugDescription: String{
		get {
			return "ATSmartBezierPath \n" +
				"Current Tool: \(self.currentTool)\n" +
				"Current Line Width: \(self.currentLineWidth)\n" +
				"Current Color: \(self.currentColor)\n"
		}
	}
}

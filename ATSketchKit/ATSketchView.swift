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
import Foundation

@IBDesignable public class ATSketchView: UIView {
	
    
    // MARK: - Delegates
    
	@IBOutlet public var delegate: ATSketchViewDelegate?
    @IBOutlet public var sizingDelegate: ATSketchViewSizingDelegate?
    @IBOutlet public var interactionDelegate: ATSketchViewInteractionDelegate?
	
    
    // MARK: - Properties
    
    public enum Tools: Int {
		case finger // Finger tool not implemented
		case pencil
		case smartPencil
		case eraser
	}
	
	/** The tool to be used in the next drawing event. Should be set by the controller owning the sketchview
    - **Finger** is currently inactive, but intended to become a moving tool   
    - **Pencil** is the basic tool   
    - **SmartPencil** is tied to the unistroke recognizer   
    - **Eraser** is self explanatory. */
    public var currentTool: Tools = .pencil {
        didSet {
            if currentTool == .finger {
                print("WARNING: ATSketchView finger tool is not implemented.")
            }
        }
    }
	
	/// The thickness of the line to be drawn. Should be set by the controller owning the SketchView. Defaults to 1.0 
	public var currentLineWidth: CGFloat = 1.0
	
	/// The color of the line to be drawn. Should be set by the controller owning the SketchView. Defaults to black.
	public var currentColor: UIColor = UIColor.black
	
	internal var touchDownPoint: CGPoint!
	internal var lastKnownTouchPoint: CGPoint!
	
	internal var topLayer: ATSketchTopLayer!
	
	internal var pointsBuffer = [CGPoint]()
    internal var initialPoint: CGPoint = CGPoint.init(x: 0, y: 0)
    internal var minimumPoint: CGPoint = CGPoint.init(x: 0, y: 0)
    internal var maximumPoint: CGPoint = CGPoint.init(x: 0, y: 0)
    internal var rectToSave: CGRect = CGRect.init()
    internal var sketchBoundsRectShape: ATShapeLayer = ATShapeLayer()
    internal static let sketchPaddingBuffer: CGFloat = 30
    
    /** Instantaneous, momentary history containing the sketch layers.  

    Maintains, for a brief time, each individual layer from the user's most recent stroke points.  
    - warning: This array is frequently modified and its contents discarded, thus is an unreliable indicator of actual user-facing changes. 
    - seealso: changeLog */
	internal var history = [CALayer]()
    
    /** Maintains a running tally of the forward-moving changes made by the user.  
     
    Each time the user makes an additive change (anything except an undo) this value increases by one. 
    - warning: This should not be used for internal calculations of layer history or drawing. 
    - seealso: history */
    internal var changeLog = 0
    
    /// Should the Sketch View allow undo and redo operations.
	public var allowUndoRedo = true
    /// If `allowUndoRedo` is set to true, the number of undo and redo operations that may be kept in memory.
	public var maxUndoRedoSteps = 30
    
    internal var strokeBounds = [CGRect]()
    internal var originalStrokeBounds: CGRect = CGRect.init()
	
    // MARK: Computed properties
    
    // The "eraser" is simply a brush that matches the solid background color
    internal var eraserColor: UIColor {
        get {
            return self.backgroundColor != nil ? self.backgroundColor! : UIColor.white
        }
    }
    
    /// Value used to determine if changes have been made to the canvas since opening.
    public var hasHistory: Bool {
        get {
            if changeLog > 0 {
                return true
            } else {
                return false
            }
        }
    }
    
    /// Value used to determine if the canvas has content, irrespective of its history.
    public var hasContent: Bool {
        get {
            if self.layer.sublayers?.count ?? 0 > 1 {
                return true
            } else {
                return false
            }
        }
    }
    
    /// Tells if the sketchview is capable of doing an undo in the future
	public var canUndo: Bool {
		get {
			return allowUndoRedo && self.layer.sublayers?.count ?? 0 > 1 && self.history.count <= self.maxUndoRedoSteps
		}
	}
	
	/// Tells if the sketchview is capable of doing a redo in the future
	public var canRedo: Bool {
		get {
			return allowUndoRedo && self.history.count > 0
		}
	}
	
    /// Calculates the bounds of the sketched area
    public var sketchBounds: CGRect {
        get {
            var finalBounds: CGRect
            if let boundsForImage = self.sizingDelegate?.sketchViewRequestedDrawingBounds(self) {
                finalBounds = CGRect.init(x: boundsForImage.origin.x - (ATSketchView.sketchPaddingBuffer / 2), y: boundsForImage.origin.y - (ATSketchView.sketchPaddingBuffer / 2), width: boundsForImage.width + ATSketchView.sketchPaddingBuffer, height: boundsForImage.height + ATSketchView.sketchPaddingBuffer)
            } else {
                let boundsForImage = self.requestedDrawingBounds()
                finalBounds = CGRect.init(x: boundsForImage.origin.x - (ATSketchView.sketchPaddingBuffer / 2), y: boundsForImage.origin.y - (ATSketchView.sketchPaddingBuffer / 2), width: boundsForImage.width + ATSketchView.sketchPaddingBuffer, height: boundsForImage.height + ATSketchView.sketchPaddingBuffer)
            }
            return finalBounds
        }
    }
    
    
    // MARK: - Lifecycle
    
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureView()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.configureView()
	}
	
	fileprivate func configureView() {
        print("[ATSketchView] Configuring view...")
		// Insert customization & init here
		self.topLayer = ATSketchTopLayer()
		self.topLayer.fillColor = nil
        self.layer.masksToBounds = true
		self.layer.addSublayer(self.topLayer)
        
        self.originalStrokeBounds = self.frame
        
        if #available(iOS 11.0, *) {
            let dropInteraction = UIDropInteraction(delegate: self)
            self.addInteraction(dropInteraction)
        }
        
        if #available(iOS 12.1, *) {
            let pencilInteraction = UIPencilInteraction()
            pencilInteraction.delegate = self
            pencilInteraction.isEnabled = true
            self.addInteraction(pencilInteraction)
        }
	}
	
    
    // MARK: - Rastering
    
	/** Produces an image with the current visible content and returns it. */
	public func produceImage() -> UIImage {
        print("[ATSketchView] Producing image...")
        let finalBounds = sketchBounds
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        if let layerSnapshot = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            
            // UIImages are measured in points, but CGImages are measured in pixels
            let scaleFactor = UIScreen.main.scale
            let scaledRect = finalBounds.applying(CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))
            
            if let imageReference = layerSnapshot.cgImage?.cropping(to: scaledRect) {
                let image = UIImage.init(cgImage: imageReference)
                return image
            }
        }
        
        
        return UIImage()
    }
    
    
	// MARK: - Description & DebugDescription
    
	public override var description: String {
		get {
			return self.debugDescription
		}
	}
	
	public override var debugDescription: String {
		get {
            return "Size: \(self.frame)\n" + "Current Tool: \(self.currentTool)\n" + "Current Line Width: \(self.currentLineWidth)\n" + "Current Color: \(self.currentColor)\n"
		}
	}
}

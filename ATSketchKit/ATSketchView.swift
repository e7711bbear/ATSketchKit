//
//  ATSketchView.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 11/26/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import UIKit

@IBDesignable
public class ATSketchView: UIView {

	public var delegate: ATSketchViewDelegate?
	
	public enum Tools {
		case Finger
		case Pencil
	}
	public var currentTool: Tools = .Pencil
	
	public enum Actions {
		case Select
		case Move
		case Draw
	}
	public var currentAction: Actions = .Draw
	
	public var currentLineWidth: CGFloat = 1.0
	
	public var currentColor: UIColor = UIColor.greenColor()
	
	var touchDownPoint: CGPoint!
	var lastKnownTouchPoint: CGPoint!
	
	var topLayer: ATSketchTopLayer!
	
	public var recognizeDrawing: Bool = false
	
	var pointsBuffer = [CGPoint]()
	
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
	}
	
	public override func drawRect(rect: CGRect) {
		let smartPath = ATSmartBezierPath(withPoints: pointsBuffer)
		let smoothPath = smartPath.smoothPath(20)
		
		self.currentColor.setStroke()
		smoothPath.lineWidth = currentLineWidth
		smoothPath.stroke()
		
		super.drawRect(rect)
	}
	
	public func produceImage() -> UIImage {
		UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)
		self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return image
	}
}

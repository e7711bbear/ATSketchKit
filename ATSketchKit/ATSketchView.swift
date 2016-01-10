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

	var delegate: ATSketchViewDelegate?
	
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
	
	var touchDownPoint: CGPoint!
	var lastKnownTouchPoint: CGPoint!
	
	var topLayer: ATSketchTopLayer!
	
	public var recognizeDrawing: Bool = false
	
	var pointsBuffer = [CGPoint]()
	
	var pathLayers = [UIBezierPath]()
	
	public override func drawRect(rect: CGRect) {
		let smartPath = ATSmartBezierPath(withPoints: pointsBuffer)
		let smoothPath = smartPath.smoothPath(20)
		
		UIColor.redColor().setStroke()
		smoothPath.lineWidth = 1
		smoothPath.stroke()
		
		for path in pathLayers {
			UIColor.greenColor().setStroke()
			path.lineWidth = 1
			path.lineCapStyle = .Round
			path.stroke()
		}
	}

}

//
//  ATSketchView+UndoRedo.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 1/15/16.
//  Copyright © 2016 Arnaud Thiercelin. All rights reserved.
//

import Foundation

extension ATSketchView {
	
	public func undo() {
		let mostRecentLayer = self.mostRecentLayer()
		
		if mostRecentLayer != nil {
			self.history.append(mostRecentLayer!)
			mostRecentLayer!.removeFromSuperlayer()
		}
		self.setNeedsDisplay()
	}
	
	public func redo() {
		let mostRecentUndoLayer = self.history.last
		
		if mostRecentUndoLayer != nil {
			self.layer.addSublayer(mostRecentUndoLayer!)
			self.history.removeLast()
		}
		self.setNeedsDisplay()
	}
	
}

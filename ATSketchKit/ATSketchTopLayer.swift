//
//  ATSketchTopLayer.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 11/26/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import UIKit

class ATSketchTopLayer: CAShapeLayer {

	override init() {
		super.init()
		self.configLayer()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(layer: aDecoder)
		self.configLayer()
	}
	
	func configLayer() {
	}
	
}

//
//  ATSShapeLayer.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 11/26/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import UIKit

class ATSShapeLayer: CAShapeLayer {
	var isSelectable = false;
	var isSelected = false;
	var isHovered = false;
	
	override init () {
		super.init()
		self.configLayer()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.configLayer()
	}
	
	func configLayer() {
		self.masksToBounds = true
	}
	
}

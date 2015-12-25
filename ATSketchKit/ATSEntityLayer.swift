//
//  ATSEntityLayer.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 11/26/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import UIKit

class ATSEntityLayer: ATSShapeLayer {

	var relations = [ATSRelationLayer]()

	override init() {
		super.init()
		self.configLayer()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.configLayer()
	}
	
	override func configLayer() {
		self.bounds = CGRectMake(0, 0, 60, 60);
		self.path = CGPathCreateWithRect(self.bounds, nil);
		self.fillColor = CGColorCreate(nil, nil)
		self.shouldRasterize = false;
		self.isSelectable = true;
		self.zPosition = 1;
	}
	
}

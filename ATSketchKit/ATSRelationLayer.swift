//
//  ATSRelationLayer.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 11/26/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import UIKit

class ATSRelationLayer: ATSShapeLayer {

	weak var entityA: ATSEntityLayer!
	weak var entityB: ATSEntityLayer!
	var flowsAtoB = false
	var flowsBtoA = false
	
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
		self.shouldRasterize = false;
		self.isSelectable = false;
		self.zPosition = 0;
	}
}

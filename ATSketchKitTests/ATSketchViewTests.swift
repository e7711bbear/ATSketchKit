//
//  ATSketchViewTests.swift
//  ATSketchViewTests
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

import XCTest
@testable import ATSketchKit

class ATSketchViewTests: XCTestCase {
	var sketchView: ATSketchView!
	
    override func setUp() {
        super.setUp()

		self.sketchView = ATSketchView()
	}
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testEraserColor() {
		self.sketchView.backgroundColor = nil
		
		var eraserColor = self.sketchView.eraserColor
		
		XCTAssertEqual(eraserColor, UIColor.whiteColor())
		
		self.sketchView.backgroundColor = UIColor.redColor()
		
		eraserColor = self.sketchView.eraserColor
		
		XCTAssertEqual(eraserColor, UIColor.redColor())
	}
	
	func testCanUndo() {
		//TODO: Implement
	}
	
	func testCanRedo() {
		//TODO: Implement
	}
	
	func testTopLayerCreation() {
		XCTAssertNotNil(self.sketchView.topLayer)
	}
	
	func testAddShaperLayer() {
		//TODO: Implement	
	}
	
	func testMostRecentLayer() {
		//TODO: Implement
	}
	
	func testShaperLayerCount() {
		//TODO: Implement
	}
	
	func testUndo() {
		//TODO: Implement
	}
	
	func testRedo() {
		//TODO: Implement
	}
}

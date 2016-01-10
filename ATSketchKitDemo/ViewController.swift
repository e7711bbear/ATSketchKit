//
//  ViewController.swift
//  ATSketchKitDemo
//
//  Created by Arnaud Thiercelin on 12/24/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import UIKit
import ATSketchKit

class ViewController: UIViewController {

	var sketchView: ATSketchView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.sketchView = self.view as! ATSketchView
		self.sketchView.recognizeDrawing = true
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	// MARK: Tools controls
	
	@IBAction func selectFinger(sender: AnyObject) {
		self.sketchView.currentTool = .Finger
	}

	@IBAction func selectPencil(sender: AnyObject) {
		self.sketchView.currentTool = .Pencil
	}
	
	@IBAction func recognizePath(sender: AnyObject) {
		self.sketchView.recognizeDrawing = !self.sketchView.recognizeDrawing
	}
}


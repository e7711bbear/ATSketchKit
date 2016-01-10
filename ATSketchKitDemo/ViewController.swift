//
//  ViewController.swift
//  ATSketchKitDemo
//
//  Created by Arnaud Thiercelin on 12/24/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//

import UIKit
import ATSketchKit

class ViewController: UIViewController, ATSketchViewDelegate {

	var sketchView: ATSketchView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.sketchView = self.view as! ATSketchView
		self.sketchView.recognizeDrawing = true
		self.sketchView.delegate = self
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
	
	@IBAction func lineWidthSliderChanged(sender: UISlider) {
		let sliderValue = sender.value
		
		self.sketchView.currentLineWidth = CGFloat(sliderValue)
	}
	
	// MARK: - ATSketchViewDelegate
	
	func sketchView(sketchView: ATSketchView, shouldAccepterRecognizedPathWithScore score: CGFloat) -> Bool {
		if score >= 60 {
			return true
		}
		return false
	}
}


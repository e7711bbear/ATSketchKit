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

	@IBOutlet weak var sketchView: ATSketchView!
	@IBOutlet weak var controlPanel: ControlPanelView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.sketchView.recognizeDrawing = false
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

	@IBAction func selectEraser(sender: AnyObject) {
		self.sketchView.currentTool = .Eraser
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
	
	@IBAction func undo(sender: UIButton) {
		self.sketchView.undo()
	}
	
	@IBAction func redo(sender: UIButton) {
		self.sketchView.redo()
	}
	
	// MARK: - ATSketchViewDelegate
	
	func sketchView(sketchView: ATSketchView, shouldAccepterRecognizedPathWithScore score: CGFloat) -> Bool {
		if score >= 60 {
			return true
		}
		return false
	}
	
	func sketchView(sketchView: ATSketchView, didRecognizePathWithName name: String) {
		// We don't want to do anything here.
	}
}


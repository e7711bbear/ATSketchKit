//
//  ViewController.swift
//  ATSketchKitDemo
//
//  Created by Arnaud Thiercelin on 12/24/15.
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

import UIKit
import ATSketchKit

class ViewController: UIViewController, ATSketchViewDelegate, ATColorPickerDelegate {

	@IBOutlet weak var sketchView: ATSketchView!
    
	@IBOutlet weak var controlPanel: ATControlPanelView!
	@IBOutlet weak var colorPicker: ATColorPicker!
    @IBOutlet weak var lineWidthSlider: UISlider!
    @IBOutlet weak var brushButton: ATBrushButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.sketchView.delegate = self
		self.colorPicker.delegate = self
        
        configureControls()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    
    func configureControls() {
        self.brushButton.selectedColor = self.sketchView.currentColor
        self.brushButton.selectedWidth = self.sketchView.currentLineWidth
        self.lineWidthSlider.value = Float(self.sketchView.currentLineWidth)
        
        let newButton = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: "newCanvas")
        self.navigationItem.leftBarButtonItem = newButton
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "share")
        self.navigationItem.rightBarButtonItem = shareButton
    }

	// MARK: Tools controls
    
    @IBAction func selectBrush(sender: AnyObject) {
        self.controlPanel.toggleShowDetails()
    }
    
	@IBAction func selectFinger(sender: AnyObject) {
		self.sketchView.currentTool = .Finger
	}

	@IBAction func selectEraser(sender: AnyObject) {
		self.sketchView.currentTool = .Eraser
	}
	
	@IBAction func selectPencil(sender: AnyObject) {
		self.sketchView.currentTool = .Pencil
	}
	
	@IBAction func selectSmartPencil(sender: AnyObject) {
		self.sketchView.currentTool = .SmartPencil
	}
	
	@IBAction func lineWidthSliderChanged(sender: UISlider) {
		let sliderValue = sender.value
		
		self.sketchView.currentLineWidth = CGFloat(sliderValue)
        self.brushButton.selectedWidth = CGFloat(sliderValue)
	}
	
	@IBAction func undo(sender: UIButton) {
		self.sketchView.undo()
	}
	
	@IBAction func redo(sender: UIButton) {
		self.sketchView.redo()
	}
    
    func newCanvas() {
        self.sketchView.clearAllLayers()
    }
    
    func share() {
        let shareController = UIActivityViewController(activityItems: [self.sketchView.produceImage()], applicationActivities: nil)
        self.presentViewController(shareController, animated: true, completion: nil)
    }
	
	// MARK: - ATSketchViewDelegate
	
	func sketchView(sketchView: ATSketchView, shouldAccepterRecognizedPathWithScore score: CGFloat) -> Bool {
		NSLog("Score: \(score)")
		if score >= 60 {
			NSLog("ACCEPTED")
			return true
		}
		NSLog("REJECTED")
		return false
	}
	
	func sketchView(sketchView: ATSketchView, didRecognizePathWithName name: String) {
		// We don't want to do anything here.
	}
	
	//MARK: - ATColorPickerDelegate
	
	func colorPicker(colorPickerView: ATColorPicker, didChangeToSelectedColor color: UIColor) {
		self.sketchView.currentColor = color
        self.brushButton.selectedColor = color
	}
	
	func colorPicker(colorPickerView: ATColorPicker, didEndSelectionWithColor color: UIColor) {
		self.sketchView.currentColor = color
        self.brushButton.selectedColor = color
	}
	
	func sketchViewOverridingRecognizedPathDrawing(sketchView: ATSketchView) -> UIBezierPath? {
		return nil
	}

}


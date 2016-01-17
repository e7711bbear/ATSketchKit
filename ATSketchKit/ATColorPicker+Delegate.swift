//
//  ATColorPicker+Delegate.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 1/17/16.
//  Copyright © 2016 Arnaud Thiercelin. All rights reserved.
//

import Foundation

public protocol ATColorPickerDelegate {
	
	/**
	This method is called everytime a new color is selected.
	*/
	func colorPicker(colorPickerView: ATColorPicker, didChangeToSelectedColor: UIColor)
	
	/**
	This method is call once the user stops touching the screen
	*/
	func colorPicker(colorPickerView: ATColorPicker, didEndSelectionWithColor: UIColor)
}
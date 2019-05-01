//
//  ATSketchView+Pencil.swift
//  ATSketchKit
//
//  Created by Sam Spencer on 4/25/19.
//  Copyright © 2019 Sam Spencer. All rights reserved.
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
import Foundation
import UIKit

@available(iOS 12.1, *)
extension ATSketchView: UIPencilInteractionDelegate {
    
    public func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
        switch UIPencilInteraction.preferredTapAction {
        case .switchEraser:
            if self.currentTool == .eraser {
                self.interactionDelegate?.sketchViewShouldChangeToPreviousTool(self, pencil: interaction)
            } else {
                self.currentTool = .eraser
                self.interactionDelegate?.sketchViewChangedToolToEraser(self, pencil: interaction)
            }
            break
        case .switchPrevious:
            self.interactionDelegate?.sketchViewShouldChangeToPreviousTool(self, pencil: interaction)
            break
        case .showColorPalette:
            self.interactionDelegate?.sketchViewShouldDisplayColorPalette(self, pencil: interaction)
            break
        case .ignore:
            break
        default:
            break
        }
    }
    
}

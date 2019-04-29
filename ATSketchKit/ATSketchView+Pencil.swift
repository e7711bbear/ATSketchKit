//
//  ATSketchView+Pencil.swift
//  ATSketchKit
//
//  Created by Sam Spencer on 4/25/19.
//  Copyright © 2019 Sam Spencer. All rights reserved.
//

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

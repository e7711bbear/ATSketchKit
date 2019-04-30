//
//  ATSketchView+Drop.swift
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
import CoreGraphics

@available(iOS 11.0, *)
extension ATSketchView: UIDropInteractionDelegate {
    
    public func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool { 
        return session.canLoadObjects(ofClass: UIImage.self) && session.items.count == 1
    }
    
    public func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let dropLocation = session.location(in: self)
        
        // Perform UI Updates as needed
        // updateLayers(forDropLocation: dropLocation)
        
        let operation: UIDropOperation
        
        if self.frame.contains(dropLocation) {
            operation = .copy
        } else {
            operation = .cancel
        }
        
        return UIDropProposal(operation: operation)
    }
    
    public func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        // Consume drag items (in this example, of type UIImage).
        session.loadObjects(ofClass: UIImage.self) { imageItems in
            guard let images = imageItems as? [UIImage] else { return }
            guard let image = images.first else { return }
            let dropLocation = session.location(in: self)
            self.interactionDelegate?.sketchViewRecievedDropImage(self, droppedImage: image, location: dropLocation)
        }
        
        // Perform additional UI updates as needed.
        // updateLayers(forDropLocation: dropLocation)
    }
}

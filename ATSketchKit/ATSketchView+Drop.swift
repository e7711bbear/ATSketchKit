//
//  ATSketchView+Drop.swift
//  ATSketchKit
//
//  Created by Sam Spencer on 4/25/19.
//  Copyright © 2019 Sam Spencer. All rights reserved.
//

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

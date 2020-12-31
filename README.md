# ATSketchKit 0.1
ATSketchKit is a drawing / sketching framework for iOS written in Swift.

It can be used as the foundation for an artistic app, a simple signature feature or more inteligent graph designing app.

## Quick Look 
If you want to have a quick look at the framework in action, you can [download](https://itunes.apple.com/us/app/sketchalicious/id1082917478?ls=1&mt=8) **Sketchalicious** from the AppStore. Sketchalicious is the exact same demo app as available from this source code simply built and publish on the store, just so that you won't have to sideload it to try the framework.

## Intentions & License
My intentions with this framework are to enable people to produce more drawing apps on iOS, give my two cents worth of examples on how to code in Swift on iOS and ignite the conversation and contributions around this particular technology (especially around pattern recognitions & and visual smoothing)

This project is completely open source and under the MIT license. So enjoy and have fun. For full details please see [license.md](LICENSE.md)

## Installation
You may add ATSketchKit to your project using CocoaPods or manually.

### CocoaPods
Add the following to your Podfile:  

    pod 'ATSketchKit'
    
### Manually
Build the ATSketchKit Framework and then copy and include it in your project as a dynamic framework. Alternatively, you may also copy the source files in the ATSketchKit folder to your project.

## Getting Started
Integrating ATSketchKit with your project should be fairly quick, depending on the level of complexity.

### Content
ATSketchKit contains:
- The ATSketchKit Framework which holds all you need to start drawing
- The ATSketchKit Demo app which shows an example on how to use the framework.
- Unit and UI Tests.

### Setup
1. Start by adding an `ATSketchView` wherever drawing operations are needed. The `ATSketchView`  object conforms to `@IBDesignable` and can be subclassed, so feel free to add it via Interface Builder and  / or make customizations in your own subclass.  
2. The controller responsible for managing your instance of  `ATSketchView` could do the following bare bones setup: 

        sketchView.delegate = self
        
        // None of these properties are required as they all have default values, but they are customizable
        sketchView.currentColor = .black
        sketchView.currentLineWidth = 5.0
        sketchView.currentTool = .pencil
        
3. Implement the `ATSketchViewDelegate` protocol

Check out the demo app included in the project for a hands-on demo of some of the basic features and setup.

## Features
ATSketchKit has extensive code documentation that will help you take advantage of its features. Below is a quick highlight of some key features.

#### Tools
You can change the tool type using the `currentTool` property and specifying either the `pencil`, `eraser`, `finger` (not yet implemented), or `smartPencil`.

#### Line Style
You can change the line width for the current tool using the `currentLineWidth` property. Set the color using the `currentColor` property.

#### Undo, Redo & Clearing
Check if the sketch view can perform undo or redo operations using the `canUndo` and `canRedo` properties. `hasHistory` can be used to quickly determine if the sketch view has any history recorded in the undo / redo stack. Use `hasContent` to check if the sketch view currently has content rendered (i.e. is not blank) regardless of undo / redo state.

If the sketch view can perform an undo or redo, call `undo()` or `redo()` respectively. If you need to clear future redo history use `flushRedoHistory()`.

To  completely clear and reset the sketch view (including undo / redo history) call `clearAllLayers()`.

#### Rastering
Render a raster image of the current sketch view content using `produceImage()`. This method returns a `UIImage` object representing content that is inside the `sketchBounds` property. The scale of the image is based on the current device's screen scale. Operation is synchronous (keep that in mind when calling!).

#### Inserting Images & Shapes
Although the Smart Pencil tool can be used to notify the delegate that a shape has been detected and should be inserted, you may use the `addShapeLayer(_ shape: UIBezierPath, lineWidth: CGFloat, color: UIColor)` method to insert a shape using a `UIBezierPath`.

Similarly, you may insert an image onto the canvas using `addImageLayer(_ image: UIImage, rect: CGRect, lineWidth: CGFloat, color: UIColor)`. See below for iOS 11 Drag & Drop support with `UIImage` objects.

Both image and shape insertion operations are added to the undo / redo stack.

**NOTICE**: If you perform either of these functions, you should implement the `ATSketchViewSizingDelegate` and set the `sizingDelegate` to provide correct updated bounds when inserting images and shapes. Once you implement this delegate you'll need to keep track of the view's `sketchBounds` on your own, as that get-only property will then return information gleaned from the delegate.

#### Drag & Drop Support  (iOS 11+)
The `ATSketchView` accepts image drops using a `UIDropInteraction` on iOS 11.0 and higher. To respond to and accept image drops from the system, implement the `ATSketchViewInteractionDelegate` protocol and set the sketch view's `interactionDelegate`. The `sketchViewRecievedDropImage(_ sketchView: ATSketchView, droppedImage: UIImage, location: CGPoint)` method provides all the information you need to tell the sketch view how to render the supplied image. See above for how to insert an image on to the canvas.

#### Apple Pencil Support  (iOS 12.1+)
The `ATSketchView` conforms `UIPencilInteraction` on iOS 12.1 and higher in order to respond to basic Apple Pencil interactions. To respond to and accept interactions from an Apple Pencil, implement the `ATSketchViewInteractionDelegate` protocol and set the sketch view's `interactionDelegate`. The following methods provide information about Pencil interaction:

    sketchViewChangedToolToEraser(_ sketchView: ATSketchView, pencil: UIPencilInteraction)
    sketchViewShouldChangeToPreviousTool(_ sketchView: ATSketchView, pencil: UIPencilInteraction)
    sketchViewShouldDisplayColorPalette(_ sketchView: ATSketchView, pencil: UIPencilInteraction)
    
**NOTICE**: You do not need to implement this delegate if you only require basic Apple Pencil support (i.e. drawing) -- that is automatically handled and no extra work needs to be donein order to accept Apple Pencil touches / drawing. This delegate is specifically for supplemental Pencil actions (i.e. Double Tap to change tool or open color picker, etc.)

### Roadmap
To know what I currently intend to add to this app or to submit feature requests, please check out the github issues.

## Questions & Contact
If you have any questions, reach out to me on twitter [@e7711b](https://twitter.com/e7711b) or drop an issue on github.

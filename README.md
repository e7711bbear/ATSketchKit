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

## Roadmap
To know what I currently intend to add to this app or to submit feature requests, please check out the github issues.

## Questions & Contact
If you have any questions, reach out to me on twitter [@athiercelin](https://twitter.com/athiercelin) or drop an issue on github.

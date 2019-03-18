import Cocoa
import AppKit
import PlaygroundSupport
import Foundation
import SpriteKit

var str = "Hello, playground"

let nibFile = NSNib.Name("View")
var topLevelObjects : NSArray?

Bundle.main.loadNibNamed(nibFile, owner:nil, topLevelObjects: &topLevelObjects)
let views = (topLevelObjects as! Array<Any>).filter { $0 is NSView }
PlaygroundPage.current.liveView = views[0] as! NSView

let mvc = MainViewController(sceneView: views[0] as! SKView)
mvc.present()

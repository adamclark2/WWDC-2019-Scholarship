import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation


var str = "Hello, playground"

let theView = SKView(frame: CGRect(x:0 , y:0, width: 480, height: 640))
PlaygroundPage.current.liveView = theView as! NSView

let mvc = MainViewController(sceneView: theView)
mvc.present()


import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

var str = "Hello, playground"

let theView = SKView(frame: CGRect(x:0 , y:0, width: 480, height: 640))
theView.showsFPS = true;
theView.preferredFramesPerSecond = 35;
theView.isPaused = false;

PlaygroundPage.current.liveView = theView as NSView

let sc = HomeScreenController.init(fileNamed: "HomeScreen")
let play = sc?.childNode(withName: "play")

theView.presentScene(sc)


//let mvc = MainViewController(sceneView: theView)
//mvc.present()


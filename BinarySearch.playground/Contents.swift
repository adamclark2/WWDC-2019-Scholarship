import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

let theView = SKView(frame: CGRect(x:0 , y:0, width: 480, height: 640))
theView.showsFPS = true;
theView.preferredFramesPerSecond = 30;
theView.isPaused = false;
PlaygroundPage.current.liveView = theView as NSView


let sc:HomeScreenController? = HomeScreenController.init(fileNamed: "HomeScreen")
if(sc == nil){
    print("HomeScreenController is Null, this probably means HomeScreen.sks can't be found...")
    exit(1)
}
theView.presentScene(sc)


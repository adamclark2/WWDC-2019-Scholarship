import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

public class HomeScreenController : SKScene {
    
    private var callTable = [
        (btnName: "play", function: doPlay),
        (btnName: "what", function: doWhat),
        (btnName: "aboutAdam", function: doAboutAdam)
    ]
    
    private var v: SKView?;
    
    public func setView(v: SKView){
        self.v = v;
    }
    
    public override func mouseDown(with event: NSEvent) {
        let eventPos: NSPoint = view!.convert(event.locationInWindow, to: view!.scene!)
        
        let play = self.childNode(withName: "play") as! SKLabelNode;
        let what = self.childNode(withName: "what") as! SKLabelNode;
        let about = self.childNode(withName: "aboutAdam") as! SKLabelNode;
        let buttons: [SKLabelNode] = [play, what, about]
        
        // Look through the button list to see if there is a collision
        // If there is then look through the function table to find somthing
        // to call
        for (_, btn) in buttons.enumerated() {
            let rect: CGRect = btn.calculateAccumulatedFrame()
            if(self.isPointInBox(point: eventPos, box: rect)){
                for (_, callable) in callTable.enumerated() {
                    if(callable.btnName == btn.name){
                        callable.function();
                    }
                }
            }
        }
    }
    
    public static func doPlay(){
        print("PLAY")
    }
    
    public static func doWhat(){
        print("What")
    }
    
    public static func doAboutAdam(){
        print("ABOUT")
    }
    
    private func isPointInBox(point: NSPoint, box: CGRect) -> Bool{
        if(box.minX <= point.x && box.minY <= point.y){
            if(point.x < (box.minX + box.width)){
                if(point.y < (box.minY + box.height)){
                    return true;
                }
            }
        }
    return false;
    }
}

import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

public class AboutAdamController : SKScene {
    
    private var buttons: [SKLabelNode]?;
    private var callTable: [(btnName: String, function: (AboutAdamController) -> Void)] = [
        (btnName: "back", function: AboutAdamController.doBack),
    ]
    
    private var homeScreen: HomeScreenController?;
    
    public func setHomeScreen(home: HomeScreenController){
        self.homeScreen = home;
    }
    
    override public func sceneDidLoad() {
        // Init goes here
        let back = self.childNode(withName: "back") as! SKLabelNode;
        buttons = [back];
    }
    
    public override func mouseDown(with event: NSEvent) {
        let eventPos: NSPoint = view!.convert(event.locationInWindow, to: view!.scene!)
        
        // Look through the button list to see if there is a collision
        // If there is then look through the function table to find somthing
        // to call
        for (_, btn) in buttons!.enumerated() {
            let rect: CGRect = btn.calculateAccumulatedFrame()
            if(self.isPointInBox(point: eventPos, box: rect)){
                for (_, callable) in callTable.enumerated() {
                    if(callable.btnName == btn.name){
                        callable.function(self);
                    }
                }
            }
        }
    }
    
    /*
     Tell if a point is in the box.
     This code assumes the origin is in the upper left
     hand corner
     */
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
    
    public static func doBack(this: AboutAdamController){
        let doorsClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
        this.view!.presentScene(this.homeScreen!, transition: doorsClose)
    }
}

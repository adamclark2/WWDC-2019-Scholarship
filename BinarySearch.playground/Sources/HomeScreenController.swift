import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

public class HomeScreenController : SKScene {
    private var buttons: [SKLabelNode]?;
    private var callTable: [(btnName: String, function: (HomeScreenController) -> Void)] = [
        (btnName: "play", function: HomeScreenController.doPlay),
        (btnName: "what", function: HomeScreenController.doWhat),
        (btnName: "aboutAdam", function: HomeScreenController.doAboutAdam)
    ]
    
    private var aboutAdam: AboutAdamController?;
    private var whatIs: WhatIsController?;

    override public func sceneDidLoad() {
        // Init goes here
        let play = self.childNode(withName: "play") as! SKLabelNode;
        let what = self.childNode(withName: "what") as! SKLabelNode;
        let about = self.childNode(withName: "aboutAdam") as! SKLabelNode;
        buttons = [play, what, about]
        
        self.aboutAdam = AboutAdamController(fileNamed: "About")
        self.aboutAdam!.setHomeScreen(home: self)
        
        self.whatIs = WhatIsController(fileNamed: "WhatIsBinarySearch")
        self.whatIs!.setHomeScreen(home: self)
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
    
    public static func doPlay(this: HomeScreenController){
        print("PLAY")
    }
    
    public static func doWhat(this: HomeScreenController){
        let doorsClose = SKTransition.doorsCloseVertical(withDuration: 2.0)
        this.whatIs?.setHomeScreen(home: this)
        this.view!.presentScene(this.whatIs!, transition: doorsClose)
    }
    
    public static func doAboutAdam(this: HomeScreenController){
        let doorsClose = SKTransition.doorsCloseVertical(withDuration: 2.0)
        this.aboutAdam?.setHomeScreen(home: this)
        this.view!.presentScene(this.aboutAdam!, transition: doorsClose)
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
}

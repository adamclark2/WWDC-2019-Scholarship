import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

public class HomeScreenController : SKScene {
    private var buttons: [SKNode]?;
    private var callTable: [(btnName: String, function: (HomeScreenController) -> Void)] = [
        (btnName: "play", function: HomeScreenController.doPlay),
        (btnName: "what", function: HomeScreenController.doWhat),
        (btnName: "aboutAdam", function: HomeScreenController.doAboutAdam)
    ]
    
    private var aboutAdam: AboutAdamController?;
    private var whatIs: WhatIsController?;
    private var guessingGame: GuessingGameController?;
    
    override public func sceneDidLoad() {
        // Init goes here
        let play = self.childNode(withName: "play");
        let what = self.childNode(withName: "what");
        let about = self.childNode(withName: "aboutAdam");
        self.aboutAdam = AboutAdamController(fileNamed: "About")
        self.whatIs = WhatIsController(fileNamed: "WhatIsBinarySearch")
        self.guessingGame = GuessingGameController(fileNamed: "GuessingGame")
        
        let checkArray: [SKNode?] = [
            play, what, about, aboutAdam, whatIs, guessingGame
        ]
        checkArrayForNil(errMsg: "HomeScreenController has a nil", checkArray: checkArray)
        
        buttons = [play!, what!, about!]
        self.whatIs!.setHomeScreen(home: self)
        self.aboutAdam!.setHomeScreen(home: self)
        self.guessingGame!.setHomeScreen(home: self)
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
    
    public static func transitionTo(scene: SKScene, view: SKView?){
        let doorsClose = SKTransition.doorsCloseVertical(withDuration: 0.5)
        view!.presentScene(scene, transition: doorsClose)
    }
    
    public static func doPlay(this: HomeScreenController){
        HomeScreenController.transitionTo(scene: this.guessingGame!, view: this.view)
    }
    
    public static func doWhat(this: HomeScreenController){
        //this.whatIs?.setHomeScreen(home: this)
        HomeScreenController.transitionTo(scene: this.whatIs!, view: this.view)
    }
    
    public static func doAboutAdam(this: HomeScreenController){
        this.aboutAdam?.setHomeScreen(home: this)
        HomeScreenController.transitionTo(scene: this.aboutAdam!, view: this.view)
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

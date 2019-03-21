import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

public class WhatIsController : SKScene {
    
    private var clickDetector: ClickDetector<WhatIsController> = ClickDetector()
    private var callTable: [(btnName: String, function: (WhatIsController) -> () -> Void)] = [
        (btnName: "back", function: WhatIsController.doBack),
        (btnName: "replay", function: WhatIsController.doReplay)
    ]
    
    private var homeScreen: HomeScreenController?;
    
    public func setHomeScreen(home: HomeScreenController){
        self.homeScreen = home;
    }
    
    override public func sceneDidLoad() {
        // Init goes here
        let back = self.childNode(withName: "back");
        let replay = self.childNode(withName: "replay");
        if(back == nil || replay == nil){
            print("WhatIsController back button is nil OR replay button is nil");
            exit(1)
        }
    }
    
    public override func mouseDown(with event: NSEvent) {
        self.clickDetector.detectClick(event: event, view: view!, this: self, callTable: self.callTable);
    }
 
    public func doBack(){
        let doorsClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
        self.view!.presentScene(self.homeScreen!, transition: doorsClose)
    }
    
    public func doReplay(){
        self.view!.presentScene(self.homeScreen!)
        self.homeScreen!.doWhat()
    }
}

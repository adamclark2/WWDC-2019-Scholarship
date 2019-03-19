import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

public class WhatIsController : SKScene {
    
    private var clickDetector: ClickDetector<WhatIsController> = ClickDetector()
    private var buttons: [SKNode]?;
    private var callTable: [(btnName: String, function: (WhatIsController) -> Void)] = [
        (btnName: "back", function: WhatIsController.doBack),
    ]
    
    private var homeScreen: HomeScreenController?;
    
    public func setHomeScreen(home: HomeScreenController){
        self.homeScreen = home;
    }
    
    override public func sceneDidLoad() {
        // Init goes here
        let back = self.childNode(withName: "back");
        if(back == nil){
            print("WhatIsController back button is nil");
            exit(1)
        }
        buttons = [back!];
    }
    
    public override func mouseDown(with event: NSEvent) {
        self.clickDetector.detectClick(event: event, view: view!, this: self, buttons: self.buttons!, callTable: self.callTable);
    }
 
    public static func doBack(this: WhatIsController){
        let doorsClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
        this.view!.presentScene(this.homeScreen!, transition: doorsClose)
    }
}

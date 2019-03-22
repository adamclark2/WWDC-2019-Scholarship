import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

/**
 A SKScene to control the What is Binary Search scene
 
 This class is fairly sparce because most of the work is done in the sks file for the animation
 */
public class WhatIsController : SKScene {
    
    /// clickDetector will detect which SKNode is clicked and call the appropreate method in the callTable
    private var clickDetector: ClickDetector<WhatIsController> = ClickDetector()
    private var callTable: [(btnName: String, function: (WhatIsController) -> () -> Void)] = [
        (btnName: "back", function: WhatIsController.doBack),
        (btnName: "replay", function: WhatIsController.doReplay)
    ]
    
    private var homeScreen: HomeScreenController?;
    
    /**
     Tell the object the SKScene to go to when back is pressed
     */
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
 
    /**
        This method is called when the back button/main menu button is pressed.
        It transfers control back to the home screen
    */
    public func doBack(){
        self.homeScreen!.goBackToHomeScreen(view: self.view!)
    }
    
    /**
        The replay button is displayed at the end of the animation. When the user clicks replay this method is called.
        This method will replay the animation.
     
        Due to the way the mechanics of this work instance methods may be reset and this object may be destroyed.
        I.E. the WhatIsController PROBABLY WILL be re initilized from the file and that other object instance will be handed control
    */
    public func doReplay(){
        self.view!.presentScene(self.homeScreen!)
        self.homeScreen!.doWhat()
    }
}

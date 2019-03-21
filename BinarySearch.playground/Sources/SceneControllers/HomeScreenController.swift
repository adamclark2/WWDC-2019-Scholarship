import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

public class HomeScreenController : SKScene {
    private var callTable: [(btnName: String, function: (HomeScreenController) -> Void)] = [
        (btnName: "play", function: HomeScreenController.doPlay),
        (btnName: "what", function: HomeScreenController.doWhat),
        (btnName: "aboutAdam", function: HomeScreenController.doAboutAdam)
    ]
    
    private var aboutAdam: AboutAdamController?;
    private var whatIs: WhatIsController?;
    private var guessingGame: GuessingGameController?;
    
    private var clickDetector: ClickDetector<HomeScreenController> = ClickDetector()
    
    override public func sceneDidLoad() {
        // Init goes here
        let play = self.childNode(withName: "play");
        let what = self.childNode(withName: "what");
        let about = self.childNode(withName: "aboutAdam");
        self.aboutAdam = AboutAdamController(fileNamed: "About")
        self.whatIs = WhatIsController(fileNamed: "WhatIsBinarySearch/WhatIsBinarySearch")
        self.guessingGame = GuessingGameController(fileNamed: "GuessingGame")
        
        let checkArray: [SKNode?] = [
            play, what, about, aboutAdam, whatIs, guessingGame
        ]
        checkArrayForNil(errMsg: "HomeScreenController has a nil", checkArray: checkArray)
        
        self.whatIs!.setHomeScreen(home: self)
        self.aboutAdam!.setHomeScreen(home: self)
        self.guessingGame!.setHomeScreen(home: self)
    }
    
    public override func mouseDown(with event: NSEvent) {
        self.clickDetector.detectClick(event: event, view: self.view, this: self, callTable: self.callTable)
    }
    
    public static func transitionTo(scene: SKScene, view: SKView?){
        let doorsClose = SKTransition.doorsCloseVertical(withDuration: 0.5)
        view!.presentScene(scene, transition: doorsClose)
    }
    
    public static func doPlay(this: HomeScreenController){
        HomeScreenController.transitionTo(scene: this.guessingGame!, view: this.view)
    }
    
    public static func doWhat(this: HomeScreenController){
        this.whatIs = WhatIsController(fileNamed: "WhatIsBinarySearch/WhatIsBinarySearch")
        this.whatIs?.setHomeScreen(home: this)
        if(this.whatIs == nil){
            print("An unknown error happened where a controller couldn't be loaded\nWas WhatIsBinarySearch/WhatIsBinarySearch.sks removed from disk?\n\n")
            exit(1)
        }
        HomeScreenController.transitionTo(scene: this.whatIs!, view: this.view)
    }
    
    public static func doAboutAdam(this: HomeScreenController){
        this.aboutAdam?.setHomeScreen(home: this)
        HomeScreenController.transitionTo(scene: this.aboutAdam!, view: this.view)
    }
}

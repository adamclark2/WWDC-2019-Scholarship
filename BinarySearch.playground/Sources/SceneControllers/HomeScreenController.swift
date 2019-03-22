import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

/**
 A SKScene to control the Home Screen
 
 The home screen will dispatch to various other scenes to display info & play games
 */
public class HomeScreenController : SKScene {
    
    /// clickDetector will detect which SKNode is clicked and call the appropreate method in the callTable
    private var clickDetector: ClickDetector<HomeScreenController> = ClickDetector()
    private var callTable: [(btnName: String, function: (HomeScreenController) -> () -> Void)] = [
        (btnName: "play", function: HomeScreenController.doPlay),
        (btnName: "playColor", function: HomeScreenController.doPlayColor),
        (btnName: "what", function: HomeScreenController.doWhat),
        (btnName: "aboutAdam", function: HomeScreenController.doAboutAdam)
    ]
    
    private var aboutAdam: AboutAdamController?;
    private var whatIs: WhatIsController?;
    private var guessingGame: GuessingGameController?;
    private var colorGame: ColorGameController?;
    
    override public func sceneDidLoad() {
        // Init goes here
        let play = self.childNode(withName: "play");
        let what = self.childNode(withName: "what");
        let about = self.childNode(withName: "aboutAdam");
        self.aboutAdam = AboutAdamController(fileNamed: "About")
        self.whatIs = WhatIsController(fileNamed: "WhatIsBinarySearch")
        self.guessingGame = GuessingGameController(fileNamed: "GuessingGame")
        self.colorGame = ColorGameController(fileNamed: "ColorGuess")
        
        let checkArray: [SKNode?] = [
            play, what, about, aboutAdam, whatIs, guessingGame, colorGame
        ]
        checkArrayForNil(errMsg: "HomeScreenController has a nil", checkArray: checkArray)
        
        self.whatIs!.setHomeScreen(home: self)
        self.aboutAdam!.setHomeScreen(home: self)
        self.guessingGame!.setHomeScreen(home: self)
        self.colorGame!.setHomeScreen(home: self)
    }
    
    public override func mouseDown(with event: NSEvent) {
        self.clickDetector.detectClick(event: event, view: self.view, this: self, callTable: self.callTable)
    }
    
    /**
        Trsnsitions are used quite a bit so this method saves a line & provides consistancy.
    */
    private func transitionTo(scene: SKScene, view: SKView?){
        let doorsClose = SKTransition.doorsCloseVertical(withDuration: 0.5)
        view!.presentScene(scene, transition: doorsClose)
    }
    
    /**
        This method is called by supporting SKScenes when they want the homescreen to regain control
    */
    public func goBackToHomeScreen(view: SKView){
        self.transitionTo(scene: self, view: view)
    }
    
    /**
        This method is called when the 'Play Guessing Game' button is pressed.
        It transfers control to GuessingGameController
    */
    public func doPlay(){
        self.transitionTo(scene: self.guessingGame!, view: self.view)
    }
    
    /**
     This method is called when the 'Play Color Game' button is pressed.
     It transfers control to ColorGameController
     */
    public func doPlayColor(){
        self.transitionTo(scene: self.colorGame!, view: self.view)
    }
    
    /**
     This method is called when the 'What is Binary Search' button is pressed.
     It transfers control to WhatIsController
     */
    public func doWhat(){
        self.whatIs = WhatIsController(fileNamed: "WhatIsBinarySearch")
        self.whatIs?.setHomeScreen(home: self)
        if(self.whatIs == nil){
            print("An unknown error happened where a controller couldn't be loaded\nWas WhatIsBinarySearch.sks removed from disk?\n\n")
            exit(1)
        }
        self.transitionTo(scene: self.whatIs!, view: self.view)
    }
    
    /**
     This method is called when the 'About' button is pressed.
     It transfers control to AboutAdamController
     */
    public func doAboutAdam(){
        self.aboutAdam?.setHomeScreen(home: self)
        self.transitionTo(scene: self.aboutAdam!, view: self.view)
    }
}

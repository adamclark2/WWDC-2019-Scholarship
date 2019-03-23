import Foundation

import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

/**
 A SKScene to control the How to Play Scene
 
 This class is fairly sparce because most of the work is done in the sks file for the animation
 */
public class HowToPlayController: SKScene {
    
    /// clickDetector will detect which SKNode is clicked and call the appropreate method in the callTable
    private var clickDetector: ClickDetector<HowToPlayController> = ClickDetector()
    private var callTable: [(btnName: String, function: (HowToPlayController) -> () -> Void)] = [
        (btnName: "mainMenu", function: HowToPlayController.doMainMenu),
        (btnName: "colorGame", function: HowToPlayController.doHowColorGame),
        (btnName: "guessingGame", function: HowToPlayController.doHowGuessingGame)
    ]
    
    private var homeScreen: HomeScreenController?;
    
    private var howGuessingGame: SKNode?;
    private var howColorGame: SKNode?;
    private var colorGame: SKLabelNode?;
    private var guessingGame: SKLabelNode?;
    
    
    
    /**
     Tell the object the SKScene to go to when back is pressed
     */
    public func setHomeScreen(home: HomeScreenController){
        self.homeScreen = home;
    }
    
    override public func sceneDidLoad() {
        // Init goes here
        let controls = self.childNode(withName: "controls")
        self.howGuessingGame = self.childNode(withName: "howGuessingGame")
        self.howColorGame = self.childNode(withName: "howColorGame")
        var checkArray: [SKNode?] = [controls, howGuessingGame, howColorGame]
        checkArrayForNil(errMsg: "HowToPlayController has a nil", checkArray: checkArray)
        
        let mainMenu = controls!.childNode(withName: "mainMenu")
        let colorGame = controls!.childNode(withName: "colorGame")
        let guessingGame = controls!.childNode(withName: "guessingGame")
        checkArray = [mainMenu, colorGame, guessingGame]
        checkArrayForNil(errMsg: "HowToPlayController has a nil button", checkArray: checkArray)
        
        self.colorGame = colorGame as! SKLabelNode?;
        self.guessingGame = guessingGame as! SKLabelNode?;
        
        doHowGuessingGame()
    }
    
    public override func mouseDown(with event: NSEvent) {
        self.clickDetector.detectClick(event: event, view: view!, this: self, callTable: self.callTable);
    }
    
    /**
     This method is called when the back button/main menu button is pressed.
     It transfers control back to the home screen
     */
    public func doMainMenu(){
        self.homeScreen!.goBackToHomeScreen(view: self.view!)
    }
    
    /**
        Display how to play the Color Game
        This method is called when the user selects how to play the color game
    */
    public func doHowColorGame(){
        self.howGuessingGame!.alpha = 0
        self.howColorGame!.alpha = 1
        self.guessingGame!.text = "Guessing Game"
        self.colorGame!.text = "**Color Game**"
    }
    
    /**
     Display how to play the Guessing Game
     This method is called when the user selects how to play the Guessing Game
     */
    public func doHowGuessingGame(){
        self.howGuessingGame!.alpha = 1
        self.howColorGame!.alpha = 0
        self.guessingGame!.text = "**Guessing Game**"
        self.colorGame!.text = "Color Game"
    }
}

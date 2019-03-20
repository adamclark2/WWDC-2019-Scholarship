import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

public class GuessingGameController: SKScene {
    private var clickDetector: ClickDetector<GuessingGameController> = ClickDetector()
    private var callTable: [(btnName: String, function: (GuessingGameController) -> Void)] = [
        (btnName: "mainMenu", function: GuessingGameController.doMainMenu),
        (btnName: "tryAgain", function: GuessingGameController.doTryAgain),
        
        (btnName: "button_1", function: GuessingGameController.doButton1),
        (btnName: "button_2", function: GuessingGameController.doButton2),
        (btnName: "button_3", function: GuessingGameController.doButton3),
        (btnName: "button_4", function: GuessingGameController.doButton4),
    ]
    
    private var homeScreen: HomeScreenController?;
    
    private var win: SKNode?;
    private var lose: SKNode?;
    private var game: SKNode?;
    
    public func setHomeScreen(home: HomeScreenController){
        self.homeScreen = home;
    }
    
    override public func sceneDidLoad() {
        win = self.childNode(withName: "won");
        lose = self.childNode(withName: "lost");
        game = self.childNode(withName: "game");
        
        if(win == nil || lose == nil || game == nil){
            print("GuessingGameController: win, lose, or game is NIL")
            exit(1)
        }
        
        let menu = game!.childNode(withName: "mainMenu");
        let button1 = game!.childNode(withName: "button_1");
        let button2 = game!.childNode(withName: "button_2");
        let button3 = game!.childNode(withName: "button_3");
        let button4 = game!.childNode(withName: "button_4");
        
        let mainMenuLost = lose!.childNode(withName: "mainMenu");
        let tryAgainLost = lose!.childNode(withName: "tryAgain");
        
        let mainMenuWon = win!.childNode(withName: "mainMenu");
        let tryAgainWon = win!.childNode(withName: "tryAgain");
        
        let checkArray: [SKNode?] = [
            win,lose,game,
            menu,button1, button2, button3, button4,
            mainMenuLost, tryAgainLost,
            mainMenuWon, tryAgainWon
        ]
        
        checkArrayForNil(errMsg: "Somthing in GuessingGameController is nil", checkArray: checkArray);
        GuessingGameController.doTryAgain(this: self)
    }
    
    public override func mouseDown(with event: NSEvent) {
        self.clickDetector.detectClick(event: event, view: view!, this: self, callTable: self.callTable);
    }
    
    public static func doMainMenu(this: GuessingGameController){
        doTryAgain(this: this)
        HomeScreenController.transitionTo(scene: this.homeScreen!, view: this.view)
    }
    
    public static func doTryAgain(this: GuessingGameController){
        this.game!.alpha = 1
        this.lose!.alpha = 0
        this.win!.alpha =  0
    }
    
    public static func doButton1(this: GuessingGameController){
        this.game!.alpha = 0
        this.lose!.alpha = 1
    }
    
    public static func doButton2(this: GuessingGameController){
        GuessingGameController.doButton1(this: this)
    }
    
    public static func doButton3(this: GuessingGameController){
        GuessingGameController.doButton1(this: this)
    }
    
    public static func doButton4(this: GuessingGameController){
        this.game!.alpha = 0
        this.win!.alpha = 1
    }
}


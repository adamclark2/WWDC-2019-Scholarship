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
    private var model: GuessingGameModel = GuessingGameModel()
    
    private var win: SKNode?;
    private var lose: SKNode?;
    private var game: SKNode?;
    
    private var label1: SKLabelNode?
    private var label2: SKLabelNode?
    private var label3: SKLabelNode?
    private var label4: SKLabelNode?
    private var guessesMade: SKLabelNode?;
    private var rangeLabel: SKLabelNode?;
    private var numGuesses: SKLabelNode?;
    
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
        guessesMade = game!.childNode(withName: "lastGuess") as! SKLabelNode?
        rangeLabel = game!.childNode(withName: "rangeLabel") as! SKLabelNode?
        
        let mainMenuLost = lose!.childNode(withName: "mainMenu");
        let tryAgainLost = lose!.childNode(withName: "tryAgain");
        
        let mainMenuWon = win!.childNode(withName: "mainMenu");
        let tryAgainWon = win!.childNode(withName: "tryAgain");
        numGuesses = win!.childNode(withName: "numGuesses") as! SKLabelNode?
        
        var checkArray: [SKNode?] = [
            win,lose,game,
            menu,button1, button2, button3, button4, guessesMade, rangeLabel,
            mainMenuLost, tryAgainLost,
            mainMenuWon, tryAgainWon, numGuesses
        ]
        
        checkArrayForNil(errMsg: "Somthing in GuessingGameController is nil", checkArray: checkArray);
        
        label1 = button1?.childNode(withName: "label") as! SKLabelNode?
        label2 = button2?.childNode(withName: "label") as! SKLabelNode?
        label3 = button3?.childNode(withName: "label") as! SKLabelNode?
        label4 = button4?.childNode(withName: "label") as! SKLabelNode?
        
        checkArray = [label1, label2, label3, label4]
        checkArrayForNil(errMsg: "GuessingGameController couldn't find labels", checkArray: checkArray)
        
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
        
        this.model = GuessingGameModel()
        GuessingGameController.syncModel(this: this)
    }
    
    private static func syncModel(this: GuessingGameController){
        if(!this.model.hasWonGame() && !this.model.hasLostGame()){
            this.game!.alpha = 1
            this.lose!.alpha = 0
            this.win!.alpha =  0
        } else if(this.model.hasLostGame()){
            this.game!.alpha = 0
            this.lose!.alpha = 1
            this.win!.alpha =  0
        }else if(this.model.hasWonGame()){
            this.game!.alpha = 0
            this.lose!.alpha = 0
            this.win!.alpha =  1
        }
        
        this.label1?.text = String(this.model.getGuess(index: 1))
        this.label2?.text = String(this.model.getGuess(index: 2))
        this.label3?.text = String(this.model.getGuess(index: 3))
        this.label4?.text = String(this.model.getGuess(index: 4))
        
        this.guessesMade!.text = "Guesses Made:     " + this.model.getPreviousGuesses().joined(separator: ", ")
        this.rangeLabel!.text = "Between " + String(this.model.getMinRange()) + " to " + String(this.model.getMaxRange())
        this.numGuesses!.text = String(this.model.getStatistics().numberOfGuessesMade)
    }
    
    public static func doButton1(this: GuessingGameController){
        this.model.doGuess(index: 1)
        syncModel(this: this)
        
    }
    
    public static func doButton2(this: GuessingGameController){
        this.model.doGuess(index: 2)
        syncModel(this: this)
    }
    
    public static func doButton3(this: GuessingGameController){
        this.model.doGuess(index: 3)
        syncModel(this: this)
    }
    
    public static func doButton4(this: GuessingGameController){
        this.model.doGuess(index: 4)
        syncModel(this: this)
    }
}


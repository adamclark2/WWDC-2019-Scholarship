import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

/**
 A SKScene to control the guessing game

 The guessing game is where the user trys to guess a number between 0 and 1,000 inclusive.
 The user will be presented with four possible guesses and only one conforms to binary search.
 The user loses when they don't use binary search. The user wins when they guess the right number.

 Because the log base 2 of 1,000 is approximately 10 it will take the user up to 10 guesses to win.
 */
public class GuessingGameController: SKScene {
    
    /// clickDetector will detect which SKNode is clicked and call the appropreate method in the callTable
    private var clickDetector: ClickDetector<GuessingGameController> = ClickDetector()
    private var callTable: [(btnName: String, function: (GuessingGameController) -> () -> Void)] = [
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
    
    /**
     Tell the object the SKScene to go to when back is pressed
     */
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
        
        self.doTryAgain()
    }
    
    public override func mouseDown(with event: NSEvent) {
        self.clickDetector.detectClick(event: event, view: view!, this: self, callTable: self.callTable);
    }
    
    /**
     This method is called when the Main Menu button is pressed.
 
     This method will reset the color game for another round then return to the
     home screen.
     */
    public func doMainMenu(){
        doTryAgain()
        self.homeScreen!.goBackToHomeScreen(view: self.view!)
    }
    
    /**
     This method is called when the 'Play Again' or 'Try Again' button(s) are pressed.
     
     This method resets the scene for another game.
     */
    public func doTryAgain(){
        self.game!.alpha = 1
        self.lose!.alpha = 0
        self.win!.alpha =  0
        
        self.model = GuessingGameModel()
        self.syncModel()
    }
    
    /**
    This method synchronizes the model and the view
 
    If the user won/lost this method will display the winning/losing prompt
    This method will also update the button labels and guess range
    */
    private func syncModel(){
        if(!self.model.hasWonGame() && !self.model.hasLostGame()){
            self.game!.alpha = 1
            self.lose!.alpha = 0
            self.win!.alpha =  0
        } else if(self.model.hasLostGame()){
            self.game!.alpha = 0
            self.lose!.alpha = 1
            self.win!.alpha =  0
        }else if(self.model.hasWonGame()){
            self.game!.alpha = 0
            self.lose!.alpha = 0
            self.win!.alpha =  1
        }
        
        self.label1?.text = String(self.model.getGuess(index: 1))
        self.label2?.text = String(self.model.getGuess(index: 2))
        self.label3?.text = String(self.model.getGuess(index: 3))
        self.label4?.text = String(self.model.getGuess(index: 4))
        
        self.guessesMade!.text = "Guesses Made:     " + self.model.getPreviousGuesses().joined(separator: ", ")
        self.rangeLabel!.text = "Between " + String(self.model.getMinRange()) + " to " + String(self.model.getMaxRange())
        self.numGuesses!.text = String(self.model.getStatistics().numberOfGuessesMade)
    }
    
    /**
    This method is called when the user presses button 1. It will do guess #1 in the model and sync the model
    */
    public func doButton1(){
        self.model.doGuess(index: 1)
        syncModel()
        
    }
    
    /**
     This method is called when the user presses button 2. It will do guess #2 in the model and sync the model
     */
    public func doButton2(){
        self.model.doGuess(index: 2)
        syncModel()
    }
    
    /**
     This method is called when the user presses button 3. It will do guess #3 in the model and sync the model
     */
    public func doButton3(){
        self.model.doGuess(index: 3)
        syncModel()
    }
    
    /**
     This method is called when the user presses button 4. It will do guess #4 in the model and sync the model
     */
    public func doButton4(){
        self.model.doGuess(index: 4)
        syncModel()
    }
}


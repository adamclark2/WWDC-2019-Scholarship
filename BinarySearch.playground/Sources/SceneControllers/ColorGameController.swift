import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

/**
A SKScene to control the color game

The color game is where you use binary search to find a color within a set.
The color set is obviously sorted from lightest to darkest
*/
public class ColorGameController: SKScene {
    
    /// clickDetector will detect which SKNode is clicked and call the appropreate method in the callTable
    private var clickDetector: ClickDetector<ColorGameController> = ClickDetector()
    private var callTable: [(btnName: String, function: (ColorGameController) -> () -> Void)] = [
        (btnName: "mainMenu", function: ColorGameController.doMainMenu),
        (btnName: "playAgain", function: ColorGameController.doPlayAgain),
        
        (btnName: "btn1", function: ColorGameController.doBtn1),
        (btnName: "btn2", function: ColorGameController.doBtn2),
        (btnName: "btn3", function: ColorGameController.doBtn3),
        (btnName: "btn4", function: ColorGameController.doBtn4),
        (btnName: "btn5", function: ColorGameController.doBtn5)
        
    ]
    
    private var homeScreen: HomeScreenController?;
    private var colorGame:ColorGameModel = ColorGameModel()
    
    private var game: SKNode?;
    private var won: SKNode?;
    private var lost: SKNode?;
    
    private var hintLabels: [SKLabelNode?]?;
    
    /**
    Tell the object the SKScene to go to when back is pressed
     */
    public func setHomeScreen(home: HomeScreenController){
        self.homeScreen = home;
    }
    
    override public func sceneDidLoad() {
        self.game = self.childNode(withName: "game")
        self.won = self.childNode(withName: "won")
        self.lost = self.childNode(withName: "lost")
        var checkArray: [SKNode?] = [game, won, lost]
        checkArrayForNil(errMsg: "ColorGameController has a nil game or won or lost", checkArray: checkArray)
        
        let btn1 = game!.childNode(withName: "btn1")
        let btn2 = game!.childNode(withName: "btn2")
        let btn3 = game!.childNode(withName: "btn3")
        let btn4 = game!.childNode(withName: "btn4")
        let btn5 = game!.childNode(withName: "btn5")
        checkArray = [btn1, btn2, btn3, btn4, btn5]
        checkArrayForNil(errMsg: "ColorGameController has a nil button", checkArray: checkArray)
        
        let label1 = btn1!.childNode(withName: "hint")
        let label2 = btn2!.childNode(withName: "hint")
        let label3 = btn3!.childNode(withName: "hint")
        let label4 = btn4!.childNode(withName: "hint")
        let label5 = btn5!.childNode(withName: "hint")
        checkArray = [label1, label2, label3, label4, label5]
        checkArrayForNil(errMsg: "ColorGameController has a nil hint label", checkArray: checkArray)
        self.hintLabels = [label1 as! SKLabelNode?, label2 as! SKLabelNode?, label3 as! SKLabelNode?, label4 as! SKLabelNode?, label5 as! SKLabelNode?]
        
        doPlayAgain()
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
        doPlayAgain()
        self.homeScreen!.goBackToHomeScreen(view: self.view!)
    }
    
    /**
    This method is called when the 'Play Again' or 'Try Again' button(s) are pressed.
 
    This method resets the scene for another game.
    */
    public func doPlayAgain(){
        self.colorGame = ColorGameModel()
        for (_, label) in self.hintLabels!.enumerated() {
            label!.text = "**ERROR**"
            label!.isHidden = true
        }
        
        self.game!.alpha = 1;
        self.won!.alpha = 0;
        self.lost!.alpha = 0;
    }
    
    /**
    This method is called indirectly when a button is pressed
 
    This method will update the ColorGameModel with the guess made
    at index. It will also update the game if the user wins/loses.
    Also a hint will be shown above the button saying wheather the
    user needs to guess lighter or darker.
    */
    private func doBtn(index: Int){
        self.colorGame.doGuess(index: index)
        if(colorGame.hasWonGame()){
            self.game!.alpha = 0;
            self.won!.alpha = 1;
            self.lost!.alpha = 0;
        }else if(colorGame.hasLostGame()){
            self.game!.alpha = 0;
            self.won!.alpha = 0;
            self.lost!.alpha = 1;
        }else{
            var hint = "ERROR"
            if(colorGame.getDarkerOrLighter() == colorGame.C_DARKER){
                hint = "Darker"
            }else{
                hint = "Lighter"
            }
            
            self.hintLabels![index - 1]!.text = hint
            self.hintLabels![index - 1]!.isHidden = false
        }
    }
    
    /**
    Called when button 1 is pressed. This is the lightest color.
    */
    public func doBtn1(){
        doBtn(index: 1)
    }
    
    /**
     Called when button 2 is pressed.
     */
    public func doBtn2(){
        doBtn(index: 2)
    }
    
    /**
     Called when button 3 is pressed.
     */
    public func doBtn3(){
        doBtn(index: 3)
    }
    
    /**
     Called when button 4 is pressed.
     */
    public func doBtn4(){
        doBtn(index: 4)
    }
    
    /**
     Called when button 1 is pressed. This is the darkest color.
     */
    public func doBtn5(){
        doBtn(index: 5)
    }
}


import AppKit
import SpriteKit
import Foundation

/**
    The game logic for the color guessing game
 */
public class ColorGameModel {
    private var hasLost = false;
    private var hasWon = false;
    private var myNumber = 0;
    
    private var minRange = 1;
    private var maxRange = 5;
    
    private var numGuesses = 0;
    private var darkerOrLighter = false;
    private var previousGuess = 0;
    
    public let C_LIGHTER = true;
    public let C_DARKER = false;
    
    /**
        Constructor
    */
    public init(){
        myNumber = Int.random(in: 1...5)
    }
    
    /**
        A testing method used to play the game on the command line
        I(Adam) used this to eliminate bugs
     
        You can't run this in Swift Playgrounds directly but you can compile
        it on the command line. To do that
            1. Un comment the code at the bottom of this file
            2. swiftc ./ColorGameModel.swift -o color.o
            3. ./color.o
            4. if you want to run the swift playground again re-comment the code
    */
    public func doCommandLineTest(){
        print("Please press enter to run...\n\n")
        var line = readLine()
        var i = 0;
        while(line == nil && i < 100){
            i = i + 1;
            line = readLine();
        }
        if(i >= 100){
            print("Swift Playgrounds doesn't support readLine()\n-------------------------------\nPlease create a xcode command line project for Mas OS and add the file GuessingGameModel\n**OR**\nCompile via commandline\n\nI used the command line\n   swiftc ./GuessingGameModel.swift -o guess.o\n   ./guess.o\n\nConvience code to run is located at the bottom of GuessingGameMode.swift remember to un-comment it.")
            exit(1)
        }
        
        print("Welcome to Color Game (test edition)");
        print("I'm thinking of a color in one of these buckets...\nCan you guess which one?")
        print("[1 (light)]  [2]  [3]  [4]  [5 (dark)]");
        while (true) {
            line = readLine()
            let num: Int? = Int(line!)
            if(num != nil){
                doGuess(index: num!)
                
                if(!hasLost && !hasWon){
                    if(getDarkerOrLighter() == C_DARKER){
                        print("DARKER")
                    }else{
                        print("LIGHTER")
                    }
                }
            }else{
                print("Enter a number!");
            }
            
            if(hasLost){
                print("You lost because you didn't use binary search!")
                exit(0)
            }
            
            if(hasWon){
                print("You won!")
                exit(0)
            }
        }
        
    }
    
    /**
        Hand a guess to the object so that we can change the internal state
     
        After calling this you may want to call hasLostGame() hasWonGame()
        or getDarkerOrLighter()
     
        The basic just of this is:
            - Make a guess
            - Check if you won or lost
            - If the game is still valid then check if you need to guess lighter or darker
    */
    public func doGuess(index: Int){
        if(hasLost || hasWon){
            return;
        }else{
            let delta = maxRange - minRange
            
            if(index == previousGuess){
                hasLost = true
            }else if(  (index == minRange + (delta/2)) || (delta <= 1 && index == myNumber)  ){
                if(index == self.myNumber){
                    hasWon = true
                }else{
                    numGuesses = numGuesses + 1;
                    if(myNumber > index){
                        minRange = index
                        darkerOrLighter = C_DARKER;
                    }else{
                        maxRange = index
                        darkerOrLighter = C_LIGHTER;
                    }
                }
            }else{
                // Binary search not used
                hasLost = true
            }
            previousGuess = index
        }
    }
    
    /**
        Get the number of guesses that were made
    */
    public func getNumberOfGuesses() -> Int {
        return self.numGuesses;
    }
    
    /**
        Get wheater or not the user should guess for a darker color or ligher color
     
         The basic just of this is:
         - Make a guess
         - Check if you won or lost
         - If the game is still valid then check if you need to guess lighter or darker
    */
    public func getDarkerOrLighter() -> Bool {
        return self.darkerOrLighter;
    }
    
    /**
        returns true if the user has lost the game
     
        The user loses the game if they make a guess that
        isn't apart of the binary search algorithm. Even if the
        user guesses the right color off the bat they
        may lose if they didn't use binary search.
    */
    public func hasLostGame() -> Bool{
        return hasLost
    }
    
    /**
        returns true if the user has won the game
     
        The user wins when they guess the right color
        using the binary search algorithm. Even if the
        user guesses the right color off the bat they
        may lose if they didn't use binary search.
    */
    public func hasWonGame() -> Bool{
        return hasWon
    }
}

// Uncomment this to run test in CLI
/*
let colorGame = ColorGameModel()
colorGame.doCommandLineTest()
*/

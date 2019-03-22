import AppKit
import SpriteKit
import Foundation

/**
    The game logic for the Guessing Game 
 */
public class GuessingGameModel {
    private var hasLost = false;
    private var hasWon = false;
    private var myNumber = 0;

    private var minRange = 0;
    private var maxRange = 1000;

    private var buttons: [Int] = [0,0,0,0]
    private var previousGuesses: [Int] = []

    /**
        Constructor
    */
    public init(){
        // Random number from 0 to 1000 inclusive
        myNumber = Int.random(in: 0...1000);
        newButtons();
    }

    /**
        Change the buttons to new values and randomly choose one of the buttons to be right. **INTERNAL USE ONLY**
     
        To ensure the user doesn't get board the buttons change each guess. 3 of the buttons are the wrong guess
        and if the user chooses them then they will lose. If the user chooses the 1 right button they will keep playing
        untill they lose or they guess right using binary search.
    */
    private func newButtons(){
        buttons[0] = Int.random(in: 0...1000)
        buttons[1] = Int.random(in: 0...1000)
        buttons[2] = Int.random(in: 0...1000)
        buttons[3] = Int.random(in: 0...1000)

        let delta = maxRange - minRange
        let rightAns = Int.random(in: 0...3)
        buttons[rightAns] = minRange + delta/2
    }
    
    /**
         A testing method used to play the game on the command line
         I(Adam) used this to eliminate bugs
     
         You can't run this in Swift Playgrounds directly but you can compile
         it on the command line. To do that
             1. Un comment the code at the bottom of this file
             2. swiftc ./GuessingGameModel.swift -o guess.o
             3. ./guess.o
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
        
        print("Welcome to Guessing Game (test edition)");
        print("I'm thinking of a number between" + String(1) + " " + String(10) + " can you use binary search to find it?\n");
        
        while(true){
            print("Choose an option: (enter number & press enter)")
            print("Help: choose a number between " + String(minRange) + " - " + String(maxRange))
            print("Previous guesses: " + getPreviousGuesses().joined(separator:" "))
            print("   [1] " + String(getGuess(index: 1)))
            print("   [2] " + String(getGuess(index: 2)))
            print("   [3] " + String(getGuess(index: 3)))
            print("   [4] " + String(getGuess(index: 4)))
            print("   [q] QUIT")

            line = readLine()

            if(line == "q" || line == "Q"){
                exit(0)
            }
        
            let number: Int? = Int(line!)
            if(number != nil && number! >= 1 && number! <= 4){
                print("Your guess was " + String(getGuess(index: number!)));

                doGuess(index: number!)
                if(hasWonGame()){
                    print("You won... Good Job!");
                    print(getStatistics())
                    exit(0)
                }

                if(hasLostGame()){
                    print("You lost because you didn't use binary search!\n");
                    exit(0)
                }
            }
        }
        
    }

    /**
        Get the numerical value of the button at index index
     
        Unfortunately this is indexed at 1 because most end-users
        think of the first button as button #1 instead of button #0
    */
    public func getGuess(index: Int) -> Int{
        return buttons[(index - 1) % 4]
    }
    
    /**
     Hand a guess to the object so that we can change the internal state
     
     After calling this you may want to call hasLostGame() hasWonGame()
     
     The basic just of this is:
     - Make a guess
     - Check if you won or lost
    */
    public func doGuess(index: Int){
        if(hasLost || hasWon){
            return;
        }else{
            let delta = maxRange - minRange

            if(getGuess(index:index) == minRange + (delta/2)){
                if(getGuess(index:index) == self.myNumber){
                    hasWon = true
                }else{
                    previousGuesses.append(getGuess(index: index))
                    if(myNumber > getGuess(index:index)){
                        minRange = getGuess(index: index)
                    }else{
                        maxRange = getGuess(index: index)
                    }
                    newButtons()
                }
            }else{
                // Binary search not used 
                hasLost = true
            }
        }
    }
    
    /**
     Get the lower bound of where the number is
     This number may change as the user makes more guesses
     */
    public func getMinRange() -> Int{
        return self.minRange
    }
    
    /**
        Get the upward bound of where the number is
        This number may change as the user makes more guesses
    */
    public func getMaxRange() -> Int{
        return self.maxRange;
    }

    /**
        Get an array of previous guesses the user made
    */
    public func getPreviousGuesses() -> [String] {
        return self.previousGuesses.map{String($0)};
    }

    /**
         returns true if the user has lost the game
     
         The user loses the game if they make a guess that
         isn't apart of the binary search algorithm. Even if the
         user guesses the right number off the bat they
         may lose if they didn't use binary search.
     */
    public func hasLostGame() -> Bool{
        return hasLost
    }

    /**
        returns true if the user has won the game

        The user wins when they guess the right number
        using the binary search algorithm. Even if the
        user guesses the right number off the bat they
        may lose if they didn't use binary search.
     */
    public func hasWonGame() -> Bool{
        return hasWon
    }

    /**
        Get various statistics including

        linearSearchGuesses: The number of guesses the user would have to make using linear search
        numberOfGuessesMade: The number of guesses the user made
        logBase2OfMax: The maximum number of guesses the user would have to make using binary search
    */
    public func getStatistics() -> (linearSearchGuesses: Int, numberOfGuessesMade: Int, logBase2OfMax: Int){
        let logFormula: Int = Int(round(log(1000) / log(2)))
        return (linearSearchGuesses: 1000, numberOfGuessesMade: previousGuesses.count, logBase2OfMax: logFormula)
    }
}

// Uncomment this to run test in CLI
/*
let guessGame = GuessingGameModel()
guessGame.doCommandLineTest()
*/

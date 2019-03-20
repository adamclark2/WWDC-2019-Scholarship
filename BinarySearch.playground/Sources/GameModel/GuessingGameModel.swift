import AppKit
import SpriteKit
import Foundation

public class GuessingGameModel {
    private var hasLost = false;
    private var hasWon = false;
    private var myNumber = 0;

    private var minRange = 0;
    private var maxRange = 1000;

    private var buttons: [Int] = [0,0,0,0]
    private var previousGuesses: [Int] = []

    public init(){
        // Random number from 0 to 1000 inclusive
        myNumber = Int.random(in: 0...1000);
        newButtons();
    }

    private func newButtons(){
        buttons[0] = Int.random(in: 0...1000)
        buttons[1] = Int.random(in: 0...1000)
        buttons[2] = Int.random(in: 0...1000)
        buttons[3] = Int.random(in: 0...1000)

        let delta = maxRange - minRange
        let rightAns = Int.random(in: 0...3)
        buttons[rightAns] = minRange + delta/2
    }
    
    // Test the model in the command line
    // This DOES NOT work in Swift Playgrounds
    // compile on command line
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
        
        var done = false;
        while(!done){
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

    public func getGuess(index: Int) -> Int{
        return buttons[(index - 1) % 4]
    }
    
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

    public func getPreviousGuesses() -> [String] {
        return self.previousGuesses.map{String($0)};
    }

    public func hasLostGame() -> Bool{
        return hasLost
    }

    public func hasWonGame() -> Bool{
        return hasWon
    }

    public func getStatistics() -> (linearSearchGuesses: Int, numberOfGuessesMade: Int, logBase2OfMax: Int){
        let logFormula: Int = Int(round(log(1000) / log(2)))
        return (linearSearchGuesses: 1000, numberOfGuessesMade: previousGuesses.count, logBase2OfMax: logFormula)
    }
}

// Uncomment this to run test in CLI

let guessGame = GuessingGameModel()
guessGame.doCommandLineTest()


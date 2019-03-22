import AppKit
import SpriteKit
import Foundation

public class ColorGameModel {
    private var hasLost = false;
    private var hasWon = false;
    private var myNumber = 0;
    
    private var minRange = 1;
    private var maxRange = 5;
    
    private var numGuesses = 0;
    private var darkerOrLighter = false;
    private var previousGuess = 0;
    
    public let C_LIIGHER = true;
    public let C_DARKER = false;
    
    public init(){
        myNumber = Int.random(in: 1...5)
    }
    
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
            var num: Int? = Int(line!)
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
                        darkerOrLighter = C_LIIGHER;
                    }
                }
            }else{
                // Binary search not used
                hasLost = true
            }
            previousGuess = index
        }
    }
    
    public func getMinRange() -> Int{
        return self.minRange
    }
    
    public func getMaxRange() -> Int{
        return self.maxRange;
    }
    
    public func getNumberOfGuesses() -> Int {
        return self.numGuesses;
    }
    
    public func getDarkerOrLighter() -> Bool {
        return self.darkerOrLighter;
    }
    
    public func hasLostGame() -> Bool{
        return hasLost
    }
    
    public func hasWonGame() -> Bool{
        return hasWon
    }
}

// Uncomment this to run test in CLI
/*
let colorGame = ColorGameModel()
colorGame.doCommandLineTest()
*/

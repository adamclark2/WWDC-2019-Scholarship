import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

/****************** WELCOME TO BINARY SEARCH ******************
                        BY: ADAM CLARK
 
 To run this press the run button in the lower left hand corner.
 Then open the assistant editor to display the playgrounds
 live view. The assistant editor looks like a ven diagram.
 (I.E. two circles intersecting)
 
 This project contains:
    - An animation explaining what binary search is
    - A guessing game where you guess a number between 0 - 1,000
        using binary search
    - A color guessing game where you guess which color the
        computer is thinking of using binary search
    - An about screen (because why not?)
 
 Thanks for taking the time to look at my project!
 
 
 Are you a developer?
 Do you love/hate generics? or function pointers? Take a look at ClickDetector.swift
 Have fun playing the game!
***************************************************************/
let theView = SKView(frame: CGRect(x:0 , y:0, width: 480, height: 640))
theView.showsFPS = true;
theView.preferredFramesPerSecond = 30;
theView.isPaused = false;
PlaygroundPage.current.liveView = theView as NSView


let sc:HomeScreenController? = HomeScreenController.init(fileNamed: "HomeScreen")
if(sc == nil){
    print("HomeScreenController is nil, this probably means HomeScreen.sks can't be found on disk...")
    exit(1)
}
theView.presentScene(sc)

import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

// Check an array for nils and exit if somthing went wrong
// This is good for debug
func checkArrayForNil(errMsg: String, checkArray: [AnyObject?]){
    var shouldExit = false
    for (idx, node) in checkArray.enumerated(){
        if(node == nil){
            print(errMsg + "   index:" + String(idx))
            shouldExit = true
        }
    }
    
    if(shouldExit){
        exit(1)
    }
}


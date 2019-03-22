import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

/**
    Helper function to check an array for a nil value. If there is a nil we will exit with error code 1
 
    - parameter errMsg The error message to present to the console if there is a nil. In addition all the nil indices will be appended to this message
    - parameter checkArray The array to check for nils
*/
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


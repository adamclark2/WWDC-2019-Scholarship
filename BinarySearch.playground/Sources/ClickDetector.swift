import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

// A helper object to detect clicks
// call detectClick on your onMouseDown...
public class ClickDetector<T: SKScene> {
    
    func detectClick(event: NSEvent, view: SKView?, this: T, callTable: [(btnName: String, function: (T) -> Void)]){
        let eventPos: NSPoint = view!.convert(event.locationInWindow, to: view!.scene!)
        let buttons: [SKNode] = this.nodes(at: eventPos)

        // Look through the button list to see if there is a collision
        // If there is then look through the function table to find somthing
        // to call
        for (_, btn) in buttons.enumerated() {
            for (_, callable) in callTable.enumerated() {
                if(callable.btnName == btn.name){
                    callable.function(this);
                }
            }
        }
    }
    
}

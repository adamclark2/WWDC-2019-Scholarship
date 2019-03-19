import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

// A helper that's meant to be exteded
// This does some work to calculate 
public class ClickDetector<T> {
    
    func detectClick(event: NSEvent, view: SKView?, this: T, buttons: [SKLabelNode], callTable: [(btnName: String, function: (T) -> Void)]){
        let eventPos: NSPoint = view!.convert(event.locationInWindow, to: view!.scene!)
        
        // Look through the button list to see if there is a collision
        // If there is then look through the function table to find somthing
        // to call
        for (_, btn) in buttons.enumerated() {
            let rect: CGRect = btn.calculateAccumulatedFrame()
            if(self.isPointInBox(point: eventPos, box: rect)){
                for (_, callable) in callTable.enumerated() {
                    if(callable.btnName == btn.name){
                        callable.function(this);
                    }
                }
            }
        }
    }
    
    /*
     Tell if a point is in the box.
     This code assumes the origin is in the upper left
     hand corner
     */
     func isPointInBox(point: NSPoint, box: CGRect) -> Bool{
        if(box.minX <= point.x && box.minY <= point.y){
            if(point.x < (box.minX + box.width)){
                if(point.y < (box.minY + box.height)){
                    return true;
                }
            }
        }
        return false;
    }
}
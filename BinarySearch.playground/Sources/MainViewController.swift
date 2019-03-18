import Cocoa
import AppKit
import PlaygroundSupport
import Foundation
import SpriteKit

public class MainViewController : NSObject {
    private var sceneView: SKView;
    private var scene: SKScene;
    
    public init(sceneView: SKView){
        self.sceneView = sceneView
        self.scene = SKScene(size: sceneView.bounds.size);
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.backgroundColor = NSColor.black
        
        var vv = SKSpriteNode(texture: nil, color: NSColor.red, size: CGSize(width: 10, height: 10))
        scene.addChild(vv)
    }
    
    public func present(){
        self.sceneView.presentScene(self.scene)
    }
}

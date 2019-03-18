import Cocoa
import AppKit
import PlaygroundSupport
import Foundation
import SpriteKit

public class MainViewController {
    private var sceneView: SKView;
    private var scene: SKScene;
    
    public init(sceneView: SKView){
        self.sceneView = sceneView
        self.scene = SKScene(size: sceneView.bounds.size);
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.backgroundColor = NSColor.black
        
        let vv = SKSpriteNode(texture: nil, color: NSColor.red, size: CGSize(width: 10, height: 10))
        vv.anchorPoint = CGPoint.init(x: 0, y: 30)
        
        let lab = SKLabelNode(fontNamed: "Chalkduster")
        lab.text = "Binary Search"
        lab.fontSize = 55
        lab.fontColor = NSColor.white
        lab.position = CGPoint(x: 20, y: sceneView.bounds.midY / 2)
        
        scene.addChild(vv)
        scene.addChild(lab)
    }
    
    public func present(){
        self.sceneView.presentScene(self.scene)
    }
}

import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

public class AboutAdamController : SKScene {
    
    private var clickDetector: ClickDetector<AboutAdamController> = ClickDetector()
    private var buttons: [SKLabelNode]?;
    private var callTable: [(btnName: String, function: (AboutAdamController) -> Void)] = [
        (btnName: "back", function: AboutAdamController.doBack),
    ]
    
    private var homeScreen: HomeScreenController?;
    
    public func setHomeScreen(home: HomeScreenController){
        self.homeScreen = home;
    }
    
    override public func sceneDidLoad() {
        // Init goes here
        let back = self.childNode(withName: "back") as! SKLabelNode;
        buttons = [back];
    }
    
    public override func mouseDown(with event: NSEvent) {
        self.clickDetector.detectClick(event: event, view: view!, this: self, buttons: self.buttons!, callTable: self.callTable);
    }
    
    public static func doBack(this: AboutAdamController){
        let doorsClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
        this.view!.presentScene(this.homeScreen!, transition: doorsClose)
    }
}

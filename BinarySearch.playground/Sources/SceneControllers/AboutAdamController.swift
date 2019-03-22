import AppKit
import SpriteKit
import PlaygroundSupport
import Foundation

/**
A Scene to control the back button for the About Adam Scene
*/
public class AboutAdamController : SKScene {
    
    /// clickDetector will detect which SKNode is clicked and call the appropreate method in the callTable
    private var clickDetector: ClickDetector<AboutAdamController> = ClickDetector()
    private var callTable: [(btnName: String, function: (AboutAdamController) -> () -> Void)] = [
        (btnName: "back", function: AboutAdamController.doBack)
    ]
    
    private var homeScreen: HomeScreenController?;
    
    /**
    Tell the object the SKScene to go to when back is pressed
    */
    public func setHomeScreen(home: HomeScreenController){
        self.homeScreen = home;
    }
    
    override public func sceneDidLoad() {
        // Init goes here
        let back = self.childNode(withName: "back");
        if(back == nil){
            print("AboutAdamController back is nil")
            exit(1)
        }
    }
    
    public override func mouseDown(with event: NSEvent) {
        self.clickDetector.detectClick(event: event, view: view!, this: self, callTable: self.callTable);
    }
    
    /**
    The back button. This is called when the back button is pressed on screen.
    This will hand control back the the home screen. 
    */
    public func doBack(){
        let doorsClose = SKTransition.doorsCloseVertical(withDuration: 1.0)
        self.view!.presentScene(self.homeScreen!, transition: doorsClose)
    }
}

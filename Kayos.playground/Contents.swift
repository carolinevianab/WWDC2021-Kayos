import Foundation
import PlaygroundSupport
import SpriteKit

class GameScene: SKScene {
    // MARK: Class intances
    let sky = Sky()
    let lorenz = LorenzAttractor()
    let aizawa = AizawaAttractor()
    let thomas = ThomasAttractor()
    let chua = ChuaAttractor()
    
    // MARK: Variables
    var counter = 0
    var timer: Timer?
    
    // MARK: didMove
    override func didMove(to view: SKView) {
        sky.mainMenu(myScene: self)
    }
    
    // MARK: touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let touchLocation = touch.location(in: self)
        
        if sky.isStateDialog && sky.isStateIntro {
            let a = childNode(withName: "Hide")
            if !(a?.contains(touchLocation) ?? true) {
                counter += 1
                sky.dialogController(who: "Intro", counter: counter)
            }
        }
        else if sky.isStateDialog && !sky.isStateIntro {
            let a = childNode(withName: "Hide")
            if !(a?.contains(touchLocation) ?? true) {
                counter += 1
                sky.dialogController(who: sky.dialog, counter: counter)
            }
        }
        
        // Goes through each children and validates its name
        for child in children {
            if child.contains(touchLocation) {
                switch child.name {
                case "Start":
                    child.run(SKAction.fadeOut(withDuration: 2), completion: {
                        child.removeFromParent()
                        self.sky.intro()
                    })
                    self.childNode(withName: "Background")?.run(SKAction.fadeOut(withDuration: 2), completion: {
                        self.childNode(withName: "Background")?.removeFromParent()
                    })
                    break
                case "Hide":
                    if sky.isStateDialog && sky.isStateIntro {
                        counter = 15
                        sky.dialogController(who: "Intro", counter: counter)
                    }
                    else if sky.isStateDialog && !sky.isStateIntro {
                        counter = 15
                        sky.dialogController(who: sky.dialog, counter: counter)
                    }
                    else {
                        sky.hideMenu()
                    }
                    break
                case "Lorenz":
                    if sky.isMenuHidden { return }
                    changeAttractor(toWho: "Lorenz")
                    sky.hideMenu()
                    let label = childNode(withName: "labelHide") as! SKLabelNode
                    label.text = "Skip"
                    break
                case "Aizawa":
                    if sky.isMenuHidden { return }
                    changeAttractor(toWho: "Aizawa")
                    sky.hideMenu()
                    let label = childNode(withName: "labelHide") as! SKLabelNode
                    label.text = "Skip"
                    break
                case "Thomas":
                    if sky.isMenuHidden { return }
                    changeAttractor(toWho: "Thomas")
                    sky.hideMenu()
                    let label = childNode(withName: "labelHide") as! SKLabelNode
                    label.text = "Skip"
                    break
                case "Chua":
                    if sky.isMenuHidden { return }
                    changeAttractor(toWho: "Chua")
                    sky.hideMenu()
                    let label = childNode(withName: "labelHide") as! SKLabelNode
                    label.text = "Skip"
                    break
                default:
                    break
                }
                
            }
        }
    }
    
    // MARK: changeAttractor
    // Call the necessary functions for switching the attractor playing on screen
    func changeAttractor(toWho: String){
        timer?.invalidate()
        counter = 0
        sky.dialog = toWho
        sky.isStateDialog = true
        sky.dialogController(who: toWho, counter: counter)
        
        switch toWho {
        case "Lorenz":
            lorenz.z.removeAll()
            for _ in Range(1...50) {
                lorenz.z.append(0.01 * 15)
            }
            sky.startStar(mux: 15)
            startTimer(Time: 0.05, Who: toWho)
            break
        case "Aizawa":
            aizawa.z.removeAll()
            for _ in Range(1...50) {
                aizawa.z.append(0.01 * 200)
            }
            sky.startStar(mux: 200)
            startTimer(Time: 0.05, Who: toWho)
            break
        case "Thomas":
            thomas.z.removeAll()
            for _ in Range(1...50) {
                thomas.z.append(0.01 * 100)
            }
            sky.startStar(mux: 100)
            startTimer(Time: 0.01, Who: toWho)
            break
        case "Chua":
            chua.z.removeAll()
            for _ in Range(1...50) {
                chua.z.append(0.01 * 50)
            }
            counter = 0
            sky.startStar(mux: 50)
            startTimer(Time: 0.04, Who: toWho)
            break
        default:
            break
        }
    }
    
    // MARK: startTimer
    // Starts a timer to update the stars
    func startTimer(Time: TimeInterval, Who: String){
        timer = Timer.scheduledTimer(withTimeInterval: Time, repeats: true, block: { timer in
            if Who == "Lorenz" && self.lorenz.z.count == 50 {
                self.lorenz.updatePoints(children: self.children)
            }
            else if Who == "Aizawa" && self.aizawa.z.count == 50 {
                self.aizawa.updatePoints(children: self.children)
            }
            else if Who == "Thomas" && self.thomas.z.count == 50 {
                self.thomas.updatePoints(children: self.children)
            }
            else if Who == "Chua" && self.chua.z.count == 50 {
                self.chua.updatePoints(children: self.children)
            }
        })
        timer!.fire()
    }
}

// MARK: begin
// Creates the view and scene, and runs them on the playground
let viewScene = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
let scene = GameScene(size: CGSize(width: 1024, height: 768))

scene.scaleMode = .aspectFill
scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

viewScene.presentScene(scene)

PlaygroundSupport.PlaygroundPage.current.liveView = viewScene

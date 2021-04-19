import Foundation
import SpriteKit

public class Sky {
    // MARK: Variables and constants
    var scene: SKScene?
    var timer: Timer?
    var secCount = 0
    let exceptionsHide = ["Hide", "KayTalks", "Star", "Kay", "labelHide", "StarsEmitter", "tapAnywhere"]
    let kayTalks = SKLabelNode(text: "I'm Kay")
    let playing = SKLabelNode(text: "Playing: None")
    let tapAnywhere = SKLabelNode(text: "(Tap anywhere to continue.)")
    
    // MARK: Public vars
    public var isStateDialog = false
    public var isStateIntro = false
    public var isMenuHidden = true
    public var dialog = ""
    
    // MARK: String texts
    let lorenzText = ["This is the one Lorenz discovered.",
                      "It is the most famous as well.",
                      "Its shape, seen from this angle, looks like a butterfly.",
                      "And the butterfly effect was born."]
    
    let aizawaText = ["This is a particular case of the Lorenz Attractor.",
                      "The shape it creates is like a sphere, with a tube inside.",
                      "Here, we can't really see the tube.",
                      "So they'll spin around, and get clustered in the middle."]
    
    let thomasText = ["This one is called \"Thomas Attractor\"",
                      "It's symmetrical in all three points of view.",
                      "The stars follow close at first, like a chain to soon be broken..."]
    
    let chuaText = ["This came from an electric circuit, called Chua Circuit.",
                    "It's also known as double scroll attractor...",
                    "...because it has two rings connected.",
                    "They like to jump from one to the other sometimes."]
    
    let introText = ["It all started with the weather...",
                     "...When Ed Lorenz decided to simulate it.",
                     "He noticed that any tiny difference in the initial conditions...",
                     "...brought us to a very different result.",
                     "And with such sensitivity to the initial conditions...",
                     "...It was impossible to predict the future states.",
                     "The paths never overlap. Infinitely close, but never forming a loop.",
                     "But sometimes, they evolve into a particular area, known as a strange attractor.",
                     "Many were discovered over time...",
                     "You can see some of them here with me...",
                     "...After all, there’s a \"Kay\" when you say \"chaos\""]
    // MARK: End String texts
    
    public init(){}
    
    // MARK: Main Menu Related
    // All the functions related to the experience's main menu
    
    
    // MARK: mainMenu
    // Does all the setup for the main menu
    public func mainMenu(myScene: SKScene){
        scene = myScene
        backgroundAnimation()
        startButton()
    }
    
    // MARK: backgroundAnimation
    // Crates a node for the menu's background and animates it
    func backgroundAnimation(){
        let background = SKSpriteNode(imageNamed: "kayMenu1")
        background.name = "Background"
        background.position = CGPoint(x: scene!.frame.midX, y: scene!.frame.midY)
        background.size = scene!.size
        background.zPosition = 0
        scene!.addChild(background)
        
        let sprites = [SKTexture(imageNamed: "kayMenu1"),SKTexture(imageNamed: "kayMenu2"),SKTexture(imageNamed: "kayMenu3"),SKTexture(imageNamed: "kayMenu4")]
        let spritesInverted = [SKTexture(imageNamed: "kayMenu4"),SKTexture(imageNamed: "kayMenu3"),SKTexture(imageNamed: "kayMenu2"),SKTexture(imageNamed: "kayMenu1")]
        
        let animate = SKAction.repeatForever(SKAction.sequence([SKAction.animate(with: sprites, timePerFrame: 0.1),
                                                                SKAction.animate(with: spritesInverted, timePerFrame: 0.1),
                                                                SKAction.wait(forDuration: 0.4)]))
        
        background.run(animate)
    }
    
    // MARK: startButton
    // Crates a node for the menu's start button
    func startButton(){
        let frame = scene!.frame
        let btn = SKShapeNode(circleOfRadius: 150)
        btn.position = CGPoint(x: frame.midX + frame.minX / 2.5, y: frame.midY + frame.minY / 3)
        btn.name = "Start"
        btn.fillColor = .clear
        btn.strokeColor = .clear
        btn.zPosition = 2
        scene!.addChild(btn)
    }
    // MARK: End Main Menu Related
    
    
    
    // MARK: Intro Related
    // All the functions related to the experience's introduction section
    
    
    // MARK: intro
    // Does all the setup for the introduction, setting up the labels and buttons needed and starting the intro sequence
    public func intro(){
        let frame = scene!.frame
        kayTalks.alpha = 0
        kayTalks.name = "KayTalks"
        kayTalks.fontName = "Noteworthy-Light"
        kayTalks.fontSize = frame.maxY / 12
        kayTalks.position = CGPoint(x: frame.midX, y: frame.minY + frame.maxY/3)
        kayTalks.numberOfLines = 2
        scene!.addChild(kayTalks)
        
        isStateIntro = true
        initiateIntro()
        
        generateButton(name: "Hide", frame: frame, form: CGRect(x: frame.minX/2 + (29 * frame.maxX / 26), y: frame.maxY - frame.maxY/5, width: frame.maxX/3.41333, height: frame.maxY/8.53333))
        let label = scene!.childNode(withName: "labelHide") as! SKLabelNode
        label.text = "Skip"
        createKay()
    }
    
    // MARK: initiateIntro
    // Positions the tap anywhere label, defines the state of the experience as a dialog state and call the dialog controller to iniciate the text sequence
    func initiateIntro(){
        tapAnywhere.name = "tapAnywhere"
        tapAnywhere.fontSize = kayTalks.fontSize - 7
        tapAnywhere.fontName = "Noteworthy-Light"
        tapAnywhere.alpha = 0
        tapAnywhere.position = CGPoint(x: kayTalks.position.x, y: kayTalks.position.y - 75)
        scene!.addChild(tapAnywhere)
        
        isStateDialog = true
        dialogController(who: "Intro", counter: 0)
    }
    
    // MARK: dialogController
    // Does all the setup and changes in the labels spoken by Kay, depending on what is happening
    // Also instantiace a timer for the tap anywhere label to fade in if the user doesn't advance the dialogs
    public func dialogController(who: String, counter: Int){
        tapAnywhere.run(SKAction.fadeOut(withDuration: 1))
        secCount = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.secCount += 1
            if self.secCount == 6 {
                self.tapAnywhere.run(SKAction.fadeIn(withDuration: 1))
            }
        })
        timer!.fire()
        
        switch who {
        case "Lorenz":
            if counter >= lorenzText.count {
                endText()
                break
            }
            changeText(Text: lorenzText[counter], node: kayTalks, duration: 1)
            break
        case "Aizawa":
            if counter >= aizawaText.count {
                endText()
                break
            }
            changeText(Text: aizawaText[counter], node: kayTalks, duration: 1)
            break
        case "Thomas":
            if counter >= thomasText.count {
                endText()
                break
            }
            changeText(Text: thomasText[counter], node: kayTalks, duration: 1)
            break
        case "Chua":
            if counter >= chuaText.count {
                endText()
                break
            }
            changeText(Text: chuaText[counter], node: kayTalks, duration: 1)
            break
        case "Intro":
            if counter >= introText.count {
                let kay = scene!.childNode(withName: "Kay")
                kay?.run(SKAction.fadeAlpha(to: 0.4, duration: 2))
                endIntro()
                if scene!.childNode(withName: "StarsEmitter") == nil {
                    createStarEmitter(skipped: true)
                }
                break
            }
            if counter == 6 {
                createStarEmitter(skipped: false)
            }
            if counter == 9 {
                let kay = scene!.childNode(withName: "Kay")
                kay?.run(SKAction.fadeAlpha(to: 0.4, duration: 2))
            }
            changeText(Text: introText[counter], node: kayTalks, duration: 1)
            break
        default:
            break
        }
    }
    
    // MARK: createStarEmitter
    // Creates the stars used in the background of the experience, using an emitter
    func createStarEmitter(skipped: Bool){
        let stars = SKEmitterNode(fileNamed: "stars")!
        stars.position = CGPoint(x: scene!.frame.midX, y: scene!.frame.midY)
        stars.particlePositionRange = CGVector(dx: abs(scene!.frame.minX) + scene!.frame.maxX, dy: abs(scene!.frame.minY) + scene!.frame.maxY)
        stars.name = "StarsEmitter"
        stars.zPosition = 0
        stars.alpha = 0.3
        if skipped {
            stars.advanceSimulationTime(3)
        }
        scene!.addChild(stars)
    }
    
    // MARK: endIntro
    // Ends the intro sequence, and setup the experience's menu
    func endIntro(){
        isStateDialog = false
        isStateIntro = false
        kayTalks.removeAllActions()
        kayTalks.run(SKAction.fadeOut(withDuration: 1))
        timer?.invalidate()
        tapAnywhere.run(SKAction.fadeOut(withDuration: 1))
        startSky()
        isMenuHidden = false
        
        let label = scene!.childNode(withName: "labelHide") as! SKLabelNode
        label.text = "Hide"
    }
    // MARK: End Intro Related
    
    
    
    // MARK: Experience
    // All the functions related to the experience itself
    
    
    // MARK: createKay
    // Creates a Kay in the middle of the screen
    func createKay(){
        let kay = SKSpriteNode(imageNamed: "floatingKay1")
        kay.position = CGPoint(x: scene!.frame.midX, y: scene!.frame.midY)
        kay.size = CGSize(width: kay.size.width / 9, height: kay.size.height / 9)
        kay.alpha = 0
        kay.zPosition = 1
        kay.name = "Kay"
        scene!.addChild(kay)
        
        let animation = [SKTexture(imageNamed: "floatingKay1"), SKTexture(imageNamed: "floatingKay2")]
        let animationInverted = animation.reversed() as [SKTexture]
        let wait = SKAction.wait(forDuration: 0.3)
        
        let animate = [SKAction.animate(with: animation, timePerFrame: 0.3), wait, SKAction.animate(with: animationInverted, timePerFrame: 0.3), wait]
        kay.run(SKAction.repeatForever(SKAction.sequence(animate)))
        
        let movement = [SKAction.moveTo(y: 5, duration: 2), wait, SKAction.moveTo(y: -5, duration: 2), wait]
        kay.run(SKAction.repeatForever(SKAction.sequence(movement)))
    }
    
    // MARK: startSky
    // Setup all the buttons needed in the menu and the labels used
    func startSky(){
        let frame = scene!.frame
        generateButton(name: "Lorenz", frame: frame, form: CGRect(x: frame.minX/2 - frame.maxX/2.6, y: frame.minY + frame.maxY/6, width: frame.maxX/3.41333, height: frame.maxY/8.53333))
        generateButton(name: "Aizawa", frame: frame, form: CGRect(x: frame.minX/2 + 3 * frame.maxX/26, y: frame.minY + frame.maxY/6, width: frame.maxX/3.41333, height: frame.maxY/8.53333))
        generateButton(name: "Thomas", frame: frame, form: CGRect(x: frame.minX/2 + 8 * frame.maxX/13, y: frame.minY + frame.maxY/6, width: frame.maxX/3.41333, height: frame.maxY/8.53333))
        generateButton(name: "Chua", frame: frame, form: CGRect(x: frame.minX/2 + 29 *  frame.maxX/26, y: frame.minY + frame.maxY/6, width: frame.maxX/3.41333, height: frame.maxY/8.53333))
        
        playing.horizontalAlignmentMode = .left
        playing.position = CGPoint(x: frame.minX/2 - frame.maxX/2.6, y: frame.maxY - frame.maxY/5)
        playing.alpha = 0
        playing.fontName = "Noteworthy-Light"
        playing.fontSize = frame.maxY / 12
        playing.zPosition = 3
        scene!.addChild(playing)
        playing.run(SKAction.fadeIn(withDuration: 1))
        
    }
    
    // MARK: hideMenu
    // Responsible for hiding and revealing buttons and labels, except for nodes with the names in the array of exceptions
    public func hideMenu(){
        isMenuHidden.toggle()
        for child in scene!.children{
            if !exceptionsHide.contains(child.name ?? "") {
                if isMenuHidden {
                    child.run(SKAction.fadeOut(withDuration: 1))
                }
                else {
                    child.run(SKAction.fadeIn(withDuration: 1))
                }
            }
        }
    }
    
    // MARK: startStar
    // Clears the stars in the scene, and start a new set of stars for a new attractor
    // Also changes the label's text for the current attractor playing
    public func startStar(mux: Double){
        clearSky()
        var xy = 0.01
        for _ in Range(1...50){
            generateStar(xy: xy * mux)
            xy += 0.01
        }
        
        switch mux {
        case 15:
            changeText(Text: "Playing: Lorenz Attractor", node: playing, duration: 5)
            break
        case 200:
            changeText(Text: "Playing: Aizawa Attractor", node: playing, duration: 5)
            break
        case 100:
            changeText(Text: "Playing: Thomas Attractor", node: playing, duration: 5)
            break
        case 50:
            changeText(Text: "Playing: Chua Attractor", node: playing, duration: 5)
            break
        default:
            break
        }
    }
    
    // MARK: clearSky
    // Remove all the existing stars in the scene
    func clearSky(){
        for star in scene!.children {
            if star.name == "Star" {
                star.removeFromParent()
            }
        }
    }
    
    // MARK: generateStar
    // Creates a star object in the scene
    func generateStar(xy: Double){
        let star = SKShapeNode(circleOfRadius: 2)
        star.fillColor = .white
        star.name = "Star"
        star.position = CGPoint(x: xy, y: xy)
        star.zPosition = 4
        scene?.addChild(star)
    }
    
    // MARK: endText
    // Similar to the endIntro function, but show the menu intead of instantiating it
    func endText(){
        isStateDialog = false
        isStateIntro = false
        kayTalks.removeAllActions()
        kayTalks.run(SKAction.fadeOut(withDuration: 1))
        timer?.invalidate()
        tapAnywhere.run(SKAction.fadeOut(withDuration: 1))
        hideMenu()
        
        let label = scene!.childNode(withName: "labelHide") as! SKLabelNode
        label.text = "Hide"
    }
    
    // MARK: End Experience
    
    
    
    // MARK: General
    // Functions used in more than one context
    
    
    // MARK: changeText
    // Changes the text in the label
    public func changeText(Text: String, node: SKLabelNode, duration: TimeInterval) {
        let animation = SKAction.sequence([SKAction.wait(forDuration: duration),
                                           SKAction.fadeIn(withDuration: 1)])
        
        node.run(SKAction.fadeOut(withDuration: 1), completion: {
            node.text = Text
            node.run(animation)
        })
    }
    
    // MARK: generateButton
    // Creates a button with a label inside
    func generateButton(name: String, frame: CGRect, form: CGRect){
        let btn = SKShapeNode(rect: form, cornerRadius: 5)
        btn.name = name
        btn.fillColor = .white
        btn.alpha = 0
        btn.zPosition = 3
        scene!.addChild(btn)
        btn.run(SKAction.fadeIn(withDuration: 1))
        
        let label = SKLabelNode(text: name)
        label.position = CGPoint(x: form.midX, y: form.midY)
        label.fontName = "Noteworthy-Light"
        label.fontSize = frame.maxY / 12
        label.fontColor = .black
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.alpha = 0
        label.zPosition = 7
        label.name = "label\(name)"
        scene!.addChild(label)
        label.run(SKAction.fadeIn(withDuration: 1))
    }
    
    
}

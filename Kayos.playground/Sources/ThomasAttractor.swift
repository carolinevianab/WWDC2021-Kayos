import Foundation
import SpriteKit

public class ThomasAttractor {
    // MARK: Constants used in the equation
    let b: Double = 0.19
    let dt: Double = 0.01
    
    // Array used for storing the Z positions for each star
    public var z: [Double] = []
    
    public init() {}
    
    // MARK: updatePoints
    // updates each star for each iteration
    // Axis shown: X and Y
    public func updatePoints(children: [SKNode]){
        var countZ = 0
        for star in children {
            if star.name == "Star"{
                let cordinates = thomasSystem(x: Double(star.position.x)/100, y: Double(star.position.y)/100, z: z[countZ]/100)
                star.position.x = CGFloat(cordinates.0 * 100)
                star.position.y = CGFloat(cordinates.1 * 100)
                z[countZ]  = cordinates.2 * 100
                countZ += 1
            }
            
        }
    }
    
    // MARK: thomasSystem
    // The system of equations for the attractor
    func thomasSystem(x: Double, y: Double, z: Double) -> (Double, Double, Double) {
        let dx = (sin(y) - b * x) * dt
        let dy = (sin(z) - b * y) * dt
        let dz = (sin(x) - b * z) * dt
        let xn = x + dx
        let yn = y + dy
        let zn = z + dz
        return (xn,yn,zn)
        
    }
}


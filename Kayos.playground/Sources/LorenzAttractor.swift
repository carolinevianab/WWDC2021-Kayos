import Foundation
import SpriteKit

public class LorenzAttractor {
    // MARK: Constants used in the equation
    let sigma: Double = 10
    let rho: Double = 28
    let beta: Double = 8/3
    let dt = 0.01
    
    // Array used for storing the Z positions for each star
    public var z: [Double] = []
    
    public init(){}
    
    // MARK: updatePoints
    // updates each star for each iteration
    // Axis shown: X and Z
    public func updatePoints(children: [SKNode]){
        var countZ = 0
        for star in children {
            if star.name == "Star"{
                let cordinates = lorenzSystem(x: Double(star.position.x)/15, y: z[countZ], z: (Double(star.position.y) + 400)/15)
                star.position.x = CGFloat(cordinates.0 * 15)
                star.position.y = CGFloat((cordinates.2 * 15) - 400)
                z[countZ]  = cordinates.1
                countZ += 1
            }
            
        }
    }
    
    // MARK: lorenzSystem
    // The system of equations for the attractor
    func lorenzSystem(x: Double, y: Double, z: Double) -> (Double, Double, Double) {
        let dx = (sigma * (y - x)) * dt
        let dy = (x * (rho - z) - y) * dt
        let dz = (x * y - beta * z) * dt
        let xn = x + dx
        let yn = y + dy
        let zn = z + dz
        return (xn,yn,zn)
        
    }
    
    
}

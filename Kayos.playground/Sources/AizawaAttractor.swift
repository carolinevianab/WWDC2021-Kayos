import Foundation
import SpriteKit

public class AizawaAttractor {
    // MARK: Constants used in the equation
    let alpha: Double = 0.95
    let beta: Double = 0.7
    let gamma: Double = 0.6
    let delta: Double = 3.5
    let epsilon: Double = 0.25
    let zeta: Double = 0.1
    let dt = 0.01
    
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
                let cordinates = aizawaSystem(x: Double(star.position.x)/200, y: Double(star.position.y)/200, z: z[countZ]/200)
                star.position.x = CGFloat(cordinates.0 * 200)
                star.position.y = CGFloat(cordinates.1 * 200)
                z[countZ]  = cordinates.2 * 200
                countZ += 1
            }
            
        }
    }
    
    // MARK: aizawaSystem
    // The system of equations for the attractor
    func aizawaSystem(x: Double, y: Double, z: Double) -> (Double, Double, Double) {
        let dx = ((z - beta) * x - delta * y) * dt
        let dy = (delta * x + (z - beta) * y) * dt
        let dz = (gamma + alpha * z - (pow(z, 3) / 3 ) - (pow(x, 2) + pow(y, 2)) * (1 + epsilon * z) + zeta * z * pow(x, 3)) * dt
        let xn = x + dx
        let yn = y + dy
        let zn = z + dz
        return (xn,yn,zn)
        
    }
}


import Foundation
import SpriteKit

public class ChuaAttractor {
    // MARK: Constants used in the equation
    let a: Double = 15.6
    let b: Double = 1
    let c: Double = 25.58
    let d: Double = -1
    let e: Double = 0
    let dt = 0.01
    
    // Array used for storing the Z positions for each star
    public var z: [Double] = []
    
    public init() {}
    
    // MARK: updatePoints
    // updates each star for each iteration
    // Axis shown: X and Z
    public func updatePoints(children: [SKNode]){
        var countZ = 0
        for star in children {
            if star.name == "Star"{
                let cordinates = chuaSystem(x: Double(star.position.x)/50, y: z[countZ]/50, z: (Double(star.position.y))/50)
                star.position.x = CGFloat(cordinates.0 * 50)
                star.position.y = CGFloat(cordinates.2 * 50)
                z[countZ]  = cordinates.1 * 50
                countZ += 1
            }
            
        }
    }
    
    // MARK: chuaSystem
    // The system of equations for the attractor
    func chuaSystem(x: Double, y: Double, z: Double) -> (Double, Double, Double) {
        let dx = (a * (y - x - G(x: x))) * dt
        let dy = (b * (x - y + z)) * dt
        let dz = (-c * y) * dt
        let xn = x + dx
        let yn = y + dy
        let zn = z + dz
        return (xn,yn,zn)
        
    }
    
    // MARK: G
    // A function used in the system
    func G(x: Double) -> Double {
        let g = e * x + (d + e) * (abs(x + 1) - abs(x - 1))
        return g
    }
}


import Foundation

struct Moons {
    var moons: [Moon]
    
    mutating func applyGravity() {
        pairs.forEach { (moonPair) in
            moonPair[0].applyGravity(moon: moonPair[1])
            moonPair[1].applyGravity(moon: moonPair[0])
        }
    }
    
    mutating func applyVelocity() {
        moons.forEach { $0.applyVelocity() }
    }
    
    mutating func apply(times: Int) {
        for _ in 1...times {
            applyGravity()
            applyVelocity()
        }
    }
    
    var pairs: [[Moon]] {
        return [
        [moons[0], moons[1]],
        [moons[0], moons[2]],
        [moons[0], moons[3]],
        [moons[1], moons[2]],
        [moons[1], moons[3]],
        [moons[2], moons[3]]
        ]
    }
    
    var totalEnergy: Int {
        moons.reduce(0, { $0 + $1.energy })
    }
}

class Moon {
    var velocity = Vector3(x: 0, y: 0, z: 0)
    var position: Vector3
    
    init(position: Vector3) {
        self.position = position
    }
    
    func applyGravity(moon: Moon) {
        velocity.x += gravityFor(selfPos: position.x, moonPos: moon.position.x)
        velocity.y += gravityFor(selfPos: position.y, moonPos: moon.position.y)
        velocity.z += gravityFor(selfPos: position.z, moonPos: moon.position.z)
    }
    
    func applyVelocity() {
        position.x += velocity.x
        position.y += velocity.y
        position.z += velocity.z
    }
    
    var energy: Int {
        return velocity.energy * position.energy
    }
    
    func gravityFor(selfPos: Int, moonPos: Int) -> Int {
        return selfPos < moonPos ? 1 : (selfPos == moonPos ? 0 : -1)
    }
}

struct Vector3 {
    var x: Int
    var y: Int
    var z: Int
    
    var energy: Int {
        return abs(x) + abs(y) + abs(z)
    }
}

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
    
    func calculateCycleLengthX() -> Int {
        var moons = Moons(moons: self.moons)
        let positions = [
            self.moons[0].position.x,
            self.moons[1].position.x,
            self.moons[2].position.x,
            self.moons[3].position.x
        ]
        let velocities = [
            self.moons[0].velocity.x,
            self.moons[1].velocity.x,
            self.moons[2].velocity.x,
            self.moons[3].velocity.x
        ]
        moons.apply(times: 1)
        var newPositions = [
        moons.moons[0].position.x,
        moons.moons[1].position.x,
        moons.moons[2].position.x,
        moons.moons[3].position.x
        ]
        var newVelocities = [
        moons.moons[0].velocity.x,
        moons.moons[1].velocity.x,
        moons.moons[2].velocity.x,
        moons.moons[3].velocity.x
        ]
        var i = 1
        while (positions != newPositions || velocities != newVelocities) {
            moons.apply(times: 1)
            newPositions = [
            moons.moons[0].position.x,
            moons.moons[1].position.x,
            moons.moons[2].position.x,
            moons.moons[3].position.x
            ]
            newVelocities = [
            moons.moons[0].velocity.x,
            moons.moons[1].velocity.x,
            moons.moons[2].velocity.x,
            moons.moons[3].velocity.x
            ]
            i+=1
        }
        return i
    }
    
    func calculateCycleLengthY() -> Int {
        var moons = Moons(moons: self.moons)
        let positions = [
            self.moons[0].position.y,
            self.moons[1].position.y,
            self.moons[2].position.y,
            self.moons[3].position.y
        ]
        let velocities = [
            self.moons[0].velocity.y,
            self.moons[1].velocity.y,
            self.moons[2].velocity.y,
            self.moons[3].velocity.y
        ]
        moons.apply(times: 1)
        var newPositions = [
        moons.moons[0].position.y,
        moons.moons[1].position.y,
        moons.moons[2].position.y,
        moons.moons[3].position.y
        ]
        var newVelocities = [
        moons.moons[0].velocity.y,
        moons.moons[1].velocity.y,
        moons.moons[2].velocity.y,
        moons.moons[3].velocity.y
        ]
        var i = 1
        while (positions != newPositions || velocities != newVelocities) {
            moons.apply(times: 1)
            newPositions = [
            moons.moons[0].position.y,
            moons.moons[1].position.y,
            moons.moons[2].position.y,
            moons.moons[3].position.y
            ]
            newVelocities = [
            moons.moons[0].velocity.y,
            moons.moons[1].velocity.y,
            moons.moons[2].velocity.y,
            moons.moons[3].velocity.y
            ]
            i+=1
        }
        return i
    }
    
    func calculateCycleLengthZ() -> Int {
        var moons = Moons(moons: self.moons)
        let positions = [
            self.moons[0].position.z,
            self.moons[1].position.z,
            self.moons[2].position.z,
            self.moons[3].position.z
        ]
        let velocities = [
            self.moons[0].velocity.z,
            self.moons[1].velocity.z,
            self.moons[2].velocity.z,
            self.moons[3].velocity.z
        ]
        moons.apply(times: 1)
        var newPositions = [
        moons.moons[0].position.z,
        moons.moons[1].position.z,
        moons.moons[2].position.z,
        moons.moons[3].position.z
        ]
        var newVelocities = [
        moons.moons[0].velocity.z,
        moons.moons[1].velocity.z,
        moons.moons[2].velocity.z,
        moons.moons[3].velocity.z
        ]
        var i = 1
        while (positions != newPositions || velocities != newVelocities) {
            moons.apply(times: 1)
            newPositions = [
            moons.moons[0].position.z,
            moons.moons[1].position.z,
            moons.moons[2].position.z,
            moons.moons[3].position.z
            ]
            newVelocities = [
            moons.moons[0].velocity.z,
            moons.moons[1].velocity.z,
            moons.moons[2].velocity.z,
            moons.moons[3].velocity.z
            ]
            i+=1
        }
        return i
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

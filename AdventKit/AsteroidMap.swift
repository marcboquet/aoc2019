import Foundation

struct AsteroidMap {
    let asteroids: [Asteroid]
    
    init(map: String) {
        var asteroids = [Asteroid]()
        var y = 0
        for line in map.lines {
            var x = 0
            for character in line {
                if character != "." {
                    asteroids.append(Asteroid(position: CGPoint(x: x, y: y)))
                }
                x += 1
            }
            y += 1
        }
        self.asteroids = asteroids
    }
    
    func bestAsteroid() -> (asteroid: Asteroid, linesOfSight: [CGVector : [CGVector]]) {
        let linesOfSight = asteroids.map { (asteroid: $0, linesOfSight: $0.linesOfSight(asteroids: asteroids)) }
        let best = linesOfSight.max { (losA, losB) -> Bool in
            losA.linesOfSight.count < losB.linesOfSight.count
        }
        return best!
    }

    struct Asteroid {
        let position: CGPoint
        
        func linesOfSight(asteroids: [Asteroid]) -> [CGVector : [CGVector]] {
            var vectors = [CGVector : [CGVector]]()
            for asteroid in asteroids {
                if asteroid.position == self.position { continue }
                let vector = CGVector(dx: asteroid.position.x - self.position.x, dy: asteroid.position.y - self.position.y)
                vectors[vector.normalized()] = (vectors[vector.normalized()] ?? []) + [vector]
            }
            return vectors
        }
    }
}

struct GiantLaser {
    var linesOfSight: [CGVector : [CGVector]]
    
    func orderedLOS() -> [(key: CGVector, value: [CGVector])] {
        linesOfSight.sorted { (losA, losB) -> Bool in
            losA.key.laserAngle < losB.key.laserAngle
        }
    }
    
    func orderedShots() -> [CGVector] {
        var ordered = orderedLOS()
        var shots = [CGVector]()
        while !ordered.allSatisfy({ $0.value.isEmpty }) {
            var i = 0
            ordered.forEach { (key, value) in
                if let shot = value.first {
                    shots.append(shot)
                    ordered[i].value = Array(value[1...])
                }
                i += 1
            }
        }
        return shots
    }
}

public extension CGVector {
    var laserAngle: CGFloat {
        // [1.5707963267948966, 0.7853981633974483, 0.0, -0.7853981633974483, -1.5707963267948966, -2.356194490192345, 3.141592653589793, 2.356194490192345, 1.5807959934815619]
        // -1.5707963267948966, -0.7853981633974483, 0.0, 0.7853981633974483, 1.5707963267948966, 2.356194490192345, 3.141592653589793, -2.356194490192345, -1.5807959934815619
        let angle: CGFloat = self.angle
        if angle < -CGFloat.pi / 2 {
            return angle + CGFloat.pi * 2
        }
        return angle// + CGFloat.pi / 2
    }
}

import Foundation

public struct OrbitMap {
    var orbits = ["COM": Orbit(name: "COM", rank: 0)]

    init(map: [String]) {
        for orbit in map {
            let objects = orbit.split(separator: ")")
            let orbited = String(objects[0])
            let orbiting = String(objects[1])
            if orbits[orbited] == nil {
                orbits[orbited] = Orbit(name: orbited)
            }
            if orbits[orbiting] == nil {
                orbits[orbiting] = Orbit(name: orbiting)
            }
            let child = orbits[orbiting]!
            orbits[orbited]?.addOrbit(orbit: child)
        }
    }
    
    func totalOrbits() -> Int {
        return orbits.reduce(0) { (numOrbits, orbit) -> Int in
            return numOrbits + (orbit.value.rank ?? 0)
        }
    }
    
    func santaDistance() -> Int {
        var jumps = 0
        var currentOrbit = orbits["YOU"]?.orbiting
        while !currentOrbit!.santaAround {
            currentOrbit = currentOrbit?.orbiting
            jumps += 1
        }
        while currentOrbit!.name != "SAN" {
            currentOrbit = currentOrbit?.orbits.first(where: { (orbit) -> Bool in
                orbit.santaAround
            })
            jumps += 1
        }
        return jumps - 1
    }
}

class Orbit {
    var orbits = [Orbit]()
    weak var orbiting: Orbit? {
        didSet {
            if let parentRank = orbiting?.rank {
                rank = parentRank + 1
            }
        }
    }

    let name: String
    var rank: Int? {
        didSet {
            if let rank = rank {
                self.orbits.forEach { $0.rank = rank + 1 }
            }
        }
    }
    var santaAround: Bool = false {
        didSet {
            if santaAround {
                orbiting?.santaAround = true
            }
        }
    }
    
    init(name: String, rank: Int? = nil) {
        self.name = name
        self.rank = rank
        if name == "SAN" {
            self.santaAround = true
        }
    }
    
    func addOrbit(orbit: Orbit) {
        orbits.append(orbit)
        orbit.orbiting = self
        if orbit.santaAround {
            self.santaAround = true
        }
    }
}

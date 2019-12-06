import Foundation

public struct OrbitMap {
    var orbits = ["COM": Orbit(name: "COM", rank: 0)]

    init(map: [String]) {
        for orbit in map {
            let objects = orbit.split(separator: ")").map{ String($0) }
            if orbits[objects[0]] == nil {
                orbits[objects[0]] = Orbit(name: objects[0])
            }
            if orbits[objects[1]] == nil {
                orbits[objects[1]] = Orbit(name: objects[1])
            }
            let child = orbits[objects[1]]!
            orbits[objects[0]]?.addOrbit(orbit: child)
        }
    }
    
    func totalOrbits() -> Int {
        return orbits.reduce(0) { (numOrbits, orbit) -> Int in
            return numOrbits + (orbit.value.rank ?? 0)
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
        
        init(name: String, rank: Int? = nil) {
            self.name = name
            self.rank = rank
        }
        
        func addOrbit(orbit: Orbit) {
            orbits.append(orbit)
            orbit.orbiting = self
        }
    }
}

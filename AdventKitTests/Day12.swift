import XCTest
@testable import AdventKit

class Day12: XCTestCase {

    func testExample1() {
        var moons = Moons(moons: [
        Moon(position: Vector3(x:-1, y:0, z:2)),
        Moon(position: Vector3(x:2, y:-10, z:-7)),
        Moon(position: Vector3(x:4, y:-8, z:8)),
        Moon(position: Vector3(x:3, y:5, z:-1))
        ])
        moons.apply(times: 10)
        XCTAssertEqual(moons.totalEnergy, 179)
    }

    func testSolutionPart1() {
        var moons = Moons(moons: [
        Moon(position: Vector3(x:-4, y:-14, z:8)),
        Moon(position: Vector3(x:1, y:-8, z:10)),
        Moon(position: Vector3(x:-15, y:2, z:1)),
        Moon(position: Vector3(x:-17, y:-17, z:16))
        ])
        moons.apply(times: 1000)
        XCTAssertEqual(moons.totalEnergy, 12466)
    }

}

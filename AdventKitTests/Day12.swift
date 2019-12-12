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

    func testExample2() {
        var moons = Moons(moons: [
        Moon(position: Vector3(x:-1, y:0, z:2)),
        Moon(position: Vector3(x:2, y:-10, z:-7)),
        Moon(position: Vector3(x:4, y:-8, z:8)),
        Moon(position: Vector3(x:3, y:5, z:-1))
        ])
        moons.apply(times: 100)
        XCTAssertEqual(moons.calculateCycleLengthX(), 18)
        XCTAssertEqual(moons.calculateCycleLengthY(), 28)
        XCTAssertEqual(moons.calculateCycleLengthZ(), 44)
        XCTAssertEqual(lcm(a: 18, b: lcm(a: 28, b: 44)), 2772)
    }

    func testSolutionPart2() {
        var moons = Moons(moons: [
        Moon(position: Vector3(x:-4, y:-14, z:8)),
        Moon(position: Vector3(x:1, y:-8, z:10)),
        Moon(position: Vector3(x:-15, y:2, z:1)),
        Moon(position: Vector3(x:-17, y:-17, z:16))
        ])
        moons.apply(times: 100)
        XCTAssertEqual(moons.calculateCycleLengthX(), 186028)
        XCTAssertEqual(moons.calculateCycleLengthY(), 286332)
        XCTAssertEqual(moons.calculateCycleLengthZ(), 108344)
        XCTAssertEqual(lcm(a: 186028, b: lcm(a: 286332, b: 108344)), 360689156787864)
    }

}


private func gcd(a: Int, b: Int) -> Int {
 
    return b == 0 ? a : gcd(a: b, b: a % b)
}

func lcm(a:Int, b:Int) -> Int {
    return abs(a * b) / gcd(a: a, b: b)
}

import XCTest
@testable import AdventKit

class Day6: XCTestCase {

    func testExample1() {
        let map = OrbitMap(map: ["B)C", "C)D", "D)E", "COM)B", "E)F", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L"])
        XCTAssertEqual(map.totalOrbits(), 42)
    }

    func testSolutionPart1() {
        let map = OrbitMap(map: InputReader(name: "6-1-input").lines())
        XCTAssertEqual(map.totalOrbits(), 140608)
    }

    func testExample2() {
        let map = OrbitMap(map: ["COM)B", "B)C", "C)D", "D)E", "E)F", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L", "K)YOU", "I)SAN"])
        XCTAssertEqual(map.santaDistance(), 4)
    }

    func testSolutionPart2() {
        let map = OrbitMap(map: InputReader(name: "6-1-input").lines())
        XCTAssertEqual(map.santaDistance(), 337)
    }
    
}

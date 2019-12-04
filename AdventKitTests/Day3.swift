import XCTest
@testable import AdventKit

class Day3: XCTestCase {

    func testPaths() {
        let wirePaths = [
            ["R8","U5","L5","D3"],
            ["U7","R6","D4","L4"]
        ]
        let panel = WirePanel(paths: wirePaths)
        
        XCTAssertEqual(panel.pathPoints.first!.last!, CGPoint(x: 3, y: 2))
        XCTAssertEqual(panel.pathPoints.last!.last!, CGPoint(x: 2, y: 3))
    }

    func testExample1() {
        let wirePaths = [
            ["R75","D30","R83","U83","L12","D49","R71","U7","L72"],
            ["U62","R66","U55","R34","D71","R55","D58","R83"]
        ]
        
        let panel = WirePanel(paths: wirePaths)
        XCTAssertEqual(panel.intersections().count, 5)
        
    }
    
    func testSolutionPart1() {
        let wirePaths = InputReader(name: "3-1-input").csv()
        let panel = WirePanel(paths: wirePaths)
        XCTAssertEqual(panel.manhattanDistance(), 3247)
    }
    
    func testSolutionPart2() {
        let wirePaths = InputReader(name: "3-1-input").csv()
        let panel = WirePanel(paths: wirePaths)
        XCTAssertEqual(panel.shortestWireDistance(), 48054)
    }
    
}

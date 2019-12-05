import XCTest
@testable import AdventKit

class Day5: XCTestCase {

    func testExample1() {
        let computer = Computer(program: [3,0,4,0,99])
        let output = try! computer.run(input: 123)
        XCTAssertEqual(computer.memory, [123,0,4,0,99])
        XCTAssertEqual(output, [123])
    }

    func testExample2() {
        let computer = Computer(program: [1002,4,3,4,33])
        _ = try! computer.run()
        XCTAssertEqual(computer.memory, [1002,4,3,4,99])
    }

    func testSolutionPart1() {
        let program: [Int] = InputReader(name: "5-1-input").csvLine()
        let computer = Computer(program: program)
        let output = try! computer.run(input: 1)
        XCTAssertEqual(output, [0, 0, 0, 0, 0, 0, 0, 0, 0, 5346030])
    }
    
}

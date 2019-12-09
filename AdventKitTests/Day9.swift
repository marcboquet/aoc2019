import XCTest
@testable import AdventKit

class Day9: XCTestCase {

    func testExample1() {
        let quine = [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99]
        let computer = Computer(program: quine)
        let output = try! computer.run()
        XCTAssertEqual(output, quine)
    }

    func testExample2() {
        let computer = Computer(program: [1102,34915192,34915192,7,4,7,99,0])
        let output = try! computer.run()
        XCTAssertEqual(output, [1219070632396864])
    }

    func testExample3() {
        let computer = Computer(program: [104,1125899906842624,99])
        let output = try! computer.run()
        XCTAssertEqual(output, [1125899906842624])
    }

    func testSolutionPart1() {
        let program: [Int] = InputReader(name: "9-1-input").csvLine()
        let computer = Computer(program: program)
        let output = try! computer.run(input: 1)
        XCTAssertEqual(output, [4080871669])
    }

    func testSolutionPart2() {
        let program: [Int] = InputReader(name: "9-1-input").csvLine()
        let computer = Computer(program: program)
        let output = try! computer.run(input: 2)
        XCTAssertEqual(output, [75202])
    }

}

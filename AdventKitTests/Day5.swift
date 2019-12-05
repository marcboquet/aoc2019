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
    
    // Part 2
    
    func testExample2_1() {
        let input = [3,9,8,9,10,9,4,9,99,-1,8]
        XCTAssertEqual(try! Computer(program: input).run(input: 8), [1])
        XCTAssertEqual(try! Computer(program: input).run(input: 6), [0])
    }
    
    func testExample2_2() {
        let input = [3,9,7,9,10,9,4,9,99,-1,8]
        XCTAssertEqual(try! Computer(program: input).run(input: 7), [1])
        XCTAssertEqual(try! Computer(program: input).run(input: 8), [0])
    }
    
    func testExample2_3() {
        let input = [3,3,1108,-1,8,3,4,3,99]
        XCTAssertEqual(try! Computer(program: input).run(input: 8), [1])
        XCTAssertEqual(try! Computer(program: input).run(input: 6), [0])
    }
    
    func testExample2_4() {
        let input = [3,3,1107,-1,8,3,4,3,99]
        XCTAssertEqual(try! Computer(program: input).run(input: 7), [1])
        XCTAssertEqual(try! Computer(program: input).run(input: 8), [0])
    }
    
    func testExample2_5() {
        let input = [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]
        XCTAssertEqual(try! Computer(program: input).run(input: 1), [1])
        XCTAssertEqual(try! Computer(program: input).run(input: 2), [1])
        XCTAssertEqual(try! Computer(program: input).run(input: 0), [0])
    }
    
    func testExample2_6() {
        let input = [3,3,1105,-1,9,1101,0,0,12,4,12,99,1]
        XCTAssertEqual(try! Computer(program: input).run(input: 1), [1])
        XCTAssertEqual(try! Computer(program: input).run(input: 2), [1])
        XCTAssertEqual(try! Computer(program: input).run(input: 0), [0])
    }
    
    func testExample2_7() {
        let input = [3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
        1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
        999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99]
        XCTAssertEqual(try! Computer(program: input).run(input: 1), [999])
        XCTAssertEqual(try! Computer(program: input).run(input: 8), [1000])
        XCTAssertEqual(try! Computer(program: input).run(input: 10), [1001])
    }

    func testSolutionPart2() {
        let program: [Int] = InputReader(name: "5-1-input").csvLine()
        let computer = Computer(program: program)
        let output = try! computer.run(input: 5)
        XCTAssertEqual(output, [513116])
    }
    
}

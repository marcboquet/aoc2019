import XCTest
@testable import AdventKit

class Day2: XCTestCase {
    
    func testSolutionPart1() {
        let items: [Int] = InputReader(name: "2-1-input").csvLine()
        XCTAssertEqual(Computer.run(inputItems: items).first!, 3654868)
    }
    
    func testSolutionPart2() {
        let items: [Int] = InputReader(name: "2-1-input").csvLine()
        let desiredOutput = 19690720
        var answer: Int?

        loopyloop: for noun in 0...99 {
            for verb in 0...99 {
                var testItems = items
                testItems[1] = noun
                testItems[2] = verb
                let output = Computer.run(inputItems: testItems)
                if output[0] == desiredOutput {
                    answer = 100 * noun + verb
                    break loopyloop
                }
            }
        }
        XCTAssertEqual(answer, 7014)
    }

}

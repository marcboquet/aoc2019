import XCTest
@testable import AdventKit

class Day13: XCTestCase {

    func testSolutionPart1() {
        let program: [Int] = InputReader(name: "13-input").csvLine()
        let arcade = Arcade(game: program)
        let output = arcade.run()
        var blocks = 0
        for tile in stride(from: 2, to: output.count, by: 3) {
            if output[tile] == 2 {
                blocks += 1
            }
        }
        XCTAssertEqual(blocks, 280)
    }

    func testSolutionPart2() {
        let program: [Int] = InputReader(name: "13-input").csvLine()
        let arcade = Arcade(game: program)
        let score = arcade.play()
        XCTAssertEqual(score, 13298)
    }

}

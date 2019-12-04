import XCTest
@testable import AdventKit

class Day4: XCTestCase {

    func testExample1() {
        let guesses = PasswordGuesser.guesses(range: 111111...111111)
        XCTAssertEqual(guesses.count, 1)
    }

    func testExample2() {
        let guesses = PasswordGuesser.guesses(range: 223450...223450)
        XCTAssertEqual(guesses.count, 0)
    }

    func testExample3() {
        let guesses = PasswordGuesser.guesses(range: 123789...123789)
        XCTAssertEqual(guesses.count, 0)
    }

    func testSolutionPart1() {
        let guesses = PasswordGuesser.guesses(range: 307237...769058)
        XCTAssertEqual(guesses.count, 889)
    }
    
    // Part 2
    
    func testExample4() {
        let guesses = PasswordGuesser.betterGuesses(range: 112233...112233)
        XCTAssertEqual(guesses.count, 1)
    }
    
    func testExample5() {
        let guesses = PasswordGuesser.betterGuesses(range: 123444...123444)
        XCTAssertEqual(guesses.count, 0)
    }
    
    func testExample6() {
        let guesses = PasswordGuesser.betterGuesses(range: 111122...111122)
        XCTAssertEqual(guesses.count, 1)
    }

    func testSolutionPart2() {
        let guesses = PasswordGuesser.betterGuesses(range: 307237...769058)
        XCTAssertEqual(guesses.count, 589)
    }
    
    // Performance
    
    func testPerformance() {
        self.measure {
            _ = PasswordGuesser.betterGuesses(range: 100000...111111)
        }
    }
}

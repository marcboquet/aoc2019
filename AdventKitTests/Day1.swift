import XCTest
@testable import AdventKit

class Day1: XCTestCase {

    let lines: [Int] = InputReader(name: "1-1-input").lines()

    func calculateFuel(mass: Int) -> Int {
        return mass / 3 - 2
    }
    
    func testSolutionPart1() {

        let sum = lines.reduce(0) { (res, val) -> Int in
            return res + calculateFuel(mass: val)
        }
        XCTAssertEqual(sum, 3376997)
    }
    
    // Part 2

    func calculateFuelFuel(mass: Int) -> Int {
        let massFuel = calculateFuel(mass: mass)
        if (massFuel > 0) {
            return massFuel + calculateFuelFuel(mass: massFuel)
        } else {
            return 0
        }
    }
    
    func testSolutionPart2() {
        let sumsum = lines.reduce(0) { (res, val) -> Int in
            return res + calculateFuelFuel(mass: val)
        }

        XCTAssertEqual(sumsum, 5062623)
    }

}

import XCTest
@testable import AdventKit

class Day11: XCTestCase {

    func testSolution1() {
        let program: [Int] = InputReader(name: "11-input").csvLine()
        var robot = PaintRobot(intcode: program)
        robot.run()
        XCTAssertEqual(robot.panels.count, 2172)
    }

    func testSolution2() {
        let program: [Int] = InputReader(name: "11-input").csvLine()
        var robot = PaintRobot(intcode: program)
        robot.run(initialPanel: 1)
        XCTAssertEqual(robot.hull, """

...##.####.#....####.####..##..#..#.###....
....#.#....#....#....#....#..#.#..#.#..#...
....#.###..#....###..###..#....####.#..#...
....#.#....#....#....#....#.##.#..#.###....
.#..#.#....#....#....#....#..#.#..#.#......
..##..####.####.####.#.....###.#..#.#......

""")
    }

}

import XCTest
@testable import AdventKit

class Day10: XCTestCase {

    func testExample1() {
        let input = """
            .#..#
            .....
            #####
            ....#
            ...##
            """
        let map = AsteroidMap(map: input)
        let best = map.bestAsteroid()
        XCTAssertEqual(best.asteroid.position, CGPoint(x: 3, y: 4))
    }

    func testExample2() {
        let input = """
            ......#.#.
            #..#.#....
            ..#######.
            .#.#.###..
            .#..#.....
            ..#....#.#
            #..#....#.
            .##.#..###
            ##...#..#.
            .#....####
            """
        let map = AsteroidMap(map: input)
        let best = map.bestAsteroid()
        XCTAssertEqual(best.asteroid.position, CGPoint(x: 5, y: 8))
        XCTAssertEqual(best.linesOfSight.count, 33)
    }

    func testExample3() {
        let input = """
            .#..##.###...#######
            ##.############..##.
            .#.######.########.#
            .###.#######.####.#.
            #####.##.#.##.###.##
            ..#####..#.#########
            ####################
            #.####....###.#.#.##
            ##.#################
            #####.##.###..####..
            ..######..##.#######
            ####.##.####...##..#
            .#####..#.######.###
            ##...#.##########...
            #.##########.#######
            .####.#.###.###.#.##
            ....##.##.###..#####
            .#.#.###########.###
            #.#.#.#####.####.###
            ###.##.####.##.#..##
            """
        let map = AsteroidMap(map: input)
        let best = map.bestAsteroid()
        XCTAssertEqual(best.asteroid.position, CGPoint(x: 11, y: 13))
        XCTAssertEqual(best.linesOfSight.count, 210)
    }

    func testSolutionPart1() {
        let input = """
            ###..#.##.####.##..###.#.#..
            #..#..###..#.......####.....
            #.###.#.##..###.##..#.###.#.
            ..#.##..##...#.#.###.##.####
            .#.##..####...####.###.##...
            ##...###.#.##.##..###..#..#.
            .##..###...#....###.....##.#
            #..##...#..#.##..####.....#.
            .#..#.######.#..#..####....#
            #.##.##......#..#..####.##..
            ##...#....#.#.##.#..#...##.#
            ##.####.###...#.##........##
            ......##.....#.###.##.#.#..#
            .###..#####.#..#...#...#.###
            ..##.###..##.#.##.#.##......
            ......##.#.#....#..##.#.####
            ...##..#.#.#.....##.###...##
            .#.#..#.#....##..##.#..#.#..
            ...#..###..##.####.#...#..##
            #.#......#.#..##..#...#.#..#
            ..#.##.#......#.##...#..#.##
            #.##..#....#...#.##..#..#..#
            #..#.#.#.##..#..#.#.#...##..
            .#...#.........#..#....#.#.#
            ..####.#..#..##.####.#.##.##
            .#.######......##..#.#.##.#.
            .#....####....###.#.#.#.####
            ....####...##.#.#...#..#.##.
            """
        let map = AsteroidMap(map: input)
        let best = map.bestAsteroid()
        XCTAssertEqual(best.asteroid.position, CGPoint(x: 22, y: 19))
        XCTAssertEqual(best.linesOfSight.count, 282)
    }

    func testLaserAngle() {
        var angles = [CGFloat]()
        angles.append(CGVector(dx: 0, dy: -1).laserAngle)
        angles.append(CGVector(dx: 1, dy: -1).laserAngle)
        angles.append(CGVector(dx: 1, dy: 0).laserAngle)
        angles.append(CGVector(dx: 1, dy: 1).laserAngle)
        angles.append(CGVector(dx: 0, dy: 1).laserAngle)
        angles.append(CGVector(dx: -1, dy: 1).laserAngle)
        angles.append(CGVector(dx: -1, dy: 0).laserAngle)
        angles.append(CGVector(dx: -1, dy: -1).laserAngle)
        angles.append(CGVector(dx: -0.01, dy: -1).laserAngle)
        XCTAssertEqual(angles.sorted(), angles)
    }

    func testExampleOrderedLOS() {
        let input = """
            .#....#####...#..
            ##...##.#####..##
            ##...#...#.#####.
            ..#.....X...###..
            ..#.#.....#....##
            """
        let map = AsteroidMap(map: input)
        let best = map.bestAsteroid()
        XCTAssertEqual(best.asteroid.position, CGPoint(x: 8, y: 3))
        XCTAssertEqual(best.linesOfSight.count, 30)
        let laser = GiantLaser(linesOfSight: best.linesOfSight)
        let ordered = laser.orderedLOS()
        let first = ordered.first!.value.first!
        let last = ordered.last!.value.first!
        XCTAssertEqual(first, CGVector(dx: 0, dy: -3))
        XCTAssertEqual(last, CGVector(dx: -1, dy: -3))
    }

    func testExampleFiringOrder() {
        let input = """
            .#....#####...#..
            ##...##.#####..##
            ##...#...#.#####.
            ..#.....X...###..
            ..#.#.....#....##
            """
        let map = AsteroidMap(map: input)
        let best = map.bestAsteroid()
        XCTAssertEqual(best.asteroid.position, CGPoint(x: 8, y: 3))
        XCTAssertEqual(best.linesOfSight.count, 30)
        let laser = GiantLaser(linesOfSight: best.linesOfSight)
        let ordered = laser.orderedShots()
        XCTAssert(ordered.count == 36)
        XCTAssertEqual(ordered.first, CGVector(dx: 0, dy: -3))
        XCTAssertEqual(ordered.last, CGVector(dx: 6, dy: 0))
    }

    func testExampleFiringOrder2() {
        let input = """
        .#..##.###...#######
        ##.############..##.
        .#.######.########.#
        .###.#######.####.#.
        #####.##.#.##.###.##
        ..#####..#.#########
        ####################
        #.####....###.#.#.##
        ##.#################
        #####.##.###..####..
        ..######..##.#######
        ####.##.####...##..#
        .#####..#.######.###
        ##...#.##########...
        #.##########.#######
        .####.#.###.###.#.##
        ....##.##.###..#####
        .#.#.###########.###
        #.#.#.#####.####.###
        ###.##.####.##.#..##
        """
        let map = AsteroidMap(map: input)
        let best = map.bestAsteroid()
        let laser = GiantLaser(linesOfSight: best.linesOfSight)
        let ordered = laser.orderedShots()
        XCTAssertEqual(CGPoint(x: best.asteroid.position.x + ordered[199].dx, y: best.asteroid.position.y + ordered[199].dy), CGPoint(x: 8, y: 2))
    }

    func testSolutionPart2() {
        let input = """
            ###..#.##.####.##..###.#.#..
            #..#..###..#.......####.....
            #.###.#.##..###.##..#.###.#.
            ..#.##..##...#.#.###.##.####
            .#.##..####...####.###.##...
            ##...###.#.##.##..###..#..#.
            .##..###...#....###.....##.#
            #..##...#..#.##..####.....#.
            .#..#.######.#..#..####....#
            #.##.##......#..#..####.##..
            ##...#....#.#.##.#..#...##.#
            ##.####.###...#.##........##
            ......##.....#.###.##.#.#..#
            .###..#####.#..#...#...#.###
            ..##.###..##.#.##.#.##......
            ......##.#.#....#..##.#.####
            ...##..#.#.#.....##.###...##
            .#.#..#.#....##..##.#..#.#..
            ...#..###..##.####.#...#..##
            #.#......#.#..##..#...#.#..#
            ..#.##.#......#.##...#..#.##
            #.##..#....#...#.##..#..#..#
            #..#.#.#.##..#..#.#.#...##..
            .#...#.........#..#....#.#.#
            ..####.#..#..##.####.#.##.##
            .#.######......##..#.#.##.#.
            .#....####....###.#.#.#.####
            ....####...##.#.#...#..#.##.
            """
        let map = AsteroidMap(map: input)
        let best = map.bestAsteroid()
        let laser = GiantLaser(linesOfSight: best.linesOfSight)
        let ordered = laser.orderedShots()
        XCTAssertEqual(CGPoint(x: best.asteroid.position.x + ordered[199].dx, y: best.asteroid.position.y + ordered[199].dy), CGPoint(x: 10, y: 8))
    }

}

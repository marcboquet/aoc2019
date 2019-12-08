import XCTest
@testable import AdventKit

class Day8: XCTestCase {
    
    func testExample1() {
        let data = "123456789012"
        let image = SpaceImage(data: data, w: 3, h: 2)
        XCTAssertEqual(image.layers.map { $0.data }, ["123456", "789012"])
    }
    
    func testOccurrences() {
        let data = "023456709012"
        let image = SpaceImage(data: data, w: 3, h: 2)
        XCTAssertEqual(image.layers.map { $0.occurrences(of: "0") }, [1,2])
        XCTAssertEqual(image.layers.map { $0.occurrences(of: "1") }, [0,1])
    }

    func testSolution1() {
        let data: String = InputReader(name: "8-1-input").content
        let image = SpaceImage(data: data, w: 25, h: 6)
        let fewerZeros = image.layers.min { (layerA, layerB) -> Bool in
            return layerA.occurrences(of: "0") < layerB.occurrences(of: "0")
        }!
        XCTAssertEqual(fewerZeros.occurrences(of: "1") * fewerZeros.occurrences(of: "2"), 2356)
    }
    
    func testExample2() {
        let data = "0222112222120000"
        let image = SpaceImage(data: data, w: 2, h: 2)
        XCTAssertEqual(image.render(), "0110")
    }
    
    func testSolution2() {
        let data: String = InputReader(name: "8-1-input").content
        let image = SpaceImage(data: data, w: 25, h: 6)
        XCTAssertEqual(image.render(), "111001111011110100101110010010000101000010100100101001000100111001100011100111000100010000101001001010000100001000010100100101000011110111101001011100")
//        1110011110111101001011100
//        1001000010100001010010010
//        1001000100111001100011100
//        1110001000100001010010010
//        1000010000100001010010010
//        1000011110111101001011100
    }
}

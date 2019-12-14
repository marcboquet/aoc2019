import Foundation

struct Arcade {
    let game: [Int]
    
    func run() -> [Int] {
        let computer = Computer(program: game)
        let output = try! computer.run()
        return output
    }
    
    func play() -> Int {
        var freeGame = game
        freeGame[0] = 2
        let computer = Computer(program: freeGame)
        var output = try! computer.run()
        var frame =  parseTiles(output)
        while frame.numberOfBlocks > 0 {
            let ballPosition = frame.ballPosition
            let paddlePosition = frame.paddlePosition
            let movement = ballPosition.x == paddlePosition.x ? 0 : ballPosition.x > paddlePosition.x ? 1 : -1
            output = try! computer.run(input: movement)
            frame = frame.parseUpdate(output)
        }
        return frame.score
    }
    
    func parseTiles(_ output: [Int]) -> Frame {
        var tiles = [Tile]()
        for tile in stride(from: 0, to: output.count, by: 3) {
            tiles.append(Tile(output[tile...(tile+2)]))
        }
        return Frame(tiles: tiles)
    }
    
    func numBlocks(_ output: [Int]) -> Int {
        var blocks = 0
        
        return blocks
    }
    
    struct Tile {
        enum Kind: Int {
            case score = -1
            case empty = 0
            case wall, block, paddle, ball
        }
        let kind: Kind
        let position: (x: Int, y: Int)
        let score: Int?
        
        init(_ tiles: ArraySlice<Int>) {
            let tiles = Array(tiles)
            if tiles[0] == -1 && tiles[1] == 0 {
                kind = .score
                score = tiles[2]
            } else {
                kind = Kind(rawValue: tiles[2])!
                score = nil
            }
            position = (x: tiles[0], y: tiles[1])
        }
    }
    
    struct Frame {
        let tiles: [Tile]
        
        var score: Int {
            tiles.first { $0.kind == .score }!.score!
        }
        
        var numberOfBlocks: Int {
            tiles.filter({ $0.kind == .block }).count
        }
        
        var ballPosition: (x: Int, y: Int) {
            tiles.first { $0.kind == .ball }!.position
        }
        
        var paddlePosition: (x: Int, y: Int) {
            tiles.first { $0.kind == .paddle }!.position
        }
        
        func parseUpdate(_ output: [Int]) -> Frame {
            var tiles = self.tiles
            for tile in stride(from: 0, to: output.count, by: 3) {
                let index = tiles.firstIndex(where: { $0.position == (x: output[tile], y: output[tile + 1]) })
                tiles[index!] = Tile(output[tile...(tile+2)])
            }
            return Frame(tiles: tiles)
        }
    }
}

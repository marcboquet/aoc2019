import Foundation

struct SpaceImage {
    let data: String
    let w: Int
    let h: Int
    
    var layers: [Layer] {
        get {
            let layers = stride(from: 0, to: data.count, by: w * h).map { (index) -> Layer in
                let startIndex = data.index(data.startIndex, offsetBy: index)
                let endIndex = data.index(startIndex, offsetBy: w * h)
                return Layer(data: String(data[startIndex..<endIndex]))
            }
            return layers
        }
    }
    
    func render() -> String {
        layers.reduce(Layer(data: String(repeating: "2", count: w * h ))) { (rendered, layer) -> Layer in
            rendered.render(layer: layer)
        }.data
    }
    
    struct Layer {
        let data: String
        
        func occurrences(of: Character) -> Int {
            data.reduce(0) { (numChars, char) -> Int in
                return numChars + (char == of ? 1 : 0)
            }
        }
        
        func render(layer: Layer) -> Layer {
            let rendered = zip(data, layer.data).map { (charA, charB) -> Character in
                charA == "2" ? charB : charA
            }
            return Layer(data: String(rendered))
        }
    }
}

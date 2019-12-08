import Foundation

public class InputReader {
    var name: String
    
    public init(name: String) {
        self.name = name
    }
    
    public var content: String {
        let path = Bundle(for: type(of: self)).path(forResource: "Resources/\(name)", ofType: "txt")
        let content: String = try! String(contentsOfFile: path!, encoding: .utf8)
        return content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    public func lines() -> [Int] {
        let lines: [Int] = content.lines.compactMap { (line) -> Int? in
            return Int(line)
        }
        return lines
    }
    
    public func lines() -> [String] {
        let lines: [String] = content.lines.compactMap { (line) -> String? in
            return line.isEmpty ? nil : line
        }
        return lines
    }
    
    public func csv() -> [[String]] {
        return content.lines.compactMap { (line) -> [String]? in
            let csvLine = line.components(separatedBy: ",").map { (item) -> String in
                item.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            }
            if csvLine.allSatisfy({ $0.isEmpty }) {
                return nil
            }
            return csvLine
        }
    }
    
    public func csvLine() -> [String] {
        let items: [String] = content.components(separatedBy: ",").map { (item) -> String in
            item.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        return items
    }
    
    public func csvLine() -> [Int] {
        let strings: [String] = self.csvLine()
        let items: [Int] = strings.compactMap { (item) -> Int? in
            return Int(item)
        }
        return items
    }
}

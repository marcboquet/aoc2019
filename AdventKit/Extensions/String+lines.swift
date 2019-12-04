import Foundation

public extension String {
    var lines: [String] {
        return self.components(separatedBy: "\n")
    }
}

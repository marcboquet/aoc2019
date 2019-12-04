import Foundation

public extension Int {
    var digits: [Int] {
        return String(self).utf8.map{Int($0) - 48}
    }
}

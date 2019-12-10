import Foundation

public extension CGVector {
    
    func length() -> CGFloat {
        return sqrt(dx*dx + dy*dy)
    }
    
    func normalized() -> CGVector {
        let len = length()
        return len > 0 ? self / len : CGVector.zero
    }
    
    static func / (vector: CGVector, scalar: CGFloat) -> CGVector {
        let dx = round((vector.dx / scalar) / 0.00001) * 0.00001
        let dy = round((vector.dy / scalar) / 0.00001) * 0.00001
        return CGVector(dx: dx, dy: dy)
    }
    
    var angle: CGFloat {
      return atan2(dy, dx)
    }

}

extension CGVector: Hashable {
    static func == (lhs: CGVector, rhs: CGVector) -> Bool {
        return lhs.dx == rhs.dx && lhs.dy == rhs.dy
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(dx)
        hasher.combine(dy)
    }
}

import Foundation

struct PaintRobot {
    let intcode: [Int]
    lazy var computer = Computer(program: self.intcode)
    var panels = [CGPoint : Int]()
    var currentPanel = CGPoint(x: 0, y: 0)
    var heading = CGPoint(x: 0, y: 1)
    
    mutating func run(initialPanel: Int = 0) {
        var output = try! computer.run(input: initialPanel)
        paint(instructions: output)
        while computer.waiting {
            let currentColor: Int = panels[currentPanel] ?? 0
            output = try! computer.run(input: currentColor)
            paint(instructions: output)
        }
    }
    
    mutating func paint(instructions: [Int]) {
        panels[currentPanel] = instructions.first!
        var turn = CGAffineTransform.init(rotationAngle: CGFloat.pi / 2)
        if instructions.last! == 1 {
            turn = CGAffineTransform.init(rotationAngle: -CGFloat.pi / 2)
        }
        heading = heading.applying(turn).rounded
        currentPanel = CGPoint(x: currentPanel.x + heading.x, y: currentPanel.y + heading.y)
    }
    
    var hull: String {
        var hull = "\n"
        var minPoint = CGPoint(x: 0, y: 0)
        var maxPoint = CGPoint(x: 0, y: 0)
        for panel in panels {
            minPoint.x = min(panel.key.x, minPoint.x)
            minPoint.y = min(panel.key.y, minPoint.y)
            maxPoint.x = max(panel.key.x, maxPoint.x)
            maxPoint.y = max(panel.key.y, maxPoint.y)
        }
        for y in (Int(minPoint.y)...Int(maxPoint.y)).reversed() {
            for x in Int(minPoint.x)...Int(maxPoint.x) {
                let panel = panels[CGPoint(x: x, y: y)] ?? 0
                hull += panel == 0 ? "." : "#"
            }
            hull += "\n"
        }
        return hull
    }
    
}

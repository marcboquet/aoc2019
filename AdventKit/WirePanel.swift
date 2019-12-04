//
//  WirePanel.swift
//  AdventKit
//
//  Created by Marc Boquet on 03/12/2019.
//  Copyright © 2019 Marc. All rights reserved.
//

import Foundation

public class WirePanel {
    var pathDefinitions: [[String]]
    lazy var pathPoints: [[CGPoint]] = computePathPoints()

    public init(paths: [[String]]) {
        self.pathDefinitions = paths
    }
    
    public func intersections() -> [CGPoint] {
        let first = pathPoints.first!
        let second = pathPoints.last!
        let intersections = Set(first).intersection(second)
        return Array(intersections)
    }
    
    public func manhattanDistance() -> Int {
        let sortedByDistance = intersections().sorted { (a, b) -> Bool in
            abs(a.x) + abs(a.y) < abs(b.x) + abs(b.y)
        }
        let first = sortedByDistance[1]
        return Int(abs(first.x) + abs(first.y))
    }
    
    public func shortestWireDistance() -> Int {
        let distances = intersections().map { (point) -> Int in
            let distance = pathPoints.first!.firstIndex(of: point)! + pathPoints.last!.firstIndex(of: point)!
            return distance
        }.sorted()
        return distances[1]
    }
    
    func computePathPoints() -> [[CGPoint]] {
        pathDefinitions.map { (path) -> [CGPoint] in
            var pathPoints = [CGPoint(x: 0, y: 0)]
            path.forEach { (instruction) in
                let segment = computeSegment(initialPoint: pathPoints.last!, instruction: instruction)
                pathPoints.append(contentsOf: segment)
            }
            return pathPoints
        }
    }
    
    func computeSegment(initialPoint: CGPoint, instruction: String) -> [CGPoint] {
        let movement = self.movement(instruction: instruction)
        let distance = self.distance(instruction: instruction)
        var segment = [CGPoint]()
        var lastPoint = initialPoint
        for _ in 0..<distance {
            lastPoint = lastPoint.applying(movement)
            segment.append(lastPoint)
        }
        return segment
    }
    
    func movement(instruction: String) -> CGAffineTransform {
        switch instruction[instruction.startIndex] {
        case "L":
            return CGAffineTransform(translationX: -1, y: 0)
        case "R":
            return CGAffineTransform(translationX: 1, y: 0)
        case "U":
            return CGAffineTransform(translationX: 0, y: 1)
        case "D":
            return CGAffineTransform(translationX: 0, y: -1)
        default:
            return CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    func distance(instruction: String) -> Int {
        return Int(String(instruction[instruction.index(after: instruction.startIndex)...]))!
    }
}

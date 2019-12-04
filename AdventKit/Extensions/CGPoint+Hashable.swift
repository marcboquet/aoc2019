//
//  CGPoint+Hashable.swift
//  AdventKit
//
//  Created by Marc Boquet on 03/12/2019.
//  Copyright © 2019 Marc. All rights reserved.
//

import Foundation

extension CGPoint: Hashable {
    static func == (lhs: CGPoint, rhs: CGPoint) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

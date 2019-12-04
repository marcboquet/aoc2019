//
//  Computer.swift
//  AdventKit
//
//  Created by Marc Boquet on 03/12/2019.
//  Copyright © 2019 Marc. All rights reserved.
//

import Foundation

public struct Computer {
    struct OpcodeError: Error {}

    static func run(inputItems: [Int]) -> [Int] {
        var items = inputItems
        var i = 0
        while true {
            let item = items[i]
            switch item {
            case 99:
                break
            case 1:
                items[items[i+3]] = items[items[i+1]] + items[items[i+2]]
            case 2:
                items[items[i+3]] = items[items[i+1]] * items[items[i+2]]
            default:
                break
            }
            if item == 99 {
                break
            }
            i += 4
        }
        return items
    }
}

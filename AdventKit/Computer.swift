//
//  Computer.swift
//  AdventKit
//
//  Created by Marc Boquet on 03/12/2019.
//  Copyright © 2019 Marc. All rights reserved.
//

import Foundation

public class Computer {
    var memory: [Int]
    var instructionPointer: Int

    init(program: [Int]) {
        self.memory = program
        self.instructionPointer = 0
    }
    
    public func run(input: Int = 0) throws -> [Int] {
        var outputs = [Int]()
        
        runloop: while true {
            var operation = Operation(instructionPointer: instructionPointer, memoryPointer: &memory)
            switch operation.opcode {
            case .halt:
                break runloop
            default:
                if let output = try operation.execute(input: input) {
                    outputs.append(output)
                }
            }
            instructionPointer = operation.instructionPointer
        }
        return outputs
    }

    static func run(inputItems: [Int]) throws -> [Int] {
        let computer = Computer(program: inputItems)
        _ = try computer.run()
        return computer.memory
    }
}

enum ProgramError: Error {
    case invalidOpcode(message: String)
}

enum Opcode: Int {
    case unknown = 0
    case add, multiply, input, output
    case jumpIfTrue, jumpIfFalse, lessThan, equals
    case halt = 99
}

struct Operation {
    var instructionPointer: Int
    let memoryPointer: UnsafeMutablePointer<Int>
    let opcode: Opcode
    
    var parameterModes: [Int] {
        let intCode = memoryPointer.advanced(by: instructionPointer).pointee
        return [
            intCode / 100 % 10,
            intCode / 1000 % 10,
            intCode / 10000 % 10,
        ]
    }
    
    var parameter1: UnsafeMutablePointer<Int> {
        let value = memoryPointer.advanced(by: instructionPointer + 1)
        if parameterModes[0] == 1 {
            return value
        } else {
            return memoryPointer.advanced(by: value.pointee)
        }
    }
    
    var parameter2:  UnsafeMutablePointer<Int> {
        let value = memoryPointer.advanced(by: instructionPointer + 2)
        if parameterModes[1] == 1 {
            return value
        } else {
            return memoryPointer.advanced(by: value.pointee)
        }
    }
    
    var parameter3:  UnsafeMutablePointer<Int> {
        let value = memoryPointer.advanced(by: instructionPointer + 3)
        if parameterModes[2] == 1 {
            return value
        } else {
            return memoryPointer.advanced(by: value.pointee)
        }
    }
    
    var size: Int {
        switch opcode {
        case .input, .output:
            return 2
        case .jumpIfTrue, .jumpIfFalse:
            return 3
        default:
            return 4
        }
    }
    
    init(instructionPointer: Int, memoryPointer: UnsafeMutablePointer<Int>) {
        self.instructionPointer = instructionPointer
        self.memoryPointer = memoryPointer
        self.opcode = Opcode(rawValue: memoryPointer.advanced(by: instructionPointer).pointee % 100) ?? Opcode.unknown
    }
    
    mutating func execute(input: Int? = nil) throws -> Int? {
        var output: Int?
        var newInstructionPointer: Int?

        switch opcode {
        case .add:
            let storage = parameter3
            storage.pointee = parameter1.pointee + parameter2.pointee
        
        case .multiply:
            let storage = parameter3
            storage.pointee = parameter1.pointee * parameter2.pointee
                
        case .lessThan:
            let storage = parameter3
            storage.pointee = parameter1.pointee < parameter2.pointee ? 1 : 0
            
        case .jumpIfTrue:
            if parameter1.pointee != 0 {
                newInstructionPointer = parameter2.pointee
            }
            
        case .jumpIfFalse:
            if parameter1.pointee == 0 {
                newInstructionPointer = parameter2.pointee
            }
            
        case .equals:
            let storage = parameter3
            storage.pointee = parameter1.pointee == parameter2.pointee ? 1 : 0
        
        case .input:
            let storage = parameter1
            storage.pointee = input!
            
        case .output:
            output = parameter1.pointee
            
        default:
            throw ProgramError.invalidOpcode(message: "Invalid opcode at \(instructionPointer)")
        }
        instructionPointer = newInstructionPointer ?? instructionPointer + size
        return output
    }
}

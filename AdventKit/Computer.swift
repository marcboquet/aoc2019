import Foundation

public class Computer {
    var memory: [Int]
    var instructionPointer: Int = 0
    var waiting = false

    init(program: [Int]) {
        self.memory = program
    }
    
    public func run(input: [Int] = []) throws -> [Int] {
        self.instructionPointer = 0
        var outputs = [Int]()
        let inputs = Input(inputs: input)
        waiting = false

        runloop: while true {
            var operation = Operation(instructionPointerPointer: &instructionPointer, memoryPointer: &memory, input: inputs)
            switch operation.opcode {
            case .halt:
                break runloop
            default:
                if let output = try operation.execute() {
                    outputs.append(output)
                }
                if operation.waiting {
                    waiting = true
                    break runloop
                }
            }
        }
        return outputs
    }
    
    public func run(input: Int) throws -> [Int] {
        return try run(input: [input])
    }
    
    public func run() throws -> [Int] {
        return try run(input: [])
    }

    static func run(inputItems: [Int]) throws -> [Int] {
        let computer = Computer(program: inputItems)
        _ = try computer.run()
        return computer.memory
    }
}

class Input {
    var inputs = [Int]()
    
    init(inputs: [Int]) {
        self.inputs = inputs.reversed()
    }
    
    func next() -> Int? {
        return inputs.popLast()
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
    var instructionPointerPointer: UnsafeMutablePointer<Int>
    var instructionPointer: Int
    let memoryPointer: UnsafeMutablePointer<Int>
    var input: Input
    let opcode: Opcode
    var waiting = false
    
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
    
    init(instructionPointerPointer: UnsafeMutablePointer<Int>, memoryPointer: UnsafeMutablePointer<Int>, input: Input) {
        self.instructionPointerPointer = instructionPointerPointer
        self.input = input
        self.instructionPointer = instructionPointerPointer.pointee
        self.memoryPointer = memoryPointer
        self.opcode = Opcode(rawValue: memoryPointer.advanced(by: instructionPointer).pointee % 100) ?? Opcode.unknown
    }
    
    mutating func execute() throws -> Int? {
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
            if let inputValue = input.next() {
                storage.pointee = inputValue
            } else {
                waiting = true
            }
            
        case .output:
            output = parameter1.pointee
            
        default:
            throw ProgramError.invalidOpcode(message: "Invalid opcode at \(instructionPointer)")
        }
        instructionPointerPointer.pointee = newInstructionPointer ?? instructionPointer + size
        return output
    }
}

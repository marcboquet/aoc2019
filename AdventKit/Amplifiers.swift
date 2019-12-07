import Foundation

struct Amplifiers {
    let program: [Int]
    
    init(program: [Int]) {
        self.program = program
    }
    
    func run(sequence: [Int]) -> Int {
        let computers = (0...4).map { (_) -> Computer in
            Computer(program: program)
        }
        var signal = 0
        var output = [Int]()
        for i in 0...4 {
            let computer = computers[i]
            output = try! computer.run(input: [sequence[i], signal])
            signal = output.last!
        }
        return signal
    }
    
    func runFeedback(sequence: [Int]) -> Int {
        let computers = (0...4).map { (_) -> Computer in
            Computer(program: program)
        }
        var lastOutput: Int? = 0
        var inputs: [[Int]] = [[0],[],[],[],[]]
        var i = 0
        while true {
            let computer = computers[i]
            print("computer \(i)")
            var input: [Int] = [sequence[i]]
            input.append(contentsOf: inputs[i])
            let output = try! computer.run(input: input)
            inputs[(i+1)%5] = output
            if i == 4 && !computer.waiting {
                lastOutput = output.last
                break
            }
            i = (i + 1) % 5
        }
        return lastOutput!
    }
    
    func findMaxThruster() -> Int {
        var maxSignal = 0
        let possibleInputs = generatePossibleInputs(values: [0,1,2,3,4])
        possibleInputs.forEach { (input) in
            print("input \(input)")
            let signal = run(sequence: input)
            maxSignal = max(signal, maxSignal)
        }
        return maxSignal
    }
    
    func findMaxFeedback() -> Int {
        var maxSignal = 0
        let possibleInputs = generatePossibleInputs(values: [5,6,7,8,9])
        possibleInputs.forEach { (input) in
            print("input \(input)")
            let signal = runFeedback(sequence: input)
            maxSignal = max(signal, maxSignal)
        }
        return maxSignal
    }
    
    func generatePossibleInputs(values: [Int]) -> [[Int]] {
        var permutations = [[Int]]()
        var input = values
        generatePermutations(values: &input, output: &permutations, k: input.count)
        return permutations
    }
    
    func generatePermutations(values: inout [Int], output: inout [[Int]], k: Int) {
        if k == 1 {
            output.append(values)
        } else {
            for i in 0 ..< k {
                generatePermutations(values: &values, output: &output, k: k - 1)
                if k % 2 == 0 {
                    values.swapAt(i, k - 1)
                } else {
                    values.swapAt(0, k - 1)
                }
            }
        }
    }
}

import Foundation

public struct PasswordGuesser {
    let digits: [Int]
    
    static public func guesses(range: ClosedRange<Int>) -> [Int] {
        return range.filter { PasswordGuesser(password: $0).isValid() }
    }
    
    static public func betterGuesses(range: ClosedRange<Int>) -> [Int] {
        return range.filter { PasswordGuesser(password: $0).isBetter() }
    }
    
    init(password: Int) {
        self.digits = password.digits
    }
    
    func isValid() -> Bool {
        return hasNoDecreasingDigits() && hasAdjacentDigits()
    }
    
    func hasNoDecreasingDigits() -> Bool {
        var lastDigit = digits[0]
        for digit in digits[1...] {
            if digit < lastDigit {
                return false
            }
            lastDigit = digit
        }
        return true
    }
    
    func hasAdjacentDigits() -> Bool {
        var lastDigit = digits[0]
        for digit in digits[1...] {
            if digit == lastDigit {
                return true
            }
            lastDigit = digit
        }
        return false
    }
    
    // Part 2
    
    func isBetter() -> Bool {
        return isValid() && hasTwoAdjacentDigits()
    }
    
    func hasTwoAdjacentDigits() -> Bool {
        var currentGroup = (digit: digits[0], reps: 1)
        for digit in digits[1...] {
            if digit == currentGroup.digit {
                currentGroup.reps += 1
            } else if currentGroup.reps == 2 {
                return true
            } else {
                currentGroup = (digit: digit, reps: 1)
            }
        }
        return currentGroup.reps == 2
    }
}

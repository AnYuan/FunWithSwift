import Foundation

//Arrays
example(of: "arrays") {
    let fibs = [0,1,1,2,3,5]
    
    var mutableFibs = [0,1,1,2,3,5]
    
    mutableFibs.append(8)
    mutableFibs.append(contentsOf:[13,21])
    mutableFibs
}



//value semantics
example(of: "value semantics") {
    let x = [1,2,3]
    var y = x
    y.append(4)
    print(y)
    print(x)
}


//transforming arrays
//map
example(of: "map") {
    let fibs = [0,1,1,2,3,5]
    let squares = fibs.map { fib in fib * fib }
    squares
}



//accumulate
extension Array {
    func accumulate<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return map { next in
            running = nextPartialResult(running, next)
            return running
        }
    }
}

example(of: "accumulate") {
    print([1,2,3,4].accumulate(0, +))
}


//filter
//performance tip: if you ever find yourself writing something like the following, stop!
// bigArray.filter { someCondition }.count > 0
// you should:
// bigArray.contains { someCondition }
example(of: "filter") {
    let nums = [1,2,3,4,5,6,7,8,9,10]
    nums.filter { $0 % 2 == 0 }
}


//reduce
example(of: "reduce") {
    let fibs = [0,1,1,2,3,5]
    let sum = fibs.reduce(0) {
        total, num in total + num
    }
    print(sum)
    print(fibs.reduce(0, +))
    print(fibs.reduce("", {str, num in str + "\(num), "}))
}

//flatmap
example(of: "flatmap") {
    let suits = ["♠︎", "♣︎", "♥︎", "♦︎"]
    let ranks = ["J","Q","K","A"]
    let result = suits.flatMap {
        suit in
        ranks.map {
            rank in
            (suit, rank)
        }
    }
    print(result)
}

//iteration using forEach
example(of: "forEach") {
    [1,2,3].forEach { element in
        print(element)
    }
    
    //forEach not return
    (1..<10).forEach {
        number in
        print(number)
        if number > 2 { return }
    }
}

//Array Types
//Slices
example(of: "slices") {
    let fibs = [0,1,1,2,3,5]
    let slice = fibs[1...]
    type(of: slice)
    let newArray = Array(slice)
    type(of: newArray)
}


//Dictionary
enum Setting {
    case text(String)
    case int(Int)
    case bool(Bool)
}

example(of: "uniquingKeysWith") {
    
    let defaultSettings: [String: Setting] = [
        "Airplane Mode" : .bool(false),
        "Name": .text("My iPhone")
    ]
    
    var settings = defaultSettings
    let overriddenSettings: [String: Setting] = ["Name": .text("Jane's iPhone")]
    settings.merge(overriddenSettings, uniquingKeysWith: {$1})
    print(settings)
    
    let settingsAsStrings = settings.mapValues {
        setting -> String in
        switch setting {
        case .text(let text):
            return text
        case .int(let number):
            return String(number)
        case .bool(let value):
            return String(value)
        }
    }
    print(settingsAsStrings)
}


extension Sequence where Element: Hashable {
    var frequencies:[Element: Int] {
        let frequencyPairs = self.map { ($0, 1)}
        return Dictionary(frequencyPairs, uniquingKeysWith:+)
    }
}
example(of: "frequencies") {
    let frequencies = "hello".frequencies
    print(frequencies.filter {$0.value > 1})
}

example(of: "map values") {
}


//set
example(of: "set") {
    let naturals:Set = [1,2,3,2]
    naturals
    naturals.contains(3)
    naturals.contains(0)
}

//set
example(of: "set algebra") {
    let iPods:Set = ["iPod touch", "iPod nano", "iPod mini", "iPod shuffle", "iPod Classic"]
    let discontinuedIPods:Set = ["iPod mini", "iPod Classic", "iPod nano", "iPod shuffle"]
    let currentIpods = iPods.subtracting(discontinuedIPods)
    print(currentIpods)
    
    let touchscreen:Set = ["iPhone", "iPad", "iPod touch", "iPod nano"]
    let iPodsWithTouch = iPods.intersection(touchscreen)
    print(iPodsWithTouch)
    
    var discountinued:Set = ["iBook", "PowerBook", "Power Mac"]
    discountinued.formUnion(discontinuedIPods)
    print(discountinued)
}

example(of: "index set") {
    var indices = IndexSet()
    indices.insert(integersIn: 1..<5)
    indices.insert(integersIn: 11..<15)
    print(indices)
    let evenIndices = indices.filter {$0 % 2 == 0}
    print(evenIndices)
}

extension Sequence where Element:Hashable {
    func unique() -> [Element] {
        var seen: Set<Element> = []
        return filter {
            element in
            if seen.contains(element) {
                return false
            } else {
                seen.insert(element)
                return true
            }
        }
    }
}

example(of: "Using Sets Inside Closures") {
    print([1,2,3,12,1,3,4,5,6,4,6].unique())
}


/*
 Half-open and closed ranges both have a place:
 * Only a half-open range can represent an empty interval(when the lower and upper bounds are equal, as in 5..<5)
 * Only a closed range can contain the maximum value its element type can represent (e.g. 0...Int.max). A half-open range always requires at least one representable value that's greater than the highest value in the range.
 */
example(of: "Ranges") {
    let singleDigitNumbers = 0..<10
    type(of: singleDigitNumbers)
    Array(singleDigitNumbers)
    let lowercaseLetters = Character("a")...Character("z")
    let fromZero = 0...
    let upToZ = ..<Character("z")
    print(singleDigitNumbers.contains(9))
    print(lowercaseLetters.overlaps("c"..<"f"))
}

example(of: "partial ranges") {
    let fromA: PartialRangeFrom<Character> = Character("a")...
    let throughZ:PartialRangeThrough<Character> = ...Character("z")
    let upto10:PartialRangeUpTo<Int> = ..<10
    let fromFive:CountablePartialRangeFrom<Int> = 5...
}

example(of: "range expressions") {
    let arr = [1,2,3,4]
    print(arr[2...])
    print(arr[..<1])
    print(arr[1...2])
    print(arr[...])
    print(type(of: arr))
}

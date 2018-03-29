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
    [1,2,3,4].accumulate(0, +)
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





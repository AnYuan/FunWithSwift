//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//:Array
var someInts = [Int]()
print(someInts.count)

someInts.append(3)

var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
var anotherThreeDoubles = [Double](count: 3, repeatedValue: 2.5)

var sixDoubles = threeDoubles + anotherThreeDoubles

var shoppingList:[String] = ["Egg", "Milk"]

if shoppingList.isEmpty {
    print("is empty")
} else {
    print("not empty")
}

shoppingList.append("Flour")
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
var firstItem = shoppingList.first
shoppingList[4...6] = ["Bananas", "Apples"]
shoppingList.insert("Maple Syrup", atIndex: 0)
let mapleSyrup = shoppingList.removeAtIndex(0)
for item in shoppingList {
    print(item)
}

for (index, value) in shoppingList.enumerate() {
    print("Item \(index + 1): \(value)")
}

//:Transforming Arrays

//:map

let fibs = [0, 1, 1, 2, 3, 5]

var squared: [Int] = []
for fib in fibs {
    squared.append(fib * fib)
}

squared

let squared_ = fibs.map{$0 * $0}
squared


extension Array {
    func map<U>(transform: Element->U) -> [U] {
        var result: [U] = []
        result.reserveCapacity(self.count)
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}

extension Array {
    func flatMap<U>(transform: Element->[U]) -> [U] {
        var result: [U] = []
        for x in self {
            result.appendContentsOf(transform(x))
        }
        return result
    }
}

let suits = ["♠︎", "♥︎", "♣︎", "♦︎"]
let ranks = ["J","Q","K","A"]

let allCombinations = suits.flatMap { suit in
    ranks.map { rank in
        (suit, rank)
    }
}

allCombinations


fibs.indexOf(2)

//:filter
let a = fibs.filter{$0 % 2 == 0}
a

extension Array {
    func filter(includeElement: Element -> Bool) -> [Element] {
        var result: [Element] = []
        for x in self where includeElement(x) {
            result.append(x)
        }
        return result
    }
}

//:reduce
var total = 0
for num in fibs {
    total = total + num
}

fibs.reduce(0){ total, num in total + num}
fibs.reduce(0, combine: +)
let fibs_str = fibs.reduce(""){str, num in str + "\(num)\n"}
fibs_str

extension Array {
    func reduce<U>(initial: U, combine: (U,Element)->U) -> U {
        var result = initial
        for x in self {
            result = combine(result,x)
        }
        return result
    }
}


//:Dic
var namesOfIntegers = [Int: String]()
namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:]

var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB":"Dublin"]

airports.count

airports["LHR"] = "London"
airports["LHR"] = "London Hearthrow"

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("\(oldValue)")
}

if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}


airports["APL"] = "Apple International"
airports["APL"] = nil
airports

for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}


//Useful extension for Dictionary
//merge two dics
extension Dictionary {
    mutating func merge<S: SequenceType
        where S.Generator.Element == (Key,Value)>(other: S) {
            for (k,v) in other {
                self[k] = v
            }
    }
}

//init with (key,value)
extension Dictionary {
    init<S: SequenceType
        where S.Generator.Element == (Key,Value)>(_ sequence: S) {
            self = [:]
            self.merge(sequence)
    }
}

//map value
extension Dictionary {
    func mapValues<NewValue>(transform: Value -> NewValue)
        -> [Key:NewValue] {
            return Dictionary<Key, NewValue>(map { (key,value) in
                return (key, transform(value))
                })
    }
}


//Set
var letters = Set<Character>()
print(letters.count)
letters.insert("a")
letters = []

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hiphop"]
favoriteGenres.insert("Jazz")

favoriteGenres.remove("Rock")

favoriteGenres.contains("Jazz")
favoriteGenres.sort()
favoriteGenres


//Performing Set Operations
let oddDigits: Set = [1,3,5,7,9]
let evenDigits: Set = [0,2,4,6,8]
let singleDigitPrimeNumbers: Set = [2,3,5,7]

oddDigits.union(evenDigits).sort()

oddDigits.intersect(evenDigits).sort()
oddDigits.subtract(singleDigitPrimeNumbers).sort()
oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()



//:Designing a protocol for queues
protocol QueueType {
    //The type of elements held in 'self'
    typealias Element
    
    //enqueue 'newElement' to 'self'
    mutating func enqueue(newElement: Element)
    
    //dequeue an element from 'self'
    mutating func dequeue() -> Element?
}

struct Queue<Element> {
    private var left: [Element]
    private var right: [Element]
    
    init() {
        left = []; right = []
    }
    
    /// Add an element to the back of the queue in O(1).
    mutating func enqueue(element: Element) {
        right.append(element)
    }
    
    /// Removes front of the queue in amortized O(1).
    /// Returns nil in case of an empty queue.
    mutating func dequeue() -> Element? {
        guard !(left.isEmpty && right.isEmpty)
            else { return nil }
        
        if left.isEmpty {
            left = right.reverse()
            right.removeAll(keepCapacity: true)
        }
        return left.removeLast()
    }
}

extension Queue: CollectionType {
    var startIndex: Int { return 0 }
    var endIndex: Int { return left.count + right.count }
    
    subscript(idx: Int) -> Element {
        guard idx < endIndex else { fatalError("Index out of bounds") }
        if idx < left.endIndex {
            return left[left.count - idx.successor()]
        } else {
            return right[idx - left.count]
        }
    }
}


var q = Queue<String>()
for x in ["1","2","foo","3"] {
    q.enqueue(x)
}

// you can now for...in over queues
for s in q { print(s) }     // prints 1 2 foo 3

// pass queues to methods that take sequences
q.joinWithSeparator(",")    // "1,2,foo,3"
let aa = Array(q)            // aa = ["1","2","foo","3]

// call methods that extend SequenceType
q.map { $0.uppercaseString} // ["1","2","FOO","3"]
q.flatMap { Int($0) }       // [1,2,3]
q.filter {                  // ["foo"]
    $0.characters.count > 1
}

// and CollectionType
q.isEmpty                   // false
q.count                     // 4
q.first                     // "1"
q.last                      // "3"



extension Queue: ArrayLiteralConvertible {
    init(arrayLiteral elements: Element...) {
        self.left = elements.reverse()
        self.right = []
    }
}

let qq: Queue = [1,2,3]

extension Queue: RangeReplaceableCollectionType {
    mutating func reserveCapacity(n: Int) {
        return
    }
    
    mutating func replaceRange<C : CollectionType where C.Generator.Element == Element>
        (subRange: Range<Int>, with newElements: C) {
            right = left.reverse() + right
            left.removeAll(keepCapacity: true)
            right.replaceRange(subRange, with: newElements)
    }
}

/// A simple linked list enum
enum List<Element> {
    /// The end of a list
    case End
    indirect case Node(Element, next: List<Element>)
}

extension List {
    /// Return a new list by prepending a node
    /// with value `x` to the front of a list.
    func cons(x: Element) -> List {
        return .Node(x, next: self)
    }
}

// a 3-element list, of (3 2 1)
let l = List<Int>.End.cons(1).cons(2).cons(3)

/// A LIFO stack type with constant-time push and pop operations
protocol StackType {
    /// The type of element held stored in the stack
    typealias Element
    
    /// Pushes `x` onto the top of `self`
    ///
    /// - Complexity: Amortized O(1).
    mutating func push(x: Element)
    /// Removes the topmost element of `self` and returns it,
    /// or `nil` if `self` is empty.
    ///
    /// - Complexity: O(1)
    mutating func pop() -> Element?
}

extension Array: StackType {
    mutating func push(x: Element) {
        self.append(x)
    }
    
    mutating func pop() -> Element? {
        guard !isEmpty else { return nil }
        return removeLast()
    }
}

extension List: StackType {
    mutating func push(x: Element) {
        self = self.cons(x)
    }
    
    mutating func pop() -> Element? {
        switch self {
        case .End: return nil
        case let .Node(x, next: xs):
            self = xs
            return x
        }
    }
}


var stack = List<Int>.End.cons(1).cons(2).cons(3)
var aaa = stack
var bbb = stack

aaa.pop() // 3
aaa.pop() // 2
aaa.pop() // 1

stack.pop() // 3
stack.push(4)

bbb.pop() // 3
bbb.pop() // 2
bbb.pop() // 1

stack.pop() // 4
stack.pop() // 2
stack.pop() // 1

extension List: SequenceType {
    func generate() -> AnyGenerator<Element> {
        // declare a variable to capture that
        // tracks progression through the list:
        var current = self
        return anyGenerator {
            // next() will pop, returning nil
            // when the list is empty:
            current.pop()
        }
    }
}

extension List: ArrayLiteralConvertible {
    init(arrayLiteral elements: Element...) {
        self = elements.reverse().reduce(.End) {
            $0.cons($1)
        }
    }
}

let ll: List = ["1","2","3"]
for x in ll {
    print("\(x) ", terminator: "")
}

ll.joinWithSeparator(",")        // "1,2,3"
ll.contains("2")                 // true
ll.flatMap { Int($0) }           // [1,2,3]
ll.elementsEqual(["1","2","3"])  // true


let standardIn = AnySequence {
    return anyGenerator {
        readLine()
    }
}

let numberedStdIn = standardIn.enumerate()
for (i, line) in numberedStdIn {
    print("\(i+1): \(line)")
}

extension SequenceType {
    func enumerate() -> AnySequence<(Int,Generator.Element)> {
        
        // Swift currently needs a type-inference helping hand with this closure:
        return AnySequence { _ -> AnyGenerator<(Int,Generator.Element)> in
            
            // create a fresh counter and generator to begin enumeration
            var i = 0
            var g = self.generate()
            // capture these in a closure and return that in a new generator
            return anyGenerator {
                // when the base sequence is exhausted, return nil
                guard let next = g.next()
                    else { return nil }
                
                return (i++, next)
            }
        }
    }
}


/// Private implementation detail of the List collection
private enum ListNode<Element> {
    case End
    indirect case Node(Element, tag: Int, next: ListNode<Element>)
    
    /// Computed property to fetch the tag. .End has an
    /// implicit tag of zero.
    var tag: Int {
        switch self {
        case .End: return 0
        case let .Node(_, tag: n, _):
            return n
        }
    }
    
    func cons(x: Element) -> ListNode<Element> {
        // each cons increments the tag by one
        return .Node(x, tag: tag+1, next: self)
    }
}

public struct ListIndex<Element> {
    private let node: ListNode<Element>
}




assert(sizeof(ListNode<Int>) == sizeof(ListIndex<Int>))

extension ListIndex: ForwardIndexType {
    public func successor() -> ListIndex<Element> {
        switch node {
        case .End:
            fatalError("cannot increment endIndex")
        case let .Node(_, _, next: next):
            return ListIndex(node: next)
        }
    }
}

public func == <T>(lhs: ListIndex<T>, rhs: ListIndex<T>) -> Bool {
    return lhs.node.tag == rhs.node.tag
}


public struct List_n<Element>: CollectionType {
    // Index's type could be inferred, but it helps make the
    // rest of the code clearer:
    public typealias Index = ListIndex<Element>
    
    public var startIndex: Index
    public var endIndex: Index
    
    public subscript(idx: Index) -> Element {
        switch idx.node {
        case .End: fatalError("Subscript out of range")
        case let .Node(x, _, _): return x
        }
    }
}


extension List_n: ArrayLiteralConvertible {
    public init(arrayLiteral elements: Element...) {
        startIndex = ListIndex(node: elements.reverse().reduce(.End) {
            $0.cons($1)
            })
        endIndex = ListIndex(node: .End)
    }
}

let lll: List_n = ["one", "two", "three"]
lll.first
lll.indexOf("two")

extension List_n {
    public var count: Int {
        return startIndex.node.tag - endIndex.node.tag
    }
}

public func == <T: Equatable>(lhs: List_n<T>, rhs: List_n<T>) -> Bool {
    return lhs.elementsEqual(rhs)
}




























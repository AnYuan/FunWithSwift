//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//:Array
var someInts = [Int]()
print(someInts.count)

someInts.append(3)

var threeDoubles = [Double](repeating: 0.0, count: 3)
var anotherThreeDoubles = [Double](repeating: 2.5, count: 3)

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
shoppingList.insert("Maple Syrup", at: 0)
let mapleSyrup = shoppingList.remove(at: 0)
for item in shoppingList {
    print(item)
}

for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}

//:Transforming Arrays

//:map

let fibs = [0, 1, 1, 2, 3, 5]

var squared: [Int] = []
for fib in fibs {
    squared.append(fib * fib)
}

let s_fibs = fibs.map {$0 * $0}
s_fibs

extension Array {
    func accumulate<U>(_ initial: U, combine:(U,Element) -> U) -> [U] {
        var running = initial
        return self.map {
            next in
            running = combine(running, next)
            return running
        }
    }
}
[1,2,3,4].accumulate(0, combine: +)



squared

let squared_ = fibs.map{$0 * $0}
squared


//extension Array {
//    func map<U>(transform: Element->U) -> [U] {
//        var result: [U] = []
//        result.reserveCapacity(self.count)
//        for x in self {
//            result.append(transform(x))
//        }
//        return result
//    }
//}

//extension Array {
//    func map2<U>(transform: Element -> U) -> [U] {
//        return reduce([]) {
//            $0 + [transform($1)]
//        }
//    }
//}
//let sqr = [1,2,3].map2{$0 * $0}
//sqr
//
//extension Array {
//    func flatMap<U>(transform: Element->[U]) -> [U] {
//        var result: [U] = []
//        for x in self {
//            result.appendContentsOf(transform(x))
//        }
//        return result
//    }
//}

let suits = ["♠︎", "♥︎", "♣︎", "♦︎"]
let ranks = ["J","Q","K","A"]

let allCombinations = suits.flatMap { suit in
    ranks.map { rank in
        (suit, rank)
    }
}

(1..<10).forEach {number in
    print(number)
    if number > 2 {return}
}

allCombinations


fibs.index(of: 2)

//:filter
let a = fibs.filter{$0 % 2 == 0}
a

//extension Array {
//    func filter(includeElement: Element -> Bool) -> [Element] {
//        var result: [Element] = []
//        for x in self where includeElement(x) {
//            result.append(x)
//        }
//        return result
//    }
//}

//:reduce
var total = 0
for num in fibs {
    total = total + num
}

fibs.reduce(0){ total, num in total + num}
fibs.reduce(0, +)
let fibs_str = fibs.reduce(""){str, num in str + "\(num)\n"}
fibs_str

//extension Array {
//    func reduce<U>(initial: U, combine: (U,Element)->U) -> U {
//        var result = initial
//        for x in self {
//            result = combine(result,x)
//        }
//        return result
//    }
//}


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
airports
airports["APL"] = nil
airports

for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}


//Useful extension for Dictionary
//merge two dics
extension Dictionary {
    mutating func merge<S: Sequence
        where S.Iterator.Element == (Key,Value)>(_ other: S) {
            for (k,v) in other {
                self[k] = v
            }
    }
}

//init with (key,value)
extension Dictionary {
    init<S: Sequence
        where S.Iterator.Element == (Key,Value)>(_ sequence: S) {
            self = [:]
            self.merge(sequence)
    }
}

let defaultAlarms = (1..<5).map {("Alarm \($0)", false)}
let alarmsDictionary = Dictionary(defaultAlarms)
alarmsDictionary

//map value
extension Dictionary {
    func mapValues<NewValue>(_ transform: (Value) -> NewValue)
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
favoriteGenres.sorted()
favoriteGenres


//Performing Set Operations
let oddDigits: Set = [1,3,5,7,9]
let evenDigits: Set = [0,2,4,6,8]
let singleDigitPrimeNumbers: Set = [2,3,5,7]

oddDigits.union(evenDigits).sorted()

oddDigits.intersection(evenDigits).sorted()
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter {
            if seen.contains($0) {
                return false
            } else {
                seen.insert($0)
                return true
            }
        }
    }
}


var mySet = Set<String>()
mySet

mySet.insert("a")
mySet.insert("b")
mySet.insert("a")
mySet.insert("d")
mySet.insert("b")

mySet.insert("c")
mySet.unique()

let uniqueArray = [1,2,3,4,2,3,6,3].unique()

//:Collection Protocols

//Generator
struct FibsGenerator: IteratorProtocol {
    var state = (0,1)
    mutating func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

var fibG = FibsGenerator()
fibG.next()
fibG.next()
fibG.next()
fibG.next()
fibG.next()


let seq = stride(from: 0, to: 9, by: 1)
var g1 = seq.makeIterator()
g1.next()
g1.next()

var g2 = g1

g1.next()
g1.next()
g2.next()
g2.next()


var g3 = AnyIterator(g1)

g3.next()
g1.next()
g3.next()
g3.next()

//Sequences
func fibGenerator() -> AnyIterator<Int> {
    var state = (0, 1)
    return AnyIterator {
        let result = state.0
        state = (state.1, state.0 + state.1)
        return result
    }
}

let fibSeq = AnySequence(fibGenerator)


////:Designing a protocol for queues
//protocol QueueType {
//    //The type of elements held in 'self'
//    associatedtype Element
//    
//    //enqueue 'newElement' to 'self'
//    mutating func enqueue(_ newElement: Element)
//    
//    //dequeue an element from 'self'
//    mutating func dequeue() -> Element?
//}
//
//struct Queue<Element> {
//    private var left: [Element]
//    private var right: [Element]
//    
//    init() {
//        left = []; right = []
//    }
//    
//    /// Add an element to the back of the queue in O(1).
//    mutating func enqueue(_ element: Element) {
//        right.append(element)
//    }
//    
//    /// Removes front of the queue in amortized O(1).
//    /// Returns nil in case of an empty queue.
//    mutating func dequeue() -> Element? {
//        guard !(left.isEmpty && right.isEmpty)
//            else { return nil }
//        
//        if left.isEmpty {
//            left = right.reversed()
//            right.removeAll(keepingCapacity: true)
//        }
//        return left.removeLast()
//    }
//}
//
//
//////MARK: Conforming to CollectionType
////extension Queue: Collection {
////    var startIndex: Int { return 0 }
////    var endIndex: Int { return left.count + right.count }
////    
////    subscript(idx: Int) -> Element {
////        precondition((0..<endIndex).contains(idx), "Index out of bounds")
////        if idx < left.endIndex {
////            return left[left.count - (idx + 1)]
////        } else {
////            return right[idx - left.count]
////        }
////    }
////}
//
//
//var q = Queue<String>()
//for x in ["1","2","foo","3"] {
//    q.enqueue(x)
//}
//
//// you can now for...in over queues
//for s in q { print(s) }     // prints 1 2 foo 3
//
//// pass queues to methods that take sequences
//q.joined(separator: ",")    // "1,2,foo,3"
//let aa = Array(q)            // aa = ["1","2","foo","3]
//
//// call methods that extend SequenceType
//q.map { $0.uppercased()} // ["1","2","FOO","3"]
//q.flatMap { Int($0) }       // [1,2,3]
//q.filter {                  // ["foo"]
//    $0.characters.count > 1
//}
//
//// and CollectionType
//q.isEmpty                   // false
//q.count                     // 4
//q.first                     // "1"
//q.left                      // "3"
//
//
////MARK: ArrayLiteralConvertible
//extension Queue: ArrayLiteralConvertible {
//    init(arrayLiteral elements: Element...) {
//        self.left = elements.reversed()
//        self.right = []
//    }
//}
//
//let qq: Queue = [1,2,3]
//
////MARK: RangeReplaceableCollectionType
//extension Queue: RangeReplaceableCollection {
//    mutating func reserveCapacity(_ n: Int) {
//        return
//    }
//    
//    mutating func replaceSubrange<C : Collection where C.Iterator.Element == Element>
//        (_ subRange: Range<Int>, with newElements: C) {
//            right = left.reversed() + right
//            left.removeAll(keepingCapacity: true)
//            right.replaceSubrange(subRange, with: newElements)
//    }
//}
//
//
////Indices
///// A simple linked list enum
//enum List<Element> {
//    /// The end of a list
//    case end
//    indirect case node(Element, next: List<Element>)
//}
//
//extension List {
//    /// Return a new list by prepending a node
//    /// with value `x` to the front of a list.
//    func cons(_ x: Element) -> List {
//        return .node(x, next: self)
//    }
//}
//
//// a 3-element list, of (3 2 1)
//let l = List<Int>.end.cons(1).cons(2).cons(3)
//
///// A LIFO stack type with constant-time push and pop operations
//protocol StackType {
//    /// The type of element held stored in the stack
//    associatedtype Element
//    
//    /// Pushes `x` onto the top of `self`
//    ///
//    /// - Complexity: Amortized O(1).
//    mutating func push(_ x: Element)
//    /// Removes the topmost element of `self` and returns it,
//    /// or `nil` if `self` is empty.
//    ///
//    /// - Complexity: O(1)
//    mutating func pop() -> Element?
//}
//
//extension Array: StackType {
//    mutating func push(_ x: Element) {
//        self.append(x)
//    }
//    
//    mutating func pop() -> Element? {
//        return self.popLast()
//    }
//}
//
//extension List: StackType {
//    mutating func push(_ x: Element) {
//        self = self.cons(x)
//    }
//    
//    mutating func pop() -> Element? {
//        switch self {
//        case .end: return nil
//        case let .node(x, next: xs):
//            self = xs
//            return x
//        }
//    }
//}
//
//
//var stack = List<Int>.end.cons(1).cons(2).cons(3)
//var aaa = stack
//var bbb = stack
//
//aaa.pop() // 3
//aaa.pop() // 2
//aaa.pop() // 1
//
//stack.pop() // 3
//stack.push(4)
//
//bbb.pop() // 3
//bbb.pop() // 2
//bbb.pop() // 1
//
//stack.pop() // 4
//stack.pop() // 2
//stack.pop() // 1
//
//
////MARK: SequenceType
//extension List: Sequence {
//    func makeIterator() -> AnyIterator<Element> {
//        // declare a variable to capture that
//        // tracks progression through the list:
//        var current = self
//        return AnyIterator {
//            // next() will pop, returning nil
//            // when the list is empty:
//            current.pop()
//        }
//    }
//}
//
//extension List: ArrayLiteralConvertible {
//    init(arrayLiteral elements: Element...) {
//        self = elements.reversed().reduce(.end) {
//            $0.cons($1)
//        }
//    }
//}
//
//let ll: List = ["1","2","3"]
//for x in ll {
//    print("\(x) ", terminator: "")
//}
//
//ll.joined(separator: ",")        // "1,2,3"
//ll.contains("2")                 // true
//ll.flatMap { Int($0) }           // [1,2,3]
//ll.elementsEqual(["1","2","3"])  // true
//
//
//let standardIn = AnySequence {
//    return AnyIterator {
//        readLine()
//    }
//}
//
//let numberedStdIn = standardIn.enumerated()
//for (i, line) in numberedStdIn {
//    print("\(i+1): \(line)")
//}
//
////extension SequenceType {
////    func enumerate() -> AnySequence<(Int,Generator.Element)> {
////        
////        // Swift currently needs a type-inference helping hand with this closure:
////        return AnySequence { _ -> AnyGenerator<(Int,Generator.Element)> in
////            
////            // create a fresh counter and generator to begin enumeration
////            var i = 0
////            var g = self.generate()
////            // capture these in a closure and return that in a new generator
////            return anyGenerator {
////                // when the base sequence is exhausted, return nil
////                guard let next = g.next()
////                    else { return nil }
////                
////                return (i++, next)
////            }
////        }
////    }
////}
//
//
///// Private implementation detail of the List collection
//private enum ListNode<Element> {
//    case end
//    indirect case node(Element, tag: Int, next: ListNode<Element>)
//    
//    /// Computed property to fetch the tag. .End has an
//    /// implicit tag of zero.
//    var tag: Int {
//        switch self {
//        case .end: return 0
//        case let .node(_, tag: n, _):
//            return n
//        }
//    }
//    
//    func cons(_ x: Element) -> ListNode<Element> {
//        // each cons increments the tag by one
//        return .node(x, tag: tag+1, next: self)
//    }
//}
//
//public struct ListIndex<Element> {
//    private let node: ListNode<Element>
//}
//
//
//
//
//assert(sizeof(ListNode<Int>) == sizeof(ListIndex<Int>))
//
////extension ListIndex: Comparable {
////    public func successor() -> ListIndex<Element> {
////        switch node {
////        case .end:
////            fatalError("cannot increment endIndex")
////        case let .node(_, _, next: next):
////            return ListIndex(node: next)
////        }
////    }
////}
//
////public func == <T>(lhs: ListIndex<T>, rhs: ListIndex<T>) -> Bool {
////    return lhs.node.tag == rhs.node.tag
////}
//
//
////public struct List_n<Element>: Collection {
////    // Index's type could be inferred, but it helps make the
////    // rest of the code clearer:
////    public typealias Index = ListIndex<Element>
////    
////    public var startIndex: Index
////    public var endIndex: Index
////    
////    public subscript(idx: Index) -> Element {
////        switch idx.node {
////        case .end: fatalError("Subscript out of range")
////        case let .node(x, _, _): return x
////        }
////    }
////}
//
////
////extension List_n: ArrayLiteralConvertible {
////    public init(arrayLiteral elements: Element...) {
////        startIndex = ListIndex(node: elements.reversed().reduce(.end) {
////            $0.cons($1)
////            })
////        endIndex = ListIndex(node: .end)
////    }
////}
//////
//////let lll: List_n = ["one", "two", "three"]
//////lll.first
//////lll.index(of: "two")
////
////extension List_n {
////    public var count: Int {
////        return startIndex.node.tag - endIndex.node.tag
////    }
////}
////
////public func == <T: Equatable>(lhs: List_n<T>, rhs: List_n<T>) -> Bool {
////    return lhs.elementsEqual(rhs)
////}
//
//
//
//let dic = [["1":1], ["2": 2]]
//let result = dic.flatMap {$0}
//result
//
//
////map
//var o1:Int? = nil
//
//var o1m = o1.map({$0 * 2})
//o1m /* Int? with content nil */
//
//o1 = 1
//
//o1m = o1.map({$0 * 2})
//o1m /* Int? with content 2 */
//
//var os1m = o1.map({ (value) -> String in
//    String(value * 2)
//})
//os1m /* String? with content 2 */
//
//os1m = o1.map({ (value) -> String in
//    String(value * 2)
//}).map({"number "+$0})
//os1m /* String? with content "number 2" */
//
//
//
////flatMap
//var fo1:Int? = nil
//
//var fo1m = fo1.flatMap({$0 * 2})
//fo1m /* Int? with content nil */
//
//fo1 = 1
//
//fo1m = fo1.flatMap({$0 * 2})
//fo1m /* Int? with content 2 */
//
//var fos1m = fo1.flatMap({ (value) -> String? in
//    String(value * 2)
//})
//fos1m /* String? with content "2" */
//
//var fs1:String? = "1"
//
//var fi1 = fs1.flatMap {
//    Int($0)
//}
//fi1 /* Int? with content "1" */
//
//var fi2 = fs1.flatMap {
//    Int($0)
//    }.map {$0*2}
//
//fi2 /* Int? with content "2" */
//
//
//var fa1 = [1,2,3,4,5,6]
//
//var fa1m = fa1.flatMap({$0 * 2})
//fa1m /*[Int] with content [2, 4, 6, 8, 10, 12] */
//
//var fao1:[Int?] = [1,2,3,4,nil,6]
//
//var fao1m = fao1.flatMap({$0})
//fao1m /*[Int] with content [1, 2, 3, 4, 6] */
//
//var fa2 = [[1,2],[3],[4,5,6]]
//
//var fa2m = fa2.flatMap({$0})
//fa2m /*[Int] with content [1, 2, 3, 4, 6] */
//
//var fa3:[[Int?]] = [[1,2],[3],[nil,4,5]]
//
//var fa3m = fa3.flatMap {$0}.flatMap {$0}
//fa3m
//

























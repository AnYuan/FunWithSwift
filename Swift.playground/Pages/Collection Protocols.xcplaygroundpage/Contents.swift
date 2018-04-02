import Foundation


struct ConstantIterator: IteratorProtocol {
    typealias Element = Int
    mutating func next() -> Int? {
        return 1
    }
}

struct FibsIterator: IteratorProtocol {
    var state = (0,1)
    typealias Element = Int
    mutating func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}



struct PrefixIterator: IteratorProtocol {
    let string: String
    var offset: String.Index
    
    init(string: String) {
        self.string = string
        offset = string.startIndex
    }
    
    mutating func next() -> Substring? {
        guard offset < string.endIndex else { return nil }
        offset = string.index(after:offset)
        return string[..<offset]
    }
}

struct PrefixSequence: Sequence {
    let string: String
    func makeIterator() -> PrefixIterator {
        return PrefixIterator(string: string)
    }
}

example(of: "prefix") {
    for prefix in PrefixSequence(string: "Hello") {
        print(prefix)
    }
    
    print(PrefixSequence(string:"Hello").map {$0.uppercased()})
}

example(of: "stride") {
    //A sequence from 0 to 9
    let seq = stride(from:0, to:10, by:1)
    var i1 = seq.makeIterator()
    i1.next()
    i1.next()
    
    var i2 = i1
    
    i1.next()
    i1.next()
    i2.next()
    i2.next()
    
    let i3 = AnyIterator(i1)
    let i4 = i3
    
    i3.next()
    i4.next()
    i3.next()
    i3.next()
}

example(of: "function-based iterators and sequences") {
    func fibsIterator() -> AnyIterator<Int> {
        var state = (0,1)
        return AnyIterator {
            let upcomingNumber = state.0
            state = (state.1, state.0 + state.1)
            return upcomingNumber
        }
    }
    
    let fibsSequence = AnySequence(fibsIterator)
    print(Array(fibsSequence.prefix(10)))
    
    let fibsSequence2 = sequence(state: (0,1)) { (state: inout (Int, Int)) -> Int? in
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
    
    print(Array(fibsSequence2.prefix(10)))
}

//linked list
enum List<Element> {
    case end
    indirect case node(Element, next:List<Element>)
}

extension List{
    func cons(_ x: Element) -> List {
        return .node(x, next:self)
    }
}

extension List: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) {
            partialList, element in
            partialList.cons(element)
        }
    }
}

extension List {
    mutating func push(_ x:Element) {
        self = self.cons(x)
    }
    
    mutating func pop() -> Element? {
        switch self {
        case .end: return nil
        case let .node(x, next:tail):
            self = tail
            return x
        }
    }
}

extension List: IteratorProtocol, Sequence {
    mutating func next() -> Element? {
        return pop()
    }
}

example(of: "linked list") {
    let emptyList = List<Int>.end
    let oneElementList = List.node(1, next: emptyList)
    let list = List<Int>.end.cons(1).cons(2).cons(3)
    
    let list2:List = [3,2,1]
    
    var stack: List<Int> = [3,2,1]
    var a = stack
    var b = stack
    
    a.pop()
    a.pop()
    a.pop()
    
    stack.pop()
    stack.push(4)
    
    b.pop()
    b.pop()
    b.pop()
    
    stack.pop()
    stack.pop()
    stack.pop()
}

example(of: "Conforming list to sequence") {
    let list: List = ["1","2","3"]
    for x in list {
        print("\(x) ",terminator:"")
    }
    
    list.joined(separator: ",")
    list.contains("2")
    list.flatMap {Int($0)}
    list.elementsEqual(["1","2","3"])
}


//Collections

//A type that can 'enqueue' and 'dequeue' elements
protocol Queue {
    associatedtype Element
    mutating func enqueue(_ newElement:Element)
    mutating func dequeue() -> Element?
}

struct FIFOQueue<Element>:Queue {
    private var left:[Element] = []
    private var right:[Element] = []
    
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

//protocol Collection: Sequence { }
//extension FIFOQueue:Collection {
//
//}


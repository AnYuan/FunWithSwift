import Foundation

//Mutablity
class BinaryScanner {
    var position: Int
    let data: Data
    init(data: Data) {
        self.position = 0
        self.data = data
    }
}

extension BinaryScanner {
    func scanByte() -> UInt8? {
        guard position < data.endIndex else {
            return nil
        }
        position += 1
        return data[position-1]
    }
}


example(of: "binary scanner") {
    func scanRemainingBytes(scanner:BinaryScanner) {
        while let byte = scanner.scanByte() {
            print(byte)
        }
    }
    
    let scanner = BinaryScanner(data:Data("hi".utf8))
    scanRemainingBytes(scanner: scanner)
    
    
    for _ in 0..<2 {
        let newScanner = BinaryScanner(data:Data("hi".utf8))
        DispatchQueue.global().async {
            scanRemainingBytes(scanner:newScanner)
        }
        scanRemainingBytes(scanner:newScanner)
    }
}

struct Point {
    var x: Int
    var y: Int
}

struct Size {
    var width: Int
    var height: Int
}

struct Rectangle {
    var origin: Point
    var size: Size
}

extension Point {
    static let zero = Point(x:0, y:0)
}

extension Rectangle {
    init(x:Int = 0, y:Int = 0, width: Int, height: Int) {
        origin = Point(x:x, y:y)
        size = Size(width:width, height:height)
    }
}

example(of: "structs") {
    let origin = Point(x:0, y:0)
//    origin.x = 10//error
    
    var otherPoint = Point(x:0, y:0)
    otherPoint.x += 10
    otherPoint
    
    var thirdPoint = origin
    thirdPoint.x += 10
    thirdPoint
    origin
    
    let rect = Rectangle(origin:Point.zero, size:Size(width:320, height:480))
    
}

func + (lhs:Point, rhs:Point) -> Point {
    return Point(x:lhs.x + rhs.x, y:lhs.y + rhs.y)
}

extension Rectangle {
    mutating func translate(by offset:Point) {
        origin = origin + offset
    }
}

example(of: "mutation semantics") {
    var screen = Rectangle(width:320, height:480) {
        didSet {
            print("screen changed:\(screen)")
        }
    }
    screen.origin.x = 10
}

example(of: "mutation methods") {
    
    var screen = Rectangle(width:320, height:480)
    screen.origin + Point(x:10, y:10)
}

//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

let single = "Pok\u{00E9}mon"
let double = "Pok\u{0065}\u{0301}mon"

single.characters.count == double.characters.count

single.utf16.count
double.utf16.count

let nsdouble = NSString(characters:[0x0065,0x0301], length: 2)
nsdouble.length

let nssingle = NSString(characters:[0x00e9], length:1)
nssingle.length
nssingle == nsdouble

func == (lhs: NSObject, rhs: NSObject) -> Bool {
    return lhs.isEqual(rhs)
}


single == double
single.utf16.elementsEqual(double.utf16)


let chars: [Character] = [
    "\u{1ECD}\u{300}",
    "\u{F2}\u{323}",
    "\u{6F}\u{323}\u{300}",
    "\u{6F}\u{300}\u{323}"
]

let flags = "🇨🇳🇬🇧🇫🇷"
flags.characters.count
print((flags.unicodeScalars.map {String($0)}).joined(separator: ","))


//:Strings and Collections
extension String: Collection {}

extension String: RangeReplaceableCollection {}

var greeting = "Hello, world!"
if let comma = greeting.range(of: ",") {
    greeting.replaceSubrange(comma, with: "How about some original example strings?")
}

let s = "abcdef"

let idx = s.index(s.startIndex, offsetBy:5)
s[idx]

let safeIdx = s.index(s.startIndex, offsetBy:6, limitedBy: s.endIndex)
print(safeIdx)
print(s.startIndex)
print(s.endIndex)

assert(safeIdx! == s.endIndex)


for(i, c) in "hello".characters.enumerated() {
    print("\(i): \(c)")
}


var greet = "Hello!"
if let idx = greet.characters.index(of: "!") {
    greet.insert(contentsOf: ", wrold".characters, at: idx)
}

greet

//A Simple Regular Expression Matcher

//A simple regular expression type, supporting ^ and $ anchors,
//and matching with . and *
public struct Regex {
    private let regexp: String
    //construct from a regular expression String
    public init(_ regexp: String) {
        self.regexp = regexp
    }
}

extension Regex {
    //returns true if the string argument matches the expression
    public func match(_ text: String) -> Bool {
        
        //if the regex starts with ^, then it can only match the 
        //start of the input
        if regexp.characters.first == "^" {
            return Regex.matchHere(regexp.characters.dropFirst(),text.characters)
        }
        
        //otherwise, search for a match at every point in the input
        //until one is found
        var idx = text.startIndex
        while true {
            if Regex.matchHere(regexp.characters, text.characters.suffix(from: idx)) {
                return true
            }
            guard idx != text.endIndex else { break }
            idx = text.index(after: idx)
        }
        return false
    }
}

extension Regex {
    //match a regular expression string at the beginning of text.
    private static func matchHere(_ regexp: String.CharacterView, _ text: String.CharacterView) -> Bool {
        //empty regexprs match everything
        if regexp.isEmpty {
            return true
        }
        //any character followed by * requires a call to matchStar
        if let c = regexp.first , regexp.dropFirst().first == "*" {
            return matchStar(c, regexp.dropFirst(2), text)
        }
        
        //if this is the last regex acharacter and it's $, then
        //it's a match iff the remaining text is also empty
        if regexp.first == "$" && regexp.dropFirst().isEmpty {
            return text.isEmpty
        }
        
        //if one character matches, drop one from the input
        //and the regex and keep matching
        if let tc = text.first, let rc = regexp.first , rc == "." || tc == rc {
            return matchHere(regexp.dropFirst(), text.dropFirst())
        }
        
        //if none of the above, no match
        return false
    }
    
    //search for zero or more 'c''s at beginning of text, followed by the remainder of the regular expression.
    private static func matchStar(_ c: Character, _ regexp: String.CharacterView, _ text: String.CharacterView) -> Bool {
        var idx = text.startIndex
        while true {
            if matchHere(regexp, text.suffix(from: idx)) {
                return true
            }
            if idx == text.endIndex || (text[idx] != c && c != ".") {
                return false
            }
            idx = text.index(after: idx)
        }
    }
}


Regex("^h..lo*!$").match("hellooooooo!")



//: StringLiteralConvertible
extension Regex: StringLiteralConvertible {
    public init(stringLiteral value: String) {
        regexp = value
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self = Regex(stringLiteral: value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self = Regex(stringLiteral: value)
    }
}


let r:Regex = "^h..lo*!$"

func findMatches(strings: [String], regex: Regex) -> [String] {
    return strings.filter { regex.match($0) }
}

findMatches(strings: ["foo","bar","baz"], regex: "^b..")

//typealias StringLiteralType = StaticString
//: Strings and slicing
let world = "Hello, world!".characters.suffix(6).dropLast()
print(world)

//let what = "hello"




//:Internal Structure of String
print(sizeof(String.self))

let hello = "hello"
let bits = unsafeBitCast(hello, to: _StringCore.self)
print(bits)

struct StringCoreClone {
    var _baseAddress: OpaquePointer
    var _countAndFlags: UInt
    var _owner: AnyObject?
}

let clone = unsafeBitCast(bits, to: StringCoreClone.self)
print(clone._countAndFlags)
//extra UnsafePointer init to convert from pointed-to-type of Void to Int8
puts(UnsafePointer(clone._baseAddress))

let emoji = "Hello, 🌐"
let emojiBits = unsafeBitCast(emoji, to: StringCoreClone.self)

extension StringCoreClone {
    var count: Int {
        let mask = 0b11 << UInt(sizeof(UInt.self)*8 - 2)
        return Int(_countAndFlags & ~mask)
    }
}

emoji._core.count

let buf = UnsafeBufferPointer(start: UnsafePointer<UInt16>(emojiBits._baseAddress),
                              count: emojiBits.count)

var gen = buf.makeIterator()
var utf16 = UTF16()
while case let .scalarValue(scalar) = utf16.decode(&gen) {
    print(scalar, terminator:"")
}

//var greeting_v = "hello"
//greeting_v.append(contentsOf: " world")
//let greetingBits = unsafeBitCast(greeting_v, to: StringCoreClone.self)

let ns = "hello" as NSString
let ss = ns as String
let (_,_, owner) = unsafeBitCast(ss, to: (UInt, UInt, NSString).self)
print(owner)
owner === ns


//:Internal Organization of Character
sizeof(Character.self)
//echo ":type lookup Character" | swift | less



//:Code Unit Views

//this will break the string apart at every non-alphanumeric character
extension String {
    func words(splitBy: NSCharacterSet = .alphanumerics) -> [String] {
        return self.utf16.split {
            !splitBy.characterIsMember($0)
        }.flatMap(String.init)
    }
}

let sentence = "Wow! This contains _all_ kinds of things like 123 and \"quotes\"?"
let array = sentence.words()


//extension String.UTF16Index: Strideable {
//    
//}


//TODO: not work yet
//let helloWorld = "Hello, world!"
//if let idx = helloWorld.utf16.index(of:"world".utf16)?.samePosition(in: helloWorld) {
//    print(helloWorld[idx..<helloWorld.endIndex])
//}


//:CustomStringConvertible and CustomDebugStringConvertible
struct Queue {}

extension Queue: CustomStringConvertible, CustomDebugStringConvertible {
    var description: String {
        return ""
    }
    
    var debugDescription: String {
        return ""
    }
}










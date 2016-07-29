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

















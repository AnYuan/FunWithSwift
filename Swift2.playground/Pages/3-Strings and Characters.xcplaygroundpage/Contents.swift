//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

var emptyString = ""
var anotherEmptyString = String()

if emptyString.isEmpty {
    print("nothing")
}

for c in "Dog@".characters {
    print(c)
}


let catCharacters: [Character] = ["C", "a", "t", "!"]
let catString = String(catCharacters)

let sparklingHeart = "\u{1F496}"

var word = "cafe"
print(word.characters.count)

word += "\u{301}"

let greeting = "Guten Tag"
greeting[greeting.startIndex]
greeting[greeting.endIndex.predecessor()]
greeting[greeting.startIndex.successor()]
let index = greeting.startIndex.advancedBy(7)
greeting[index]

var welcome = "hello"
welcome.insert("!", atIndex: welcome.endIndex)
welcome.insertContentsOf(" there".characters, at: welcome.endIndex.predecessor())
welcome.removeAtIndex(welcome.endIndex.predecessor())
welcome

let range = welcome.endIndex.advancedBy(-6)..<welcome.endIndex
welcome.removeRange(range)

let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("same")
}



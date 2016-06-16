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
greeting[greeting.characters.index(before: greeting.endIndex)]
greeting[greeting.characters.index(after: greeting.startIndex)]
let index = greeting.characters.index(greeting.startIndex, offsetBy: 7)
greeting[index]

var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
welcome.insert(contentsOf: " there".characters, at: welcome.index(before: welcome.endIndex))
welcome.remove(at: welcome.index(before: welcome.endIndex))
welcome

let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)

let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("same")
}



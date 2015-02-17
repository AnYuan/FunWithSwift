// Playground - noun: a place where people can play

// Functional Programming

var evens = [Int]()
for i in 1...10 {
    if i % 2 == 0 {
        evens.append(i)
    }
}
println(evens)

//Functional Filtering

//filter

//func isEven(number: Int) -> Bool {
//    return number % 2 == 0
//}
//
//evens = Array(1...10).filter(isEven)
//println(evens)

evens = Array(1...10).filter{$0 % 2 == 0}
println(evens)


//Reduce
//var evenSum = 0
//for i in evens {
//    evenSum += i
//}
//println(evenSum)

var evenSum = 0
evenSum = Array(1...10)
    .filter{(number) in number % 2 == 0}
    .reduce(0){(total, number) in total + number}

println(evenSum)

//Map
//Building an index
import Foundation

let words = ["Cat", "Chicken", "fish", "Dog", "Mouse", "Guinea Pig", "Monkey"]

typealias Entry = (Character, [String])

//func buildIndex(words: [String]) -> [Entry] {
//    return [Entry]()
//}


//Building an index imperatively
//func buildIndex(words: [String]) -> [Entry] {
//    var result  = [Entry]()
//    
//    var letters = [Character]()
//    for word in words {
//        let firstLetter = Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString)
//        
//        if !contains(letters, firstLetter) {
//            letters.append(firstLetter)
//        }
//    }
//    
//    for letter in letters {
//        var wordsForLetter = [String]()
//        for word in words {
//            let firstLetter = Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString)
//            
//            if firstLetter == letter {
//                wordsForLetter.append(word);
//            }
//        }
//        result.append((letter, wordsForLetter))
//    }
//    return result
//}

//Building an index in functional way

func distinct<T: Equatable>(source: [T]) -> [T] {
    var unique = [T]()
    for item in source {
        if !contains(unique, item) {
            unique.append(item)
        }
    }
    return unique
}

func buildIndex(words: [String]) -> [Entry] {
    let letters = words.map {
        (word) -> Character in
        Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString)
    }
    
    let distinctLetters = distinct(letters)
    return distinctLetters
        .sorted(<)//sort the array by letter
        .map {
        (letter) -> Entry in
        return (letter, words.filter{ (word) -> Bool in
                Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString) == letter
            }
        )
    }
}
println(buildIndex(words))




//Patial application which process of "fixing" one or more arguments of a function to create a new function
//and currying
import Foundation

let data = "5,7;3,4;55,6"
println(data.componentsSeparatedByString(";"))

//func createSplitter(separator: String) -> (String -> [String]) {
//    func split(source: String) -> [String] {
//        return source.componentsSeparatedByString(separator)
//    }
//    return split
//}
//let commaSplitter = createSplitter(",")
//println(commaSplitter(data))
//
//
//let semiColonSpliter = createSplitter(";")
//println(semiColonSpliter(data))



//currying
func createSplitter(separator: String)(source: String) -> [String] {
    return source.componentsSeparatedByString(separator)
}

let commaSplitter = createSplitter(",")
println(commaSplitter(source:data))


let semiColonSpliter = createSplitter(";")
println(semiColonSpliter(source:data))




func addNumbers(one: Int, two: Int, three: Int) -> Int
{
    return one + two + three
}

let sum = addNumbers(2,5, 4)
println(sum)


func curryAddNumbers(one: Int)(two: Int)(three: Int) -> Int
{
    return one + two + three
}

let stepOne = curryAddNumbers(2)
let stepTwo = stepOne(two: 5)
let result = stepTwo(three: 4);
println(result)

let result2 = curryAddNumbers(2)(two: 5)(three: 4)
println(result2)

func curryAddNumbers2(one: Int, two: Int)(three: Int) -> Int
{
    return one + two + three
}


let result3 = curryAddNumbers2(2, 5)(three: 4)
println(result3)

//practical currying
let text = "Swift"
let paddedText = text.stringByPaddingToLength(10, withString: ".", startingAtIndex: 0)
println(paddedText)

func curriedPadding(startingAtIndex: Int, withString: String)(source: String, length: Int) -> String
{
    return source.stringByPaddingToLength(length, withString: withString, startingAtIndex: startingAtIndex)
}

let dotPadding = curriedPadding(0, ".")

let dotPadded = dotPadding(source:"Curry!", length: 10)
println(dotPadded)

































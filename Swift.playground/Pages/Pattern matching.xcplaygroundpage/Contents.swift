import Foundation

let name = "twostraws"

switch name {
case "bilbo":
    print("Hello, Bilbo Baggins!")
case "twostraws":
    print("Hello, Paul Hudson!")
default:
    print("Authentication failed")
}


let authetication = (name: "twostraws", password: "fr0st1es", ipAddress: "127.0.0.1")

switch authetication {
case (_, _, _):
    print("You could be anybody!")
case ("bilbo", "baggln5", _):
    print("Hello, Bilbo Baggins!")
case ("twostraws", let password, _):
    print("Hello, Paul Hudson: your password was \(password)")
default:
    print("Who are you?")
}


func fizzbuzz(number: Int) -> String {
    switch (number % 3 == 0, number % 5 == 0) {
    case (true, false):
        return "Fizz"
    case (false, true):
        return "Buzz"
    case (true, true):
        return "FizzBuzz"
    case (false, false):
        return String(number)
    }
}


print(fizzbuzz(number: 15))


// Loops
let twostraws = (name: "twostraws", password: "fr0st1es")
let bilbo = (name: "bilbo", password: "baggln5")
let taylor = (name: "taylor", password: "fr0stles")

let users = [twostraws, bilbo, taylor]

for user in users {
    print(user.name)
}


for case ("twostraws", "fr0st1es") in users {
    print("User twostraws has the password fr0st1es")
    print("")
}


for case (let name, let password) in users {
    print("User \(name) has the password \(password)")
}

for case let (name, password) in users {
    print("User \(name) has the password \(password)")
}

for case let (name, "fr0st1es") in users {
    print("User \(name) has the password fr0st1es")
}

// Matching Optionals
let namex: String? = "twostraws"
let passwordx: String? = nil

switch (namex, passwordx) {
case let (n?, p?): // String type
    type(of:n)
    print("Hello, \(n)\(p)")
case let (username, .none): //Optinal<String> type
    type(of:username)
    print("\(username ?? "") Please enter a password.")
default:
    print("Who are you?")
}


// Matching ranges
let age = 36

switch age {
case 0 ..< 18:
    print("You have the energy and time, but not the money")
case 18 ..< 70:
    print("You have the energy and money, but not the time")
default:
    print("You have the time and money, but not the energy")
}

if (0 ..< 18).contains(age) {
    print("You have the energy and time, but not the money")
} else if (18 ..< 70).contains(age) {
    print("You have the energy and money, but not the time")
} else {
    print("You have the time and money, but not the energy")
}


// Matching enums and associated values
enum WeatherType {
    case cloudy(coverage: Int)
    case sunny
    case windy
}

let today = WeatherType.cloudy(coverage: 100)

switch today {
case .cloudy(let coverage) where coverage < 100:
    print("It's cloudy with \(coverage)% coverage")
case .cloudy(let coverage) where coverage == 100:
    print("You must live in the UK")
case .windy:
    print("It's windy")
default:
    print("It's sunny")
}

let forecast:[WeatherType] = [.cloudy(coverage:40), .sunny, .windy, .cloudy(coverage:100), .sunny]

for case let .cloudy(coverage) in forecast {
    print("It's cloudy with \(coverage)% coverage")
}

for case let .cloudy(40) in forecast {
    print("It's cloudy with 40% coverage")
}


// Matching types
import UIKit

let view: AnyObject = UIButton()

switch view {
case is UIButton:
    print("Found a button")
case is UILabel:
    print("Found a label")
case is UISwitch:
    print("Found a switch")
case is UIView:
    print("Found a view")
default:
    print("Found something else")
}

let celebrities = ["Michael Jackson", "Taylor Swift", "Michael Caine", "Adele Adkins", "Michael Jordan"]

for name in celebrities where name.hasPrefix("Michael") && name.count == 13 {
    print(name)
}

let OptinalCelebrities:[String?] = ["Michael Jackson", nil, "Michael Caine", nil, "Michael Jordan"]

for name in OptinalCelebrities where name != nil {
    print(name)
}

for case let nn? in OptinalCelebrities {
    print(nn)
}

//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
//:Type Casting
/*:
Type casting in Swift is implemented with the is and as operators. These two operators provide a simple and expressive way to check the type of a value or cast a value to a different type.
You can also use type casting to check whether a type conforms to a protocol
*/

//:Defining a Class Hierarchy for TypeCasting

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

//:Checking Type
//:Use the type check operator (is) to check whether an instance is of a certain subclass type.

var movieCount = 0
var songCount = 0
for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

//:Downcasting
/*:
Because downcasting can fail, the type cast operator comes in two different forms.
The conditional form, as?, return an optional value of the type you are trying to downcast to. The forced form, as!, attempts the downcast and force-upwraps the result as a single compound action.
Use the conditional form of the type cast operator (as?) when you are not sure if the downcast will succceed. This form of the operator will always return an optioanl value, and the value will be nil if the downcast was not possible. This enables you to check for a successful downcast.
Use the forced form of the type cast operator (as!) only when you are sure that the downcast will always succeed. This form of the operator will trigger a runtime error if you try to downcast to an incorrect class type.
*/

for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name)")
    } else if let song = item as? Song {
        print("Song: \(song.name)")
    }
}

//:Type Casting for Any and AnyObject
/*:
Swift provides two special type aliases for working with non-specific types:
* AnyObject can represent an instance of any class type.
* Any can represent an instance of any type at all, including function types.
*/
//:AnyObject
let someObjects: [AnyObject] = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Movie(name: "Alien", director: "Ridley Scott")
]

for object in someObjects {
    let movie = object as! Movie
    print("\(movie.name)")
}


for movie in someObjects as! [Movie] {
    print("\(movie.name)")
}

//:Any
var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append("hello")
things.append((3.0, 5.0))

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("\(someInt)")
    case is Double:
        print("some double value")
    case let (x, y) as (Double, Double):
        print("tuple")
    default:
        print("something else")
    }
    
}


import Foundation


struct User {
    let name: String
}

let u1 = User(name: "a")
let u2 = User(name: "b")
let u3 = User(name: "c")

let users = [u1, u2, u3]

let c = users.map(\User.name)
print(c)



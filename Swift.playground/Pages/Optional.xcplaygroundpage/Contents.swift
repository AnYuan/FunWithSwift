import Foundation

infix operator !!
func !! <T>(wrapped:T?, failureText:@autoclosure() -> String) -> T {
    if let x = wrapped { return x }
    fatalError(failureText())
}

let s = "foo"
let i = Int(s) !! "Expecting integer, got \"\(s)\""


infix operator !?
func !?<T:ExpressibleByIntegerLiteral>(wrapped:T?, failureText:@autoclosure() -> String) -> T {
    assert(wrapped != nil, failureText)
    return wrapped ?? 0
}


let ss = "20"
let ii = Int(s) !? "Expecting integer, got \"\(s)\""



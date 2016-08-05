//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}


extension Result {
    func map<U>(f: (T) -> U) -> Result<U, E> {
        switch self {
        case .success(let t):
            return .success(f(t))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func flatMap<U>(f: (T) -> Result<U, E>) -> Result<U, E> {
        switch self {
        case .success(let t):
            return f(t)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    //return the value if it's a .success or throw the error if it's a .failure
    func resolve() throws -> T {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
    
    //construct a .success if the expresion returns a value
    //or a .failure if it throws
    init(_ throwingExpression: @noescape (Void) throws -> T) {
        do {
            let value = try throwingExpression()
            self = .success(value)
        } catch let error as E{
            self = .failure(error)
        } catch {
            fatalError("catch unknown error")
        }
    }
}

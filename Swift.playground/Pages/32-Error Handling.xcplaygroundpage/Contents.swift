//: [Previous](@previous)

import Foundation


//enum Result<A> {
//    case Failure(Error)
//    case Success(A)
//}
//
//enum FileError: Error {
//    case FileDoesNotExist
//    case NoPermission
//}
//
//func contentsOfFile(filename: String) -> Result<String> {
//    return .Success("hhhh")
//}
//
//let result = contentsOfFile(filename: "input.txt")
//
//switch result {
//case let .Success(contents):
//    print(contents)
//case let .Failure(error):
//    if let fileError = error as? FileError , fileError == .FileDoesNotExist {
//        print("empty file")
//    } else {
//        //handle error
//    }
//}

enum Result<A, Error> {
    case Failure(Error)
    case Success(A)
}

//enum ParseError: Error {
//    
//}
//
//func parseFile(contents: String) -> Result<[String], ParseError> {
//    
//}


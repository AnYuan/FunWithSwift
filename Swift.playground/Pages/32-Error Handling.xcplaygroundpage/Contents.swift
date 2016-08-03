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


//rethrows tells the compiler that this function will only throw an error
//when its function parameter throws an error. this allows the compiler
//to waive the requirement that call must be called with try when the 
//caller passes in a non-throwing check function
extension Sequence {
    func all(_ check: @noescape (Iterator.Element) throws -> Bool) rethrows -> Bool {
        for el in self {
            guard try check(el) else { return false }
        }
        return true
    }
}


//:Cleaning up using defer
func someFun() {
    print("begin...")
    defer {
        print("defer 0")
    }

    print("hahaha")
    
    defer {
        print("defer 1")
    }
    
    print("finish...")
    
    
    defer {
        print("defer 2")
    }
}


someFun()

//there are some cases in which defer blocks do not get executed:
//when your program segfaults or raises a fatal error, all execution
//halts immediately.


//chaining error
//func checkFilesAndFetchProcessID(filenames:[String]) -> Int {
//    do {
//        try filenames.all(checkFile)
//        let contents = try contentsOfFile("Pidfile")
//        return try optional(Int(contents), orError: ReadIntError.CloudNotRead)
//    } catch {
//        return 42
//    }
//}

//Result version
//func checkFilesAndFetchProcessID(filenames:[String]) -> Result<Int> {
//    return filenames.all(checkFile)
//        .flatMap{_ in contentsOfFile("Pidfile")}
//        .flatMap{contents in
//    Int(contents).map(Result.Success) ?? .Failure(ReadIntError.CouldNotRead)}
//}


//In the meantime, we now have many possible choices for handling the unexpected in our code. When we cannot possibly continue, we can use fatalError or an assertion. When we are not interested in the kind of error, or if there’s only one kind of error, we can use optionals. When we need more than one kind of error, or want to provide additional information, we can use Swift’s built-in errors or write our own Result type. When we want to write functions that take a function as a parameter, we can use rethrows to allow for both throwing and non-throwing function parameters. Finally, the defer statement is very useful when using the built-in errors. By using defer statements, we can clean up everything once the scope exits, regardless of whether or not it’s a normal scope exit, because of a throws, or because of an early return.


















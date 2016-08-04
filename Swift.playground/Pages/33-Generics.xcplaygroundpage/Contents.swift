//: [Previous](@previous)

import Foundation


//Library code
let old = [1,2,3]
let new = [1,2,4,5]

//extension Collection where Iterator.Element: Hashable {
//    
//    //return a new array with elements in 'self' that do not
//    //occur in 'toRemove'.
//    func subtract(_ toRemove:[Iterator.Element]) -> [Iterator.Element] {
//        let removeSet = Set(toRemove)
//        return self.filter { !removeSet.contains($0) }
//    }
//}
//
//
//new.subtract(old)
//
//extension Sequence where Iterator.Element: Equatable {
//    func subtract(_ toRemove: [Iterator.Element]) -> [Iterator.Element] {
//        return self.filter { !toRemove.contains($0) }
//    }
//}
//
//let ranges1 = [0..<1, 1..<4]
//let ranges2 = [0..<1, 1..<4, 5..<10]
//
//ranges2.subtract(ranges1)


//extension Sequence where Iterator.Element: Hashable {
//    func subtract <S: Sequence> (_ toRemove: S) -> [Iterator.Element] where S.Iterator.Element == Iterator.Element {
//        let removeSet = Set(toRemove)
//        return self.filter { !removeSet.contains($0) }
//    }
//}
//
//extension Sequence where Iterator.Element: Equatable {
//    func subtract <S: Sequence> (_ toRemove: S) -> [Iterator.Element] where S.Iterator.Element == Iterator.Element {
//        return self.filter { !toRemove.contains($0) }
//    }
//}
//[2,4,8].subtract(0..<3)


//let isEven = { $0 % 2 == 0}
//print((0..<5).contains(isEven))
//print([1,3,99].contains(isEven))

print((0..<5).contains{ $0 % 2 == 0 })

print([1,3,99].contains{ $0 % 2 == 0 })

extension Sequence {
    func subtract<S: Sequence> (_ toRemove: S, predicate: (Iterator.Element, S.Iterator.Element) -> Bool) -> [Iterator.Element] {
        return self.filter {
            sourceElement in
            !toRemove.contains { removeElement in
                predicate(sourceElement, removeElement)
            }
        }
    }
}

let result = [[1,2], [3], [4]].subtract([[1,2], [3]]) { $0 == $1 } as [[Int]]
print(result)

let ints = [1,2,3]
let strings = ["1", "2"]
let r = ints.subtract(strings) { $0 == Int($1) }
print(r)
















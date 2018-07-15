import Foundation


let formatter = NumberFormatter()
//formatter.numberStyle = .ordinal
formatter.string(for: 2)

let number = 123.45
formatter.string(for: number)
formatter.string(from: number as NSNumber)


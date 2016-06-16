import Foundation

public struct Message {
    public let from: String
    public let contents: String
    public let date: Date
    
    public init(from: String, contents: String, date: Date) {
        self.from = from
        self.contents = contents
        self.date = date
    }
}

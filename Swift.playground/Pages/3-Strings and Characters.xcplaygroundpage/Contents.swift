import Foundation

example(of: "") {
    
}

let string1 = "welcome aboard!"

let multilineString = """
Thank
you
all
"""

// U+3030 WAVY DASH
"\u{3030}"

#"7+4+7 = \(7+4+7)"#
#"7+4+7 = \#(7+4+7)"#

#"888= \#(multilineString)"#

let name = "Swift"
"Hello, " + name

var welcome = "Welcom"
welcome.append(" back")
welcome += "!"

"Hi!".count


string1.startIndex
string1[string1.startIndex]
string1[string1.index(after: string1.startIndex)]
string1[string1.index(string1.startIndex, offsetBy: 4)]
string1[string1.index(string1.endIndex, offsetBy: -1)]

let range = string1.startIndex..<string1.endIndex

// U+00E9 LATIN SMALL LETTER E WITH ACUTE (é)
let precomposed = "expos\u{00E9}"

// U+0301 COMBINING ACUTE ACCENT ("́")
let decomposed = "expose\u{0301}"

precomposed == decomposed
precomposed.count == decomposed.count

precomposed.utf8.elementsEqual(decomposed.utf8)

extension Unicode.Scalar {
    public var codePoint: String {
        let representation = String(self.value, radix: 16, uppercase: true)
        return "U+" + String(repeating: "0", count: max(4 - representation.count, 0)) + representation
    }
}


example(of: "Accessing Unicode Encoding Forms") {
    let j = "東京 🇯🇵"
    
    for character in j {
        print("\(character)")
        for unicodeScalar in character.unicodeScalars {
            unicodeScalar.properties
            print(unicodeScalar.codePoint, terminator: "\t")
        }
        print()
        
        for utf16CodeUnit in "\(character)".utf16 {
            print(String(utf16CodeUnit, radix: 16, uppercase: true), terminator: "\t")
        }
        print()
        
        for utf8CodeUnit in "\(character)".utf8 {
            print(String(utf8CodeUnit, radix: 16, uppercase: true), terminator: "\t")
        }
        print("\n")
    }
}


example(of: "Accessing Unicode Character Properties") {
    func filterNonEmoji<T>(from string: T) -> String where T: StringProtocol {
        return String(string.filter { character in
            character.unicodeScalars.allSatisfy { unicodeScalar in
                unicodeScalar.properties.isEmoji
            }
        })
    }
    
    filterNonEmoji(from: "EMOJI 👏 MAKE 👏 STRINGS 👏 BETTER 👏")
    
}


example(of: "Unicode Character") {
    
    // U+0031 DIGIT ONE
    ("1" as Character).isNumber
    ("1" as Character).isWholeNumber
    ("1" as Character).wholeNumberValue
    
    // U+2460 CIRCLED DIGIT ONE
    ("①" as Character).isNumber
    ("①" as Character).isWholeNumber
    ("①" as Character).wholeNumberValue
    
    // U+00BD VULGAR FRACTION ONE HALF
    ("½" as Character).isNumber
    ("½" as Character).isWholeNumber
    ("½" as Character).wholeNumberValue
    
    // U+0661 ARABIC-INDIC DIGIT ONE
    ("١" as Character).isNumber
    ("١" as Character).isWholeNumber
    ("١" as Character).wholeNumberValue
    
    // U+4E00 CJK UNIFIED IDEOGRAPH-4E00
    ("一" as Character).isNumber
    ("一" as Character).isWholeNumber
    ("一" as Character).wholeNumberValue
    
    
    ("三" as Character).isNumber
    ("三" as Character).isWholeNumber
    ("廿" as Character).wholeNumberValue
    
}


example(of: "collection and string 0") {
    var string = "expose"
    let newElement: Character = "\u{0301}"
    string.append(newElement)
    string.contains(newElement)
}


example(of: "collection and string 1") {
    // é LATIN SMALL LETTER E WITH ACUTE
    let precomposed = "expos\u{00E9}"
    // e LATIN SMALL LETTER E +
    //  ́ COMBINING ACUTE ACCENT
    let decomposed = "expose\u{0301}"
    
    precomposed == decomposed
}

example(of: "collection and string 2") {
    print("exposé".sorted())
}

// Sequence
example(of: "Iterating the Characters in a String") {
    let string = "Hello, again!"
    for character in string {
        print(character)
    }
}

example(of: "creating arrays of characters") {
    let string = "Hello!"
    Array(string)
    String(Array(string))
}

example(of: "Functional Programming") {
    let result =
        "Boeing 737-800".filter { $0.isCased }
            .map { $0.uppercased()
    }
    print(result)
}

example(of: "splitting") {
    let seats = "7A,7B,10F,13C"
    seats.split(separator: ",")
}

example(of: "finding characters") {
    let isVowel: (Character) -> Bool = {
        "aeiou".contains($0)
    }
    
    "pilot".first(where: isVowel)
}

example(of: "Finding Prefix Substrings") {
    "airport".prefix(3)
    "airport".prefix(while: { $0 != "r"})
}

example(of: "Excluding Characters") {
    let string = "ticket counter"
    string.dropFirst(7)
    string.dropLast(7)
    
    string.prefix(while: { $0 != " "})
    string.drop(while: { $0 != " "})
    
    // avoid using this method
    //    for (offset, char) in string.enumerated() {
    //        print(offset)
    //        print(char)
    //    }
    
}

// Collection
example(of: "Accessing Indices") {
    //    let string = "Hi!"
    //    for (index, character) in zip(string.indices, string) {
    //        print(index.encodedOffset, character)
    //    }
}

example(of: "Determing the Length of a String") {
    let string = "Hello!"
    string.count
    
    //It's much faster to use the isEmpty property instead.
    string.isEmpty
}


// BidirectionalCollection

func isPalindrome(_ string: String) -> Bool {
    let normalized = string.filter { $0.isLetter }
        .lowercased()
    return normalized.elementsEqual(normalized.reversed())
}

example(of: "Reversing a String") {
    print(isPalindrome("I'm a fool; aloof am I."))
}

example(of: "Finding Characters") {
    
    let isVowel: (Character) -> Bool = {
        "aeiou".contains($0)
    }
    
    "pilot".last(where: isVowel)
}

example(of: "Finding Suffix Substrings") {
    print("airport".suffix(4))
}

// RangeReplaceableCollection
example(of: "Adding Characters") {
    var string = "plane"
    string.append("s")
    
    let index = string.index(string.endIndex, offsetBy: -1)
    string.insert("t", at: index)
}

example(of: "Removing Characters") {
    var string = "international concourse"
    string.removeFirst(5)
    string.removeLast(6)
    
    let index = string.lastIndex(of: " ")!
    string.remove(at: index)
    print(string)
    
    let range = string.firstIndex(of: "o")!..<string.lastIndex(of: "o")!
    string.removeSubrange(range)
}

example(of: "Replacing Characters") {
    var string = "lost baggage"
    let index = string.firstIndex(of: " ")!
    string.replaceSubrange(..<index, with: "found")
}


// StringProtocol
import func Darwin.strlen
example(of: "Converting with C Strings") {
    var ascii: [UInt8] = [0x43, 0x00]
    let string = String(cString: &ascii)
    
    string.withCString { pointer in
        strlen(pointer)
    }
}

example(of: "Transforming Case") {
    "hello".uppercased()
    "HELLO".lowercased()
}

example(of: "Checking Prefix and Suffix") {
    let prefix = "airport".prefix(3)
    "airplane".hasPrefix(prefix)
    
    let suffix = "airport".suffix(4)
    "airplane".hasSuffix(suffix)
}

/*
 The most important aspect of StringProtocol is its role as the extension point for Swift strings. If you want to add a method or property to String, define it in an extension to StringProtocol instead to expose the same functionality to Substring
 
 You can also use StringProtocol as a constraint for generic types or extensions with conditional conformance.
 
 struct Wrapper<Value> where Value: StringProtocol {}
 extension Array where Element: StringProtocol {}
 
 StringProtocol doesn't cover the entire String API surface area.
 So if you wnat to use a method like removeSubrange(_:) in your extension, you can define a generic where clause to pull in requirements from the RangeReplaceableCollection protocol.
 
 extension StringProtocol whre Self: RangeReplaceableCollection {}
 
 */
extension StringProtocol {
    var isPalindrome: Bool {
        let normalized = self.lowercased().filter { $0.isLetter }
        return normalized.elementsEqual(normalized.reversed())
    }
}

example(of: "Extending the Functionality of Strings") {
    let string = "I'm a fool; aloof am I."
    string.isPalindrome
    
    let range = string.firstIndex(of: "a")!...string.lastIndex(of: "a")!
    string[range].isPalindrome
}

// CustomStringConvertible & CustomDebugStringConvertible

struct FlightCode {
    let airlineCode: String
    let flightNumber: Int
}

extension FlightCode: CustomStringConvertible {
    var description: String {
        return "\(self.airlineCode) \(self.flightNumber)"
    }
}

example(of: "CustomStringConvertible") {
    let flight = FlightCode(airlineCode: "AA", flightNumber: 1)
    print(flight)
}

extension FlightCode: CustomDebugStringConvertible {
    var debugDescription: String {
        return """
        Airline Code: \(self.airlineCode)
        Flight Number: \(self.flightNumber)
        """
    }
}

example(of: "CustomDebugStringConvertible") {
    let flight = FlightCode(airlineCode: "AA", flightNumber: 1)
    debugPrint(flight)
}

// LosslessStringConvertible
extension FlightCode: LosslessStringConvertible {
    public init?(_ description: String) {
        let components = description.split(separator: " ")
        print(components)
        guard components.count == 2,
            let airlineCode = components.first,
            let number = components.last,
            let flightNumber = Int(number) else {
                return nil
        }
        
        self.airlineCode = String(airlineCode)
        self.flightNumber = flightNumber
    }
}

example(of: "LosslessStringConvertible") {
    let flight = FlightCode(airlineCode: "AA", flightNumber: 1)
    String(flight)
    FlightCode(String(flight))
}


// TextOutputStreamable & TextOutputStream
import func Darwin.fputs
import var Darwin.stderr

struct StderrOutputStream: TextOutputStream {
    mutating func write(_ string: String) {
        fputs(string, stderr)
    }
}

example(of: "TextOutputStreamable & TextOutputStream") {
    var standardError = StderrOutputStream()
    print("Error!", to: &standardError)
}

extension Unicode.Scalar {
    var name: String? {
        guard var escapedName =
            "\(self)".applyingTransform(.toUnicodeName,
                                        reverse: false)
            else {
                return nil
        }
        
        escapedName.removeFirst(3) // remove "\\N{"
        escapedName.removeLast(1) // remove "}"
        
        return escapedName
    }
}

extension UnicodeLogger: CustomStringConvertible {
    public var description: String {
        return "UnicodeLogger"
    }
}

struct UnicodeLogger: TextOutputStream {
    mutating func write(_ string: String) {
        guard !string.isEmpty && string != "\n" else { return }
        
        for (index, unicodeScalar) in string.unicodeScalars.lazy.enumerated() {
            let codePoint = String(format: "U+%04X", unicodeScalar.value)
            let name = unicodeScalar.name ?? ""
            print("\(index): \(unicodeScalar) \(codePoint)\t\(name)")
        }
    }
}

example(of: "UnicodeLogger") {
    var logger = UnicodeLogger()
    print("👨‍👩‍👧‍👧", to: &logger)
}


//ExpressibleByUnicodeScalarLiteral & ExpressibleByExtendedGraphemeClusterLiteral &
//ExpressibleByStringLiteral
example(of: "example") {
    //ExpressibleByUnicodeScalarLiteral
    let unicodeScalar: Unicode.Scalar = "A"

    //ExpressibleByExtendedGraphemeClusterLiteral
    let character: Character = "A"

    //ExpressibleByStringLiteral
    let string: String = "A"

    "A" is String
}

public enum BookingCode: String {
    case firstClass = "F"
    case businessClass = "J"
    case premiumEconomy = "W"
    case economy = "Y"
}

extension BookingCode: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(rawValue: value)!
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}


example(of: "ExpressibleByStringLiteral") {
    // Before
    BookingCode(rawValue: "J")
    // After
    ("J" as BookingCode)
    
    let _: Set<BookingCode> = ["F", "J"]
}

enum Style {
    case none
    case bold
    case italic
    case boldItalic
    case sansSerif(bold: Bool, italic: Bool)
    case script(bold: Bool)
    case fraktur(bold: Bool)
    case doubleStruck
    case monospace
}

typealias Variants = (
    bold: Character,
    italic: Character,
    boldItalic: Character,
    sansSerif: Character,
    sansSerifBold: Character,
    sansSerifItalic: Character,
    sansSerifBoldItalic: Character,
    script: Character,
    scriptBold: Character,
    fraktur: Character,
    frakturBold: Character,
    doubleStruck: Character,
    monospace: Character
)

let characterVariants: [Character: Variants] = [
    "a": ("𝐚", "𝑎", "𝒂", "𝖺", "𝗮", "𝘢", "𝙖", "𝒶", "𝓪", "𝔞", "𝖆", "𝕒", "𝚊"),
    "b": ("𝐛", "𝑏", "𝒃", "𝖻", "𝗯", "𝘣", "𝙗", "𝒷", "𝓫", "𝔟", "𝖇", "𝕓", "𝚋"),
    "c": ("𝐜", "𝑐", "𝒄", "𝖼", "𝗰", "𝘤", "𝙘", "𝒸", "𝓬", "𝔠", "𝖈", "𝕔", "𝚌"),
    "d": ("𝐝", "𝑑", "𝒅", "𝖽", "𝗱", "𝘥", "𝙙", "𝒹", "𝓭", "𝔡", "𝖉", "𝕕", "𝚍"),
    "e": ("𝐞", "𝑒", "𝒆", "𝖾", "𝗲", "𝘦", "𝙚", "ℯ", "𝓮", "𝔢", "𝖊", "𝕖", "𝚎"),
    "f": ("𝐟", "𝑓", "𝒇", "𝖿", "𝗳", "𝘧", "𝙛", "𝒻", "𝓯", "𝔣", "𝖋", "𝕗", "𝚏"),
    "g": ("𝐠", "𝑔", "𝒈", "𝗀", "𝗴", "𝘨", "𝙜", "ℊ", "𝓰", "𝔤", "𝖌", "𝕘", "𝚐"),
    "h": ("𝐡", "ℎ", "𝒉", "𝗁", "𝗵", "𝘩", "𝙝", "𝒽", "𝓱", "𝔥", "𝖍", "𝕙", "𝚑"),
    "i": ("𝐢", "𝑖", "𝒊", "𝗂", "𝗶", "𝘪", "𝙞", "𝒾", "𝓲", "𝔦", "𝖎", "𝕚", "𝚒"),
    "j": ("𝐣", "𝑗", "𝒋", "𝗃", "𝗷", "𝘫", "𝙟", "𝒿", "𝓳", "𝔧", "𝖏", "𝕛", "𝚓"),
    "k": ("𝐤", "𝑘", "𝒌", "𝗄", "𝗸", "𝘬", "𝙠", "𝓀", "𝓴", "𝔨", "𝖐", "𝕜", "𝚔"),
    "l": ("𝐥", "𝑙", "𝒍", "𝗅", "𝗹", "𝘭", "𝙡", "𝓁", "𝓵", "𝔩", "𝖑", "𝕝", "𝚕"),
    "m": ("𝐦", "𝑚", "𝒎", "𝗆", "𝗺", "𝘮", "𝙢", "𝓂", "𝓶", "𝔪", "𝖒", "𝕞", "𝚖"),
    "n": ("𝐧", "𝑛", "𝒏", "𝗇", "𝗻", "𝘯", "𝙣", "𝓃", "𝓷", "𝔫", "𝖓", "𝕟", "𝚗"),
    "o": ("𝐨", "𝑜", "𝒐", "𝗈", "𝗼", "𝘰", "𝙤", "ℴ", "𝓸", "𝔬", "𝖔", "𝕠", "𝚘"),
    "p": ("𝐩", "𝑝", "𝒑", "𝗉", "𝗽", "𝘱", "𝙥", "𝓅", "𝓹", "𝔭", "𝖕", "𝕡", "𝚙"),
    "q": ("𝐪", "𝑞", "𝒒", "𝗊", "𝗾", "𝘲", "𝙦", "𝓆", "𝓺", "𝔮", "𝖖", "𝕢", "𝚚"),
    "r": ("𝐫", "𝑟", "𝒓", "𝗋", "𝗿", "𝘳", "𝙧", "𝓇", "𝓻", "𝔯", "𝖗", "𝕣", "𝚛"),
    "s": ("𝐬", "𝑠", "𝒔", "𝗌", "𝘀", "𝘴", "𝙨", "𝓈", "𝓼", "𝔰", "𝖘", "𝕤", "𝚜"),
    "t": ("𝐭", "𝑡", "𝒕", "𝗍", "𝘁", "𝘵", "𝙩", "𝓉", "𝓽", "𝔱", "𝖙", "𝕥", "𝚝"),
    "u": ("𝐮", "𝑢", "𝒖", "𝗎", "𝘂", "𝘶", "𝙪", "𝓊", "𝓾", "𝔲", "𝖚", "𝕦", "𝚞"),
    "v": ("𝐯", "𝑣", "𝒗", "𝗏", "𝘃", "𝘷", "𝙫", "𝓋", "𝓿", "𝔳", "𝖛", "𝕧", "𝚟"),
    "w": ("𝐰", "𝑤", "𝒘", "𝗐", "𝘄", "𝘸", "𝙬", "𝓌", "𝔀", "𝔴", "𝖜", "𝕨", "𝚠"),
    "x": ("𝐱", "𝑥", "𝒙", "𝗑", "𝘅", "𝘹", "𝙭", "𝓍", "𝔁", "𝔵", "𝖝", "𝕩", "𝚡"),
    "y": ("𝐲", "𝑦", "𝒚", "𝗒", "𝘆", "𝘺", "𝙮", "𝓎", "𝔂", "𝔶", "𝖞", "𝕪", "𝚢"),
    "z": ("𝐳", "𝑧", "𝒛", "𝗓", "𝘇", "𝘻", "𝙯", "𝓏", "𝔃", "𝔷", "𝖟", "𝕫", "𝚣"),
    "A": ("𝐀", "𝐴", "𝑨", "𝖠", "𝗔", "𝘈", "𝘼", "𝒜", "𝓐", "𝔄", "𝕬", "𝔸", "𝙰"),
    "B": ("𝐁", "𝐵", "𝑩", "𝖡", "𝗕", "𝘉", "𝘽", "ℬ", "𝓑", "𝔅", "𝕭", "𝔹", "𝙱"),
    "C": ("𝐂", "𝐶", "𝑪", "𝖢", "𝗖", "𝘊", "𝘾", "𝒞", "𝓒", "ℭ", "𝕮", "ℂ", "𝙲"),
    "D": ("𝐃", "𝐷", "𝑫", "𝖣", "𝗗", "𝘋", "𝘿", "𝒟", "𝓓", "𝔇", "𝕯", "𝔻", "𝙳"),
    "E": ("𝐄", "𝐸", "𝑬", "𝖤", "𝗘", "𝘌", "𝙀", "ℰ", "𝓔", "𝔈", "𝕰", "𝔼", "𝙴"),
    "F": ("𝐅", "𝐹", "𝑭", "𝖥", "𝗙", "𝘍", "𝙁", "ℱ", "𝓕", "𝔉", "𝕱", "𝔽", "𝙵"),
    "G": ("𝐆", "𝐺", "𝑮", "𝖦", "𝗚", "𝘎", "𝙂", "𝒢", "𝓖", "𝔊", "𝕲", "𝔾", "𝙶"),
    "H": ("𝐇", "𝐻", "𝑯", "𝖧", "𝗛", "𝘏", "𝙃", "ℋ", "𝓗", "ℌ", "𝕳", "ℍ", "𝙷"),
    "I": ("𝐈", "𝐼", "𝑰", "𝖨", "𝗜", "𝘐", "𝙄", "ℐ", "𝓘", "ℑ", "𝕴", "𝕀", "𝙸"),
    "J": ("𝐉", "𝐽", "𝑱", "𝖩", "𝗝", "𝘑", "𝙅", "𝒥", "𝓙", "𝔍", "𝕵", "𝕁", "𝙹"),
    "K": ("𝐊", "𝐾", "𝑲", "𝖪", "𝗞", "𝘒", "𝙆", "𝒦", "𝓚", "𝔎", "𝕶", "𝕂", "𝙺"),
    "L": ("𝐋", "𝐿", "𝑳", "𝖫", "𝗟", "𝘓", "𝙇", "ℒ", "𝓛", "𝔏", "𝕷", "𝕃", "𝙻"),
    "M": ("𝐌", "𝑀", "𝑴", "𝖬", "𝗠", "𝘔", "𝙈", "ℳ", "𝓜", "𝔐", "𝕸", "𝕄", "𝙼"),
    "N": ("𝐍", "𝑁", "𝑵", "𝖭", "𝗡", "𝘕", "𝙉", "𝒩", "𝓝", "𝔑", "𝕹", "ℕ", "𝙽"),
    "O": ("𝐎", "𝑂", "𝑶", "𝖮", "𝗢", "𝘖", "𝙊", "𝒪", "𝓞", "𝔒", "𝕺", "𝕆", "𝙾"),
    "P": ("𝐏", "𝑃", "𝑷", "𝖯", "𝗣", "𝘗", "𝙋", "𝒫", "𝓟", "𝔓", "𝕻", "ℙ", "𝙿"),
    "Q": ("𝐐", "𝑄", "𝑸", "𝖰", "𝗤", "𝘘", "𝙌", "𝒬", "𝓠", "𝔔", "𝕼", "ℚ", "𝚀"),
    "R": ("𝐑", "𝑅", "𝑹", "𝖱", "𝗥", "𝘙", "𝙍", "ℛ", "𝓡", "ℜ", "𝕽", "ℝ", "𝚁"),
    "S": ("𝐒", "𝑆", "𝑺", "𝖲", "𝗦", "𝘚", "𝙎", "𝒮", "𝓢", "𝔖", "𝕾", "𝕊", "𝚂"),
    "T": ("𝐓", "𝑇", "𝑻", "𝖳", "𝗧", "𝘛", "𝙏", "𝒯", "𝓣", "𝔗", "𝕿", "𝕋", "𝚃"),
    "U": ("𝐔", "𝑈", "𝑼", "𝖴", "𝗨", "𝘜", "𝙐", "𝒰", "𝓤", "𝔘", "𝖀", "𝕌", "𝚄"),
    "V": ("𝐕", "𝑉", "𝑽", "𝖵", "𝗩", "𝘝", "𝙑", "𝒱", "𝓥", "𝔙", "𝖁", "𝕍", "𝚅"),
    "W": ("𝐖", "𝑊", "𝑾", "𝖶", "𝗪", "𝘞", "𝙒", "𝒲", "𝓦", "𝔚", "𝖂", "𝕎", "𝚆"),
    "X": ("𝐗", "𝑋", "𝑿", "𝖷", "𝗫", "𝘟", "𝙓", "𝒳", "𝓧", "𝔛", "𝖃", "𝕏", "𝚇"),
    "Y": ("𝐘", "𝑌", "𝒀", "𝖸", "𝗬", "𝘠", "𝙔", "𝒴", "𝓨", "𝔜", "𝖄", "𝕐", "𝚈"),
    "Z": ("𝐙", "𝑍", "𝒁", "𝖹", "𝗭", "𝘡", "𝙕", "𝒵", "𝓩", "ℨ", "𝖅", "ℤ", "𝚉")
]

extension Style {
    public func apply<T>(to string: T) -> String where T: StringProtocol {
        return String(string.map { variant(for: $0) ?? $0 })
    }
    
    public func variant(for character: Character) -> Character? {
        guard let variants = characterVariants[character] else {
            return nil
        }
        
        switch self {
        case .none:
            return character
        case .bold:
            return variants.bold
        case .italic:
            return variants.italic
        case .boldItalic:
            return variants.boldItalic
        case .sansSerif(bold: false, italic: false):
            return variants.sansSerif
        case .sansSerif(bold: true, italic: false):
            return variants.sansSerifBold
        case .sansSerif(bold: false, italic: true):
            return variants.sansSerifItalic
        case .sansSerif(bold: true, italic: true):
            return variants.sansSerifBoldItalic
        case .script(bold: false):
            return variants.script
        case .script(bold: true):
            return variants.scriptBold
        case .fraktur(bold: false):
            return variants.fraktur
        case .fraktur(bold: true):
            return variants.frakturBold
        case .doubleStruck:
            return variants.doubleStruck
        case .monospace:
            return variants.monospace
        }
    }
}


struct StyledString {
    private var components: [(String, Style)] = []
    
    public init() {}
    
    init(_ value: String, style: Style = .none) {
        self.append(value, style: style)
    }
    
    mutating func append(_ string: String, style: Style) {
        self.components.append((string, style))
    }
}

extension StyledString: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.init(value)
    }
    
//
//    init(extendedGraphemeClusterLiteral value: String) {
//        self.init(stringLiteral: value)
//    }
//
//    init(unicodeScalarLiteral value: String) {
//        self.init(stringLiteral: value)
//    }
}

extension StyledString: ExpressibleByStringInterpolation {
    init(stringInterpolation: StringInterpolation) {
        self.components = stringInterpolation.styledString.components
    }
    
    struct StringInterpolation: StringInterpolationProtocol {
        fileprivate var styledString: StyledString
        
        init(literalCapacity: Int, interpolationCount: Int) {
            styledString = StyledString()
        }
        
        mutating func appendLiteral(_ literal: String) {
            styledString.append(literal, style: .none)
        }
        
        mutating func appendInterpolation<T>(_ value: T, style: Style) {
            styledString.append(String(describing: value), style: style)
        }
    }
}

extension StyledString: CustomStringConvertible {
    public var description: String {
        return components.reduce(into: "", { (result, component) in
            let (string, style) = component
            result.append(style.apply(to: string))
        })
    }
}


// ExpressibleByStringInterpolation
example(of: "ExpressibleByStringInterpolation") {
    let name = "Johnny"
    let styled: StyledString = """
    Hello, \(name, style: .fraktur(bold: true))!
    """
    print(styled)
}

example(of: "ExpressibleByStringInterpolation 1") {
    let approximate = "Hello, \(name)!"
    var interpolation = StyledString.StringInterpolation(literalCapacity: approximate.count, interpolationCount: 1)
    interpolation.appendLiteral("Hello, ")
    interpolation.appendInterpolation(name, style: .fraktur(bold: true))
    
    let styled = StyledString(stringInterpolation: interpolation)
    print(styled)
}

// Working with Foudation String APIs

// Localized String Operations

example(of: "Collation and Comparison") {
    let files: [String] = [
        "File 3.txt",
        "File 7.txt",
        "File 36.txt"
    ]
    
    let order: ComparisonResult = .orderedAscending
    
    files.sorted { lhs, rhs in
        lhs.compare(rhs) == order
    }
    
    files.sorted { lhs, rhs in
        lhs.localizedStandardCompare(rhs) ==  order
    }
}

example(of: "Collation and Comparison 1") {
    let cities: [String] = [
        "Albuquerque",
        "Ålesund",
        "Östersund",
        "Reno",
        "Tallahassee"
    ]
    
    let 🇺🇸 = Locale(identifier: "en_US")
    let 🇸🇪 = Locale(identifier: "sv_SE")
    
    let order: ComparisonResult = .orderedAscending
    
    cities.sorted { lhs, rhs in
        lhs.compare(rhs, options: [], range: nil, locale: 🇺🇸) == order
    }
    
    cities.sorted { lhs, rhs in
        lhs.compare(rhs, options: [], range: nil, locale: 🇸🇪) == order
    }
}

example(of: "Searching") {
    "Éclair".contains("E") // false
    "Éclair".localizedStandardContains("E") // true
}

// Case Mapping
example(of: "Case Mapping") {
    let 🇹🇷 = Locale(identifier: "tr_TR") // Turkey
    
    "İ".lowercased(with: 🇹🇷) // "i"
    "İ".lowercased() // "i̇"
    
    let 🇱🇹 = Locale(identifier: "lt_LT") // Lithuania
    
    "i̇̀".uppercased(with: 🇱🇹) // Ì
    "i̇̀".uppercased() // İ̀
}

// Normalizing Strings
example(of: "Normalizing Strings") {
    let string = "ümlaut"
    
    let nfc = string.precomposedStringWithCanonicalMapping
    nfc.unicodeScalars.first
    
    let nfd = string.decomposedStringWithCanonicalMapping
    nfd.unicodeScalars.first
}

// Conversion Between String Encodings
example(of: "Conversion") {
    "Hello, Macintosh!".data(using: .macOSRoman)
    
    "Avión ✈️".canBeConverted(to: .ascii)
    "Avión ✈️".data(using: .ascii)
    if let data = "Avión ✈️".data(using: .ascii, allowLossyConversion: true) {
        String(data: data, encoding: .ascii)
    }
    
    "Airplane".fastestEncoding //ASCII
    "飛行機".smallestEncoding
}

example(of: "Transforming Strings") {
    "Avión".applyingTransform(.stripDiacritics, reverse: false)
    
    "©".applyingTransform(.toXMLHex, reverse: false)
    
    "🛂".applyingTransform(.toUnicodeName, reverse: false)
    
    "マット".applyingTransform(.fullwidthToHalfwidth, reverse: false)
    
    """
    안전 벨트를 휘게하십시오
    """.applyingTransform(.toLatin, reverse: false)
}

// Binary-to-Text Encoding
example(of: "Base2") {
    let byte: UInt8 = 0xF0
    let encodedString = String(byte, radix: 2)
    print(encodedString)
    
    let decodedByte = UInt8(encodedString, radix:2)!
    print(decodedByte)
}

example(of: "Base16") {
    let byte: UInt8 = 0xF0
    let encodedString = String(byte, radix: 16, uppercase: true)
    print(encodedString)
    
    let decodedByte = UInt8(encodedString, radix:16)!
    print(decodedByte)
    
    let data = Data([0xC0, 0xFF, 0xEE])
    let result = data.map { String($0, radix: 16, uppercase: true)} // C0 FF EE
    print(result)
}

example(of: "Base64") {
    let string = "Hello!"
    
    let data = string.data(using: .utf8)!
    let encodedString = data.base64EncodedString()
    
    let decodedData = Data(base64Encoded: encodedString)!
    let decodedString = String(data: decodedData, encoding: .utf8)
    print(decodedString!)
}


// Parsing Data From Text

// Scanner

extension Scanner {
    public struct Error: Swift.Error {
        let location: Int
        
        var localizedDescription: String {
            return "scan failure at location: \(location)"
        }
    }
    
    @discardableResult
    public func scan(_ string: String) throws -> String {
        var result: NSString?
        guard scanString(string, into: &result),
            case let string? = (result as String?)
            else {
                throw Error(location: self.scanLocation)
        }
        
        return string
    }
    
    public func scan(_ characters: CharacterSet) throws -> String {
        var result: NSString?
        guard scanCharacters(from: characters, into: &result),
            case let string? = (result as String?)
            else {
                throw Error(location: self.scanLocation)
        }
        
        return string
    }
    
    public func scan(upTo string: String) throws -> String {
        var result: NSString?
        guard scanUpTo(string, into: &result),
            case let string? = (result as String?)
            else {
                throw Error(location: self.scanLocation)
        }
        
        return string
    }
    
    public func scan(upTo characters: CharacterSet) throws -> String {
        var result: NSString?
        guard scanUpToCharacters(from: characters, into: &result),
            case let string? = (result as String?)
            else {
                throw Error(location: self.scanLocation)
        }
        
        return string
    }
    
    public func scan<T>(_ type: T.Type) throws -> T where T: BinaryInteger {
        switch type {
        case is Int32.Type:
            return try scan(Scanner.scanInt32) as! T
        case is Int64.Type:
            return try scan(Scanner.scanInt64) as! T
        case is UInt64.Type:
            return try scan(Scanner.scanUnsignedLongLong) as! T
        default:
            guard let value = T(exactly: try scan(Scanner.scanInt)) else {
                throw Error(location: self.scanLocation)
            }
            
            return value
        }
    }
    
    public func scan(_ type: Float.Type) throws -> Float {
        return try scan(Scanner.scanFloat)
    }
    
    public func scan(_ type: Double.Type) throws -> Double {
        return try scan(Scanner.scanDouble)
    }
    
    public func scan(_ type: Decimal.Type) throws -> Decimal {
        return try scan(Scanner.scanDecimal)
    }
    
    public func scan<T>(hexadecimal type: T.Type) throws -> T where T: BinaryInteger {
        switch type {
        case is Int32.Type:
            return try scan(Scanner.scanHexInt32) as! T
        case is Int64.Type:
            return try scan(Scanner.scanHexInt64) as! T
        default:
            guard let value = T(exactly: try scan(Scanner.scanHexInt64)) else {
                throw Error(location: self.scanLocation)
            }
            
            return value
        }
    }
    
    public func scan(hexadecimal type: Float.Type) throws -> Float {
        return try scan(Scanner.scanHexFloat)
    }
    
    public func scan(hexadecimal type: Double.Type) throws -> Double {
        return try scan(Scanner.scanHexDouble)
    }
    
    private typealias Scan<T> = (Scanner) -> ((UnsafeMutablePointer<T>?) -> Bool)
    
    private func scan<T>(_ partial: Scan<T>) throws -> T {
        let pointer = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.stride)
        defer { pointer.deallocate() }
        
        guard partial(self)(pointer) else {
            throw Error(location: self.scanLocation)
        }
        
        return pointer.pointee
    }
}


extension CharacterSet {
    /// Returns a character set containing the characters in Unicode General Category Lu and Lt the category of Decimal Numbers.
    public static var uppercaseLettersAndDecimalDigits: CharacterSet {
        return CharacterSet.uppercaseLetters.union(.decimalDigits)
    }
}


example(of: "") {
}
let string = """
ZCZC NRA062 270930
GG KHIOYYYX
311521 KTTDZTZX

AIR SWIFT FLIGHT 42
CANCELED

NNNN
"""

let scanner = Scanner(string: string)
scanner.caseSensitive = true
scanner.charactersToBeSkipped = .whitespacesAndNewlines

try scanner.scan("ZCZC")
let transmission = try scanner.scan(.uppercaseLettersAndDecimalDigits)
let additionalServices = try scanner.scan(.decimalDigits)
let priority = try scanner.scan(.uppercaseLetters)
let destination = try scanner.scan(.uppercaseLetters)
let time = try scanner.scan(.decimalDigits)
let origin = try scanner.scan(.uppercaseLetters)
let text = try scanner.scan(upTo: "NNNN")



// NSRegularExpression


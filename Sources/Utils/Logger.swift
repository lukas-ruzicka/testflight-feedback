import Foundation

public enum LoggerColor: Int {

    case black = 30
    case red = 31
    case green = 32
    case yellow = 33
    case blue = 34
    case magenta = 35
    case cyan = 36
    case white = 37
    case `default` = 0
}

public struct LoggerText {

    let text: String
    var color: LoggerColor = .default
    var bold = false

    var printText: String {
        "\u{001B}[\(bold ? 1 : 0);\(color.rawValue)m\(text)"
    }

    public init(text: String, color: LoggerColor = .default, bold: Bool = false) {
        self.text = text
        self.color = color
        self.bold = bold
    }
}

public func print(_ text: String, color: LoggerColor, bold: Bool = false) {
    print(LoggerText(text: text, color: color, bold: bold).printText)
}

public func print(_ texts: [LoggerText]) {
    print(texts.reduce(into: "", { $0 += $1.printText }))
}

public func printFailedJob(_ error: Error) {
    print([
        .init(text: "Job failed with following error: ", color: .red, bold: true),
        .init(text: error.localizedDescription, color: .red)
    ])
    if let recoverySuggestion = (error as NSError).localizedRecoverySuggestion {
        print(recoverySuggestion, color: .yellow, bold: true)
    }
}

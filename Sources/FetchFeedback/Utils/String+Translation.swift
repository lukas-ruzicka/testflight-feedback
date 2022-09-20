import NaturalLanguage

extension String {

    func getTranslationLinkIfNotEnglish() -> String? {
        let sanitizedText = self.replacingOccurrences(of: "\n", with: " ")
        if let language = NLLanguageRecognizer.dominantLanguage(for: sanitizedText),
            language != .english,
            let encodedText = sanitizedText.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
            return "[Translation](https://www.deepl.com/translator#\(language.rawValue)/en/\(encodedText))"
        }
        return nil
    }
}

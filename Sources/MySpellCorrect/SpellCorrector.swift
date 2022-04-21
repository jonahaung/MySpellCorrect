//
//  Syllables.swift
//  UltimateChords
//
//  Created by Aung Ko Min on 19/4/22.
//

import UIKit

public struct SpellCorrector {
    
    static let myanamrWords: [String] = {
        var items = [String]()
        var resourceUrl = Bundle.module.resourceURL
        resourceUrl?.appendPathComponent("syllables")
        resourceUrl?.appendPathExtension("txt")
        
        if let url = resourceUrl {
            do {
                let string = try String(contentsOf: url, encoding: .utf8)
                items = string.components(separatedBy: .whitespacesAndNewlines)
            } catch {
                print(error)
            }
        }
        return items
    }()
    
    public static func correctedMyanmarText(_ string: String) -> String {
        var correctedLines = [String]()
        string.lines().forEach { line in
            var words = [String]()
            line.components(separatedBy: " ").forEach { word in
                var correctCharacters = [String]()
                let characters = Resegment.myanmar(word)
                characters.forEach { character in
                    if myanamrWords.contains(character) {
                        correctCharacters.append(character)
                    }
                }
                words.append(correctCharacters.joined())
            }
            correctedLines.append(words.joined(separator: " "))
        }
        return correctedLines.joined(separator: "\n")
    }
    
    public static func correctEnglishText(_ string: String) -> String {
        let checker = UITextChecker()
        func isReal(word: String) -> Bool {
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: word.nsRange(), startingAt: 0, wrap: false, language: "en")
            return misspelledRange.location == NSNotFound
        }
        
        var correctedLines = [String]()
        string.lines().forEach { line in
            var words = [String]()
            line.components(separatedBy: " ").forEach { word in
                if isReal(word: word) {
                    words.append(word)
                }
            }
            correctedLines.append(words.joined(separator: " "))
        }
        return correctedLines.joined(separator: "\n")
    }
}
private class BundleFinder {}

extension Foundation.Bundle {
    /// Returns the resource bundle associated with the current Swift module.
    static var module: Bundle = {
        let bundleName = "SwiftyChords_SwiftyChords"

        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,

            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: BundleFinder.self).resourceURL,

            // For command-line tools.
            Bundle.main.bundleURL,
        ]

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named SwiftyChords_SwiftyChords")
    }()
}


//
//  +String.swift
//  MyanmarSpellCorrector
//
//  Created by Aung Ko Min on 21/4/22.
//

import Foundation

extension String {
    func lines() -> [String] {
        var result = [String]()
        enumerateLines { line, _ in
            result.append(line)
        }
        return result
    }
    
    func nsRange() -> NSRange {
        NSRange.init(self.startIndex..<self.endIndex, in: self)
    }
}

extension NSRegularExpression {

    func stringByReplacingMatches(in string: String, withTemplate template: String) -> String {
        return self.stringByReplacingMatches(in: string, options: [], range: NSRange.init(string.startIndex..<string.endIndex, in: string), withTemplate: template)
    }
    
}

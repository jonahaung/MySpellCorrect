//
//  Resegmanent.swift
//  UltimateChords
//
//  Created by Aung Ko Min on 19/4/22.
//

import Foundation

public struct Resegment {
    
    static let myanmarPattern: NSRegularExpression = {
        do {
            return try NSRegularExpression(pattern: "(?:(?<!္)([က-ဪဿ၊-၏]|[၀-၉]+|[^က-၏]+)(?![ှျ]?[့္်]))", options: [.caseInsensitive])
        }catch {
            fatalError()
        }
    }()
    
    public static func myanmar(_ line : String) -> [String] {
        
        let outputs  =  myanmarPattern.stringByReplacingMatches(in: line, withTemplate: "𝕊$1")
        let ouputArray = outputs.components(separatedBy: "𝕊")
        return ouputArray
    }

}

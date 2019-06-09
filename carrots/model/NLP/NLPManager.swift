//
//  NLPManager.swift
//  carrots
//
//  Created by Paweł Czerwiński on 09/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit
import CoreML
import Foundation



class NLPManager {
    
    func enumerate(scheme:NSLinguisticTagScheme, label: UILabel) -> [String]?{
        var keywords = [String]()
        var tokens = [String]()
        var lemmas = [String]()
        
        let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]
        
        let tagger = NSLinguisticTagger(tagSchemes: [scheme], options: 0)
        tagger.string = label.text
        
        tagger.enumerateTags(in: NSRange(location: 3, length: 12), unit: .word, scheme: scheme, options: []) {
            tag, tokenRange, _ in
            
            switch(scheme){
            case NSLinguisticTagScheme.lemma:
                if let lemma = tag?.rawValue {
                    lemmas.append(lemma)
                }
                break
            case NSLinguisticTagScheme.language:
                print("Dominant language: \(tagger.dominantLanguage ?? "Undetermined ")")
                break
            case NSLinguisticTagScheme.nameType:
                if let tag = tag, tags.contains(tag) {
                    let name = (label.text! as NSString).substring(with: tokenRange)
                    print("entity: \(name)")
                    keywords.append(name)
                }
                break
            case NSLinguisticTagScheme.lexicalClass:
                break
            case NSLinguisticTagScheme.tokenType:
                if let tagVal = tag?.rawValue {
                    tokens.append(tagVal.lowercased())
                }
                break
            default:
                break
            }
            
        }
        if (scheme == .nameType){
            let keywordAttrString = NSMutableAttributedString(string: tagger.string!, attributes: nil)
            
            for name in keywords{
                
                
                if let indices = self.indicies {
                    for i in indices{
                        let range = NSRange(i..<name.count+i)
                        keywordAttrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
                    }
                    label.attributedText = keywordAttrString
                }
            }
            return keywords
        }else if (scheme == .lemma){
            print("lemmas \(lemmas)")
            return lemmas
        }else if (scheme == .tokenType){
            print("tokens \(tokens)")
            return tokens
        }
        return nil
    }
    
    
    let indicies: [Int]? = [1, 23, 312, 21]
}

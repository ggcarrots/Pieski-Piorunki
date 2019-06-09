//
//  NewsCategories.swift
//  carrots
//
//  Created by Tomasz Lizer on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation

enum NewsCategory: CaseIterable, Hashable {
    case mathematics
    case technology
    case art
    case politology
    case philosophy
    
    var labelText: String {
        switch self {
        case .mathematics:
            return "Mathematics"
        case .technology:
            return "Technology"
        case .art:
            return "Art"
        case .politology:
            return "Geopolitics"
        case .philosophy:
            return "Philosophy"
        }
    }
}

//
//  Tamagochi.swift
//  carrots
//
//  Created by Tomasz Lizer on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit

enum Tamagochi {
    case notMovingEgg
    case egg
    case babyDinosaur
    case grownDino
    
    var image: UIImage? {
        switch self {
        case .notMovingEgg:
            return UIImage(named: "tamagochi_level1")
        case .egg:
            return UIImage(named: "tamagochi_level1")
        case .babyDinosaur:
            return UIImage(named: "tamagochi_level2")
        case .grownDino:
            return UIImage(named: "tamagochi_level3")
        }
    }
    
    var formLevel: TamagochLevel {
        switch self {
        case .notMovingEgg:
            return .level0
        case .egg:
            return .level1
        case .babyDinosaur:
            return .level2
        case .grownDino:
            return .level3
        }
    }
    
}

//
//  TamagochLevel.swift
//  carrots
//
//  Created by Tomasz Lizer on 09/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation

enum TamagochLevel: Int {
    case level0
    case level1
    case level2
    case level3
    
    static func level(for points: Double) -> TamagochLevel {
        switch points {
        case -Double.greatestFiniteMagnitude..<1.5:
            print("zero")
            return .level0
        case 1.5..<3.0:
            print("jeden")
            return .level1
        case 3.0..<4.5:
            print("dwa")
            return .level2
        default:
            print("trzy")
            return .level3
        }
    }
    
}

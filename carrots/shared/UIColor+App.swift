//
//  UIColor+App.swift
//  carrots
//
//  Created by Paweł Czerwiński on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


extension UIColor {
    enum app {
        static var background: UIColor { return UIColor(named: "background")! }
        static var light_background: UIColor {
            return UIColor(named: "light_background")!
        }
        static var czcionka_tytuly: UIColor {
            return UIColor(named: "czcionka_tytuly")!
        }
        static var czcionka: UIColor { return UIColor(named: "czcionka")! }
        static var tabBar_deselectedIcon: UIColor {
            return UIColor(named: "tabBar_deselectedIcon")!
        }
        static var tabBar_selectedIcon: UIColor {
            return UIColor(named: "tabBar_selectedIcon")!
        }
        static var tabBar: UIColor {
            return UIColor(named: "tabBar")!
        }
        static var white: UIColor {
            return UIColor.white
        }
    }
}

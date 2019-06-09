//
//  UIImageView+animations.swift
//  carrots
//
//  Created by Tomasz Lizer on 09/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func crossFade(duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        self.layer.add(transition, forKey: "imageFade")
    }
    
}

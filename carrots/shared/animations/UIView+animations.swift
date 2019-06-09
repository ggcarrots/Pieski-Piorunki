//
//  UIView+animations.swift
//  carrots
//
//  Created by Tomasz Lizer on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit

extension UIView {
    
    func shakeTamagochi(duration: CFTimeInterval = 0.12, shakeCount: Float = 3.0) {
        let timingFunc = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation")
        let rotAngle = Double.pi / 10
        rotation.timingFunction = timingFunc
        rotation.duration = duration
        rotation.repeatCount = 3
        rotation.values = [0.0, -rotAngle, 0.0, rotAngle, 0.0]
        
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        let translationX = Double(6.0)
        translation.timingFunction = timingFunc
        translation.duration = duration
        translation.repeatCount = 3
        translation.values = [0.0, -translationX, 0.0, translationX, 0.0]
        
        self.layer.add(rotation, forKey: "rotation")
        self.layer.add(translation, forKey: "translation")
    }
    
    func animate(tranform from: (CGFloat, CGFloat), to: (CGFloat, CGFloat),
                 duration: CFTimeInterval = 0.5) {
        let from = CGAffineTransform.init(translationX: from.0, y: from.1)
        let to = CGAffineTransform.init(translationX: to.0, y: to.1)
        let translation = CAKeyframeAnimation(keyPath: "transform.translation")
        let translationX = Double(6.0)
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.duration = duration
        translation.values = [NSValue(cgAffineTransform: from), NSValue(cgAffineTransform: to)]
        
        self.layer.add(translation, forKey: "translation")
    }
    
}

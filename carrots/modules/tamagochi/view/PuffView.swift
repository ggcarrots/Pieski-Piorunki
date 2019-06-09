//
//  PuffView.swift
//  carrots
//
//  Created by Tomasz Lizer on 09/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit
import EasyPeasy

class PuffView: BoroView {
    
    private var puffs: [UIImageView] = []
    private var puffsCenters: [(x: CenterX, y: CenterY)] = []
    
    override func initialize() {
        let pi = CGFloat.pi
        puffs = [-3.0, -2.0, 0.0, 1.0].map { $0 * pi/4.0 }
            .map { getPuffImgView(for: $0) }
        puffs.forEach {
            let center = (x: CenterX(), y: CenterY())
            puffsCenters.append(center)
            $0.easy.layout(Size(50), center.x, center.y)
        }
    }
    
    private func getPuffImgView(for angle: CGFloat, with frame: CGRect = CGRect.init(x: 0, y: 0, width: 50, height: 50)) -> UIImageView {
        let imgView = UIImageView(image: UIImage(named: "puff"))
        imgView.frame = frame
        imgView.transform = CGAffineTransform().rotated(by: angle)
        return imgView
    }
    
}



//
//  AppButton.swift
//  carrots
//
//  Created by Tomasz Lizer on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit
import EasyPeasy

class AppButton: BoroControll {
    
    let label: UILabel = {
        let lbl: UILabel = UILabel()
        lbl.textColor = UIColor.white
        lbl.textAlignment = NSTextAlignment.center
        return lbl
    }()
    
    override func initialize() {
        addSubview(label)
        label.easy.layout(Edges(Insets.init(top: 12, left: 20, bottom: 12, right: 20)))
        layer.cornerRadius = 15
    }
    
    func display(title: String?, color: UIColor = UIColor.app.czcionka) {
        label.text = title
        backgroundColor = color
    }
}

//
//  LaunchViewHeaderView.swift
//  carrots
//
//  Created by Tomasz Lizer on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit
import EasyPeasy

class LaunchViewHeaderView: BoroView {

    private let label: UILabel = {
        let lbl: UILabel = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.textColor = UIColor.app.czcionka_tytuly
        lbl.textAlignment = NSTextAlignment.center
        return lbl
    }()
    
    override func initialize() {
        addSubview(label)
        label.easy.layout(
            Top(12), Bottom(12),
            Left(12), Right(12)
        )
        backgroundColor = UIColor.app.background
    }
    
    func display(header: String?) {
        label.text = header
    }
    
}

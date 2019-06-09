//
//  CategoryTableViewHeaderView.swift
//  carrots
//
//  Created by Tomasz Lizer on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit
import EasyPeasy

class CategoryTableViewHeaderView: BoroTableHeaderView {
    
    private let label: UILabel = {
        let lbl: UILabel = UILabel()
        lbl.textAlignment = NSTextAlignment.center
        lbl.textColor = UIColor.app.czcionka_tytuly
        lbl.font = UIFont.systemFont(ofSize: 24)
        return lbl
    }()

    override func initialize() {
        contentView.addSubview(label)
        label.easy.layout(Top(12), Bottom(12),
                          Left(12), Right(12).with(.medium))
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor.app.background
    }
    
    func display(title: String?) {
        label.text = title
    }
    
}

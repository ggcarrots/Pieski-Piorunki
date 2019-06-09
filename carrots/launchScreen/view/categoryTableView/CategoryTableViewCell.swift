//
//  CategoryTableViewCell.swift
//  carrots
//
//  Created by Tomasz Lizer on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit
import EasyPeasy

class CategoryTableViewCell: BoroCell {
    
    private let borderView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    private let label: UILabel = {
        let lbl: UILabel = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = NSTextAlignment.center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func initialize() {
        contentView.addSubview(borderView)
        borderView.addSubview(label)
        borderView.easy.layout(Top(8), Bottom(8),
                               Left(30), Right(30))
        label.easy.layout(Top(12), Bottom(12),
                          Left(12), Right(12))
        selectionStyle = .none
        backgroundColor = UIColor.app.background
    }
    
    func display(title: String?) {
        label.text = title
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        borderView.backgroundColor = selected ?
            UIColor.app.tabBar_selectedIcon :
            UIColor.app.tabBar_deselectedIcon
        label.textColor = selected ?
            UIColor.app.czcionka :
            UIColor.app.white
    }
    
    private func setColors(selected: Bool) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderView.layer.cornerRadius = (contentView.bounds.height - 16) / 2
    }
    
}

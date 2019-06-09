//
//  CategoryView.swift
//  carrots
//
//  Created by Paweł Czerwiński on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


private let insets: UIEdgeInsets = UIEdgeInsets(
    top: CGFloat(12.0), left: CGFloat(12.0),
    bottom: CGFloat(12.0), right: CGFloat(12.0)
)


extension UIEdgeInsets {
    var boro_width: CGFloat { return left + right }
    var boro_height: CGFloat { return top + bottom }
}


class CategoryView: BoroView {
    let lbl: UILabel = UILabel()
    
    
    var preferredMaxLayoutWidth: CGFloat = CGFloat(0.0) {
        didSet {
            guard preferredMaxLayoutWidth != oldValue else {
                return
            }
            lbl.preferredMaxLayoutWidth = lblW
            invalidateIntrinsicContentSize()
        }
    }
    
    private var lblW: CGFloat {
        return preferredMaxLayoutWidth - insets.boro_width
    }
    
    
    override func initialize() {
        super.initialize()
        addSubview(lbl)
        lbl.textAlignment = NSTextAlignment.center
        lbl.preferredMaxLayoutWidth = lblW
        
        backgroundColor = UIColor.app.background
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        preferredMaxLayoutWidth = bounds.width
        
        lbl.frame = bounds.inset(by: insets)
    }
    
    func display(category: NewsCategory) {
        lbl.text = category.labelText
    }
    
    
    override var intrinsicContentSize: CGSize {
        let lblS: CGSize = lbl.intrinsicContentSize
        return CGSize(
            width: lblS.width + insets.boro_width,
            height: lblS.height + insets.boro_height
        )
    }
}

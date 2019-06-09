//
//  QuestionCell.swift
//  carrots
//
//  Created by Paweł Czerwiński on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit


class QuestionCell: BoroCell {
    @IBOutlet private weak var textLbl: UILabel!
    
    @IBOutlet private weak var categoryView: CategoryView!
    
    override func initialize() {
        super.initialize()
    }
    
    func display(
        questionText text: String?,
        category: NewsCategory
    ) {
        textLbl?.text = text
        categoryView?.display(category: category)
    }
}

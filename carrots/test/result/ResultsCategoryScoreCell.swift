//
//  ResultsCategoryScoreCell.swift
//  carrots
//
//  Created by Paweł Czerwiński on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


class ResultsCategoryScoreCell: BoroCell {
    @IBOutlet private weak var categoryView: CategoryView!
    @IBOutlet private weak var scoreLbl: UILabel!
    
    
    func display(category: NewsCategory, score: Int, max: Int) {
        categoryView.display(category: category)
        scoreLbl.text = "\(score)/\(max)"
    }
}

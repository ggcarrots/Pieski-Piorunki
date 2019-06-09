//
//  AnswerCell.swift
//  carrots
//
//  Created by Paweł Czerwiński on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit


class AnswerCell: BoroCell {
    @IBOutlet private weak var textLbl: UILabel!
    
    @IBOutlet private weak var selectedImg: UIImageView!
    @IBOutlet private weak var deselectedImg: UIImageView!
    
    override func initialize() {
        super.initialize()
        
        selectionStyle = .none
    }
    
    func display(answerText text: String?) {
        textLbl.text = text
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedImg.isHidden = !selected
        deselectedImg.isHidden = selected
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    }
}

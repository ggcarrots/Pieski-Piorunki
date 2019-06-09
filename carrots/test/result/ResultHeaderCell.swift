//
//  ResultHeaderCell.swift
//  carrots
//
//  Created by Paweł Czerwiński on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


class ResultHeaderCell: BoroCell {
    @IBOutlet private weak var scoreLbl: UILabel!
    @IBOutlet private weak var statusLbl: UILabel!
    
    
    
    func display(score: Int, max: Int, status: String) {
        scoreLbl.text = "\(score)/\(max)"
        statusLbl.text = status
    }
    
}

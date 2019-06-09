//
//  InfoViewController.swift
//  carrots
//
//  Created by Paweł Czerwiński on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit


class InfoViewController: UIViewController {
    @IBOutlet private weak var infoView: InfoView! {
        didSet {
            infoView?.info = info
        }
    }
    
    
    
    
    var info: Info? = Info.i2 {
        didSet {
            print(info?.title)
            infoView?.info = info
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Article"
    }
    
}

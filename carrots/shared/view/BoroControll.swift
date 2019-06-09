//
//  BoroControll.swift
//  carrots
//
//  Created by Tomasz Lizer on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit

class Hmm: UIControl {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class BoroControll: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    var touchAlpha: CGFloat = 0.8
    var disabledAlpha: CGFloat = 0.8
    
    /// When set to false, button gets set its alpha to disabledAlpha
    override var isUserInteractionEnabled: Bool {
        didSet {
            alpha = isUserInteractionEnabled ? 1.0 : disabledAlpha
        }
    }
    
    // called with every init
    func initialize() {}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        alpha = touchAlpha
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        alpha = 1.0
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        alpha = 0.8
    }
    
}

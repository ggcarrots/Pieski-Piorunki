//
//  PetView.swift
//  carrots
//
//  Created by Tomasz Lizer on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit
import EasyPeasy

protocol PetViewDelegate: class {
    func petView(finished animation: PetAnimation)
    func petView(tappedPet view: PetView)
}

class PetView: BoroView {
    
    weak var delegate: PetViewDelegate?
    
    private let petImgView: UIImageView = {
        let imgView: UIImageView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    var tamagochi: Tamagochi? {
        didSet { petImgView.image = tamagochi?.image }
    }
    
    override func initialize() {
        addSubview(petImgView)
        petImgView.easy.layout(Edges())
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tamagochiTapped))
        petImgView.addGestureRecognizer(tap)
    }
    
    func start(_ animation: PetAnimation) {
        print("start")
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            print("finished")
            self.delegate?.petView(finished: animation)
        }
        switch animation {
        case .shakePet:
            petImgView.shakeTamagochi()
        case .puff(let tamagochi):
            self.tamagochi = tamagochi
            petImgView.crossFade()
        case .evolve(let pet):
            petImgView.shakeTamagochi()
            self.tamagochi = pet
            petImgView.crossFade()
        }
        CATransaction.commit()
    }
    
    @objc private func tamagochiTapped() {
        delegate?.petView(tappedPet: self)
    }
    
}

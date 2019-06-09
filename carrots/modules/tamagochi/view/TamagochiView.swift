//
//  TamagochiView.swift
//  carrots
//
//  Created by Tomasz Lizer on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit
import EasyPeasy

protocol TamagochiViewDelegate: class {
    func tamagochiView(finished animation: PetAnimation)
    func tamagochiView(tappedPet view: TamagochiView)
    func tamagochiView(tappedEvolve view: TamagochiView)
}

class TamagochiView: BoroView, PetViewDelegate {
    
    weak var delegate: TamagochiViewDelegate?
    
    private let petView: PetView = PetView()
    private let evolveButton: AppButton = {
        let btn = AppButton()
        btn.isUserInteractionEnabled = false
        btn.display(title: "EVOLVE")
        return btn
    }()
    private let backgroundView: UIImageView = {
        let imgView: UIImageView = UIImageView(
            image: UIImage(named: "tamagochi_bg2"))
        imgView.isUserInteractionEnabled = true
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override func initialize() {
        addSubview(backgroundView)
        backgroundView.easy.layout(Edges())
        
        backgroundView.addSubview(petView)
        petView.easy.layout(CenterX(), CenterY(),
                            Width(300), Height(300))
        
        backgroundView.addSubview(evolveButton)
        evolveButton.easy.layout(CenterX(), Width(200), Bottom(20))
        evolveButton.addTarget(self, action: #selector(evolveTapped), for: .touchUpInside)
        
        petView.delegate = self
        backgroundColor = UIColor.app.background
    }
    
    func display(pet: Tamagochi) {
        petView.tamagochi = pet
    }
    
    func start(_ animation: PetAnimation) {
        petView.start(animation)
    }
    
    func setButton(active: Bool) {
        evolveButton.isUserInteractionEnabled = active
    }
    
    // MARK: - PetViewDelegate
    func petView(finished animation: PetAnimation) {
        delegate?.tamagochiView(finished: animation)
    }
    
    func petView(tappedPet view: PetView) {
        delegate?.tamagochiView(tappedPet: self)
    }
    
    @objc private func evolveTapped() {
        delegate?.tamagochiView(tappedEvolve: self)
    }
}

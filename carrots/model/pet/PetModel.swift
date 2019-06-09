//
//  PetModel.swift
//  carrots
//
//  Created by Tomasz Lizer on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import RxSwift

class PetModel {
    private(set) var tamagochi: Tamagochi
    private(set) var level: TamagochLevel
    private(set) var points: Int
    private var disposeBag: DisposeBag = DisposeBag()
    private let displiedLevel: PublishSubject<TamagochLevel> = PublishSubject()
    let canEvolve: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    init(levelSubject: BehaviorSubject<TamagochLevel>, displiedLevel: BehaviorSubject<TamagochLevel>) {
        tamagochi = Tamagochi.notMovingEgg
        points = 0
        level = TamagochLevel.level0
        
        levelSubject.distinctUntilChanged()
            .map { $0.rawValue > self.tamagochi.formLevel.rawValue }
            .subscribe(onNext: { (canEvolve) in
                self.canEvolve.onNext(canEvolve)
            }).disposed(by: disposeBag)
        
        self.displiedLevel.distinctUntilChanged()
            .subscribe(onNext: { (level) in
                displiedLevel.onNext(level)
            }).disposed(by: disposeBag)
    }
    
    func evolve() -> Bool {
        switch tamagochi {
        case .notMovingEgg:
            tamagochi = .egg
        case .egg:
            tamagochi = .babyDinosaur
        case .babyDinosaur:
            tamagochi = .grownDino
        case .grownDino:
            return false
        }
        
        displiedLevel.onNext(tamagochi.formLevel)
        return true
    }
    
}

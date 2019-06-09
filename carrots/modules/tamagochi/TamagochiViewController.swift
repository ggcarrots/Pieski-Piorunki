//
//  TamagochiViewController.swift
//  carrots
//
//  Created by Tomasz Lizer on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit
import RxSwift

class TamagochiViewController: UIViewController, TamagochiViewDelegate {
    
    @IBOutlet weak var mainView: TamagochiView!
    private var pet: PetModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pet = PetModel(levelSubject: AppModel.instance._logicLevel,
                       displiedLevel: AppModel.instance._displiedLevel)
        
        pet.canEvolve.subscribe(onNext: { (canEvolve) in
            if canEvolve {
                self.mainView.setButton(active: true)
            }
        }).disposed(by: disposeBag)
        
        mainView.delegate = self
        mainView.display(pet: pet.tamagochi)
        view.backgroundColor = UIColor.app.background
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func buttonTap(_ sender: Any) {
        mainView.start(PetAnimation.shakePet)
    }
    
    
    @IBAction func unwindeWith(tamagochi segue: UIStoryboardSegue) {
        
    }
    
    // MARK: - TamagochiViewDelegate
    func tamagochiView(finished animation: PetAnimation) {
        switch animation {
        case .evolve(let pet):
            mainView.start(PetAnimation.puff(pet))
        default:
            break
        }
    }
    
    func tamagochiView(tappedPet view: TamagochiView) {
//        guard pet.tamagochi == .babyDinosaur else { return }
        mainView.start(PetAnimation.shakePet)
    }
    
    func tamagochiView(tappedEvolve view: TamagochiView) {
        guard pet.evolve() else { return }
        mainView.start(PetAnimation.evolve(pet.tamagochi))
    }
    
}

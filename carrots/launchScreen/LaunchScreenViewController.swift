//
//  LaunchScreenViewController.swift
//  carrots
//
//  Created by Tomasz Lizer on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController, MainLaunchScreenViewDelegate {
    
    @IBOutlet weak var mainView: MainLaunchScreenView!
    private var selectedCategories: Set<NewsCategory> = [] {
        didSet {
            mainView.setButton(enabled: selectedCategories.count != 0)
        }
    }
    
    override func viewDidLoad() {
        mainView.display(data: LaunchScreenData())
        mainView.setButton(enabled: false)
        mainView.delegate = self
    }
    
    // MARK: - MainLaunchScreenViewDelegate
    func mainLaunchScreenView(selected: Bool, category: NewsCategory) {
        if selected {
            selectedCategories.insert(category)
        } else {
            selectedCategories.remove(category)
        }
    }
    
    func mainLaunchScreenView(tappedButton view: MainLaunchScreenView) {
        print("Selected categories: \n\(selectedCategories)")
        performSegue(withIdentifier: "start", sender: nil)
    }
    
}


struct LaunchScreenData: LaunchScreenDataProtocol {
    let title: String = "ZAINTERESOWANIA"
    let tableHeader: String = "What do you like?"
    let categories: [NewsCategory] = NewsCategory.allCases
    let buttonTitle: String = "START"
}

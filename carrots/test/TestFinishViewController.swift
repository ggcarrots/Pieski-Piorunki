//
//  TestFinishViewController.swift
//  carrots
//
//  Created by Paweł Czerwiński on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


class TestFinishViewController: UIViewController {
    
    
    var answeredQuestions: [AnsweredQuestion]? {
        didSet {
            resultView?.display(answers: answeredQuestions ?? [])
        }
    }
    
    
    @IBOutlet private weak var resultView: ResultsView! {
        didSet {
            resultView?.display(answers: answeredQuestions ?? [])
        }
    }
    
    @IBOutlet private weak var confirmBtn: AppButton! {
        didSet {
            confirmBtn.display(title: "Continue")
            confirmBtn.addTarget(
                self, action: #selector(showDino),
                for: UIControl.Event.touchUpInside
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.app.background
        title = "SUMMARY"
        navigationItem.hidesBackButton = true
    }
    
    
    @objc func showDino() {
        AppModel.instance.addResult(answers: resultView.result!)
        performSegue(withIdentifier: "finish", sender: nil)
    }
}

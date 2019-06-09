//
//  TestContainerViewController.swift
//  carrots
//
//  Created by Paweł Czerwiński on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


private let pagesSegue: String = "questionPages"
private let finishSegue: String = "finish"


class TestContainerViewController: UIViewController,
    TestQuestionsViewControllerDelegate {
    
    // MARK: api
    var test: Test? = Test.t1 {
        didSet {
            questionsController?.questions = test?.questions
            questionIndicator?.display(
                index: 1, max: test?.questions.count ?? 0
            )
        }
    }
    
    
    // MARK: outlets
    @IBOutlet private weak var confirmButton: AppButton? {
        didSet {
            confirmButton?.addTarget(
                self,
                action: #selector(confirm),
                for: UIControl.Event.touchUpInside
            )
            confirmButton?.display(title: "ZATWIERDŹ")
        }
    }
    
    @IBOutlet private weak var questionIndicator: QuestionIndexView? {
        didSet {
            questionIndicator?.display(
                index: 1, max: test?.questions.count ?? 0
            )
        }
    }
    
    
    // MARK: initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TEST"
    }
    
    // MARK: private members
    private var questionsController: TestQuestionsViewController! {
        didSet {
            questionsController?.questions = test?.questions
            questionsController?.testDelegates = self
        }
    }
    
    
    // MARK: navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case pagesSegue:
            let vc: TestQuestionsViewController = segue.destination
                as! TestQuestionsViewController
            questionsController = vc
        case finishSegue:
            prepareFinishController(segue.destination, answeredQuestions: sender)
        default:
            fatalError()
        }
    }
    
    
    private func prepareFinishController(
        _ vc: UIViewController,
        answeredQuestions: Any?
    ) {
        let vc: TestFinishViewController = vc as! TestFinishViewController
        vc.answeredQuestions = answeredQuestions as? [AnsweredQuestion]
    }
    
    
    // MARK: actions
    @objc private func confirm() {
        guard let questionsController: TestQuestionsViewController
            = questionsController else { return }
        
        if questionsController.haveNextQuestion {
            questionsController.showNextQuestion()
        } else {
            questionsController.confirmFinalQuestion()
            performSegue(
                withIdentifier: finishSegue,
                sender: questionsController.answeredQuestions
            )
        }
    }
    
    
    // MARK: TestQuestionsViewControllerDelegate
    func testQuestionsViewController(
        _ vc: TestQuestionsViewController, didChangeCurrentIndex index: Int
    ) {
        questionIndicator?.display(
            index: index + 1, max: test?.questions.count ?? 0
        )
    }
}

//
//  TestQuestionsViewController.swift
//  carrots
//
//  Created by Paweł Czerwiński on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


protocol TestQuestionsViewControllerDelegate: class {
    func testQuestionsViewController(
        _ vc: TestQuestionsViewController, didChangeCurrentIndex index: Int
    )
}

class TestQuestionsViewController: UIPageViewController,
    UIPageViewControllerDataSource {
    
    
    weak var testDelegates: TestQuestionsViewControllerDelegate?
    
    // MARK: API
    var questions: [Question]? {
        didSet {
            currentQuestion = 0
            updateVisibleController(animated: false)
        }
    }
    
    private(set) var answeredQuestions: [AnsweredQuestion] = []
    
    
    
    var haveNextQuestion: Bool {
        return currentQuestion + 1 < (questions ?? []).count
    }
    
    func confirmFinalQuestion() {
        answeredQuestions.append(currentQuestionVC.answeredQuestion)
        if currentQuestion + 1 != questions?.count {
            fatalError()
        }
    }
    
    func showNextQuestion() {
        answeredQuestions.append(currentQuestionVC.answeredQuestion)
        currentQuestion += 1
        testDelegates?.testQuestionsViewController(
            self, didChangeCurrentIndex: currentQuestion
        )
        updateVisibleController(animated: true)
    }
    
    
    private var currentQuestionVC: QuestionViewController {
        return self.viewControllers?.first as! QuestionViewController
    }
    
    private(set) var currentQuestion: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateVisibleController(animated: false)
    }
    
    func updateVisibleController(animated: Bool) {
        guard isViewLoaded else { return }
        if let questions: [Question] = questions,
            questions.count > currentQuestion {
            
            let vc: QuestionViewController = createController(
                for: questions[currentQuestion]
            )
            setViewControllers(
                [vc],
                direction: UIPageViewController.NavigationDirection.forward,
                animated: animated
            )
            
            return
        }
        
        setViewControllers(
            nil,
            direction: UIPageViewController.NavigationDirection.forward,
            animated: animated
        )
    }
    
    private func createController(
        for question: Question
    ) -> QuestionViewController {
        let storyboard: UIStoryboard = UIStoryboard(
            name: "QuestionViewController", bundle: nil
        )
        let vc: QuestionViewController =
            storyboard.instantiateInitialViewController()
                as! QuestionViewController
        vc.question = question
        return vc
    }
    
    
    // MARK: UIPageViewControllerDataSource
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        return nil
    }
    
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        return nil
    }
}

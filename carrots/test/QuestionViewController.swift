//
//  QuestionViewController.swift
//  carrots
//
//  Created by Paweł Czerwiński on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


class QuestionViewController: UIViewController {
    
    // MARK: APi
    
    @IBOutlet private weak var questionView: QuestionView! {
        didSet {
            questionView?.display(question: question)
        }
    }
    

    var question: Question? = Question.q1 {
        didSet {
            questionView?.display(question: question)
        }
    }
    
    
    var answeredQuestion: AnsweredQuestion {
        return question!.answered(
            selectedIndexes: questionView?.selectedAnswers ?? []
        )
    }
}

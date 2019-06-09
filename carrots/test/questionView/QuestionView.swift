//
//  TestView.swift
//  carrots
//
//  Created by Paweł Czerwiński on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit


private let questionCellId: String = "a"
private let answerCellId: String = "b"


class QuestionView: UITableView, UITableViewDataSource {
    private var question: Question?
    
    
    // MARK: Api
    func display(question: Question?) {
        self.question = question
        reloadData()
    }
    
    
    var selectedAnswers: [Int] {
        return indexPathsForSelectedRows?.map {
            $0.row - 1
        } ?? []
    }
    
    
    // MARK: Init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initialize()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    
    func initialize() {
        register(
            UINib(nibName: "QuestionCell", bundle: nil),
            forCellReuseIdentifier: questionCellId
        )
        register(
            UINib(nibName: "AnswerCell", bundle: nil),
            forCellReuseIdentifier: answerCellId
        )
        dataSource = self
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = CGFloat(30.0)
        
        separatorStyle = .none
        backgroundColor = UIColor.app.background
        allowsSelection = true
        
        allowsMultipleSelection = true
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        separatorStyle = self.separatorStyle
    }
    
    
    // MARK: UITableViewDataSource
    func tableView(
        _ tableView: UITableView, numberOfRowsInSection section: Int
    ) -> Int {
        guard let test: Question = question else { return 0 }
        return 1 + test.answers.count
    }
    
    
    func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let question: Question = question else { fatalError() }
        
        switch indexPath.row {
        case 0:
            let cell: QuestionCell = tableView.dequeueReusableCell(
                withIdentifier: questionCellId, for: indexPath
            ) as! QuestionCell
            
            cell.display(
                questionText: question.text, category: question.category
            )
            return cell
        case 1 ... question.answers.count + 1:
            let cell: AnswerCell = tableView.dequeueReusableCell(
                withIdentifier: answerCellId, for: indexPath
            ) as! AnswerCell
            cell.display(answerText: question.answers[indexPath.row - 1])
            return cell
        default:
            fatalError()
        }
    }
}

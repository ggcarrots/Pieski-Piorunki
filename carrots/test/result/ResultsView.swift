//
//  ResultsView.swift
//  carrots
//
//  Created by Paweł Czerwiński on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import Foundation
import UIKit



private let headerCellId: String = "a"
private let categoryCellId: String = "b"


struct TestResult {
    let max: Int
    let score: Int
    let perCategories: [(cateogry: NewsCategory, score: Int, max: Int)]
    let state: State
    
    init(answers: [AnsweredQuestion]) {
        
        var max: Int = 0
        var score: Int = 0
        
        var grouped: [NewsCategory: (score: Int, max: Int)] = [:]
        for answer: AnsweredQuestion in answers {
            grouped[answer.question.category] = (0, 0)
        }
        
        for answer: AnsweredQuestion in answers {
            var (pScore, pMax) = grouped[answer.question.category]!
            pMax += 1
            max += 1
            if answer.isCorrect {
                pScore += 1
                score += 1
            }
            grouped[answer.question.category] = (pScore, pMax)
        }
        
        self.max = max
        self.score = score
        
        self.perCategories = grouped.map {
            ($0.key, $0.value.score, $0.value.max)
        }.sorted { $0.0.labelText < $1.0.labelText }
        
        if score * 4 < max { // < 25 %
            state = .tragic
        } else if score * 2 < max { // < 50 %
            state = .neutral
        } else {
            state = .ok
        }
    }
    
    enum State {
        case ok
        case neutral
        case tragic
    }
    
    var stateText: String {
        switch state {
        case .tragic:
            return "Your Dino is disapointed by your score :("
        case .neutral:
            return "Nothing happend"
        case .ok:
            return "Your Dino is happy!"
        }
    }
}


class ResultsView: UITableView, UITableViewDataSource {
    private(set) var result: TestResult?
    
    
    func display(answers: [AnsweredQuestion]) {
        
        self.result = TestResult(answers: answers)
        reloadData()
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
            UINib(nibName: "ResultHeaderCell", bundle: nil),
            forCellReuseIdentifier: headerCellId
        )
        register(
            UINib(nibName: "ResultsCategoryScoreCell", bundle: nil),
            forCellReuseIdentifier: categoryCellId
        )
        dataSource = self
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = CGFloat(30.0)
        
        separatorStyle = .none
        backgroundColor = UIColor.app.background
        allowsSelection = false
    }
    
    
    // MARK: UITableViewDataSource
    func tableView(
        _ tableView: UITableView, numberOfRowsInSection section: Int
        ) -> Int {
        guard let result: TestResult = result else { return 0 }
        return 1 + result.perCategories.count
    }
    
    
    func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath
        ) -> UITableViewCell {
        
        guard let result: TestResult = result else { fatalError() }

        switch indexPath.row {
        case 0:
            let cell: ResultHeaderCell = tableView.dequeueReusableCell(
                withIdentifier: headerCellId, for: indexPath
            ) as! ResultHeaderCell

            cell.display(
                score: result.score, max: result.max, status: result.stateText
            )
            return cell
        case 1 ... result.perCategories.count + 1:
            let cell: ResultsCategoryScoreCell = tableView.dequeueReusableCell(
                withIdentifier: categoryCellId, for: indexPath
            ) as! ResultsCategoryScoreCell
            let (category, score, max) = result.perCategories[indexPath.row - 1]
            cell.display(
                category: category,
                score: score,
                max: max
            )
            return cell
        default:
            fatalError()
        }
    }
}

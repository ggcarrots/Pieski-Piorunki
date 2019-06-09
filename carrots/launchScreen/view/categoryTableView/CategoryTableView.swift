//
//  CategoryTableView.swift
//  carrots
//
//  Created by Tomasz Lizer on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit

protocol CategoryTableViewDelegate: class {
    func categoryTableView(selected: Bool, category: NewsCategory)
}

class CategoryTableView: BoroTableView, UITableViewDataSource, UITableViewDelegate {
    
    weak var viewDelegate: CategoryTableViewDelegate?
    
    private var categories: [NewsCategory] = [] {
        didSet {
            reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    private var header: String?
    var inactiveBottomHeight: CGFloat = 0
    
    override func initialize() {
        register(CategoryTableViewCell.self,
                 forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        register(CategoryTableViewHeaderView.self,
                 forHeaderFooterViewReuseIdentifier: CategoryTableViewHeaderView.reuseIdentifier)
        tableFooterView = UIView()
        backgroundView = nil
        backgroundColor = UIColor.app.background
        bounces = false
        allowsMultipleSelection = true
        dataSource = self
        delegate = self
    }
    
    func display(categories: [NewsCategory], header: String?) {
        self.header = header
        self.categories = categories
        backgroundColor = backgroundColor
    }
    
    // MARK - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoryTableViewCell.reuseIdentifier,
            for: indexPath) as? CategoryTableViewCell
        cell?.display(title: categories[indexPath.row].labelText)
        return cell ?? UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: CategoryTableViewHeaderView.reuseIdentifier
        ) as? CategoryTableViewHeaderView
        header?.display(title: self.header)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewDelegate?.categoryTableView(selected: true, category: categories[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewDelegate?.categoryTableView(selected: false, category: categories[indexPath.row])
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        separatorStyle = .none
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard bounds.height - inactiveBottomHeight >= point.y - contentOffset.y else { return false }
        return super.point(inside: point, with: event)
    }
    
}

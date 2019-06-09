//
//  NewsViewController.swift
//  carrots
//
//  Created by Mateusz Orzoł on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit

fileprivate let goTestSegue: String = "test"


final class NewsViewController: UIViewController {
    
    private let viewModel = NewsViewModel()
    
    private lazy var newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: String(describing: NewsTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let testButton: AppButton = {
        let testButton = AppButton()
        testButton.label.textColor = UIColor.white
        testButton.backgroundColor = UIColor.orange
        testButton.label.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.semibold)
        testButton.translatesAutoresizingMaskIntoConstraints = false
        return testButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.newsCategoriesContentUpdated = reloadViews
        setButton()
    }

    private func reloadViews() {
        newsTableView.reloadData()
        setButton()
    }
    
    private func setButton()  {
        if viewModel.doneMinutes >= viewModel.maxMinutes {
            testButton.label.text = "Start Test"
            testButton.isEnabled  = true
            testButton.alpha = 1.0
        } else {
            testButton.label.text = "Materials \(viewModel.doneMinutes)/\(viewModel.maxMinutes)"
            testButton.isEnabled = false
            testButton.alpha = 0.3
        }
    }
    
    private func onSelect(categor: NewsCategory, index: Int) {
        viewModel.select(from: categor, at: index, vc: self)
    }
    
    private func setupUI() {
        setupSubviews()
        setupConstraints()
        testButton.addTarget(self, action: #selector(goToTest), for: UIControl.Event.touchUpInside)
        title = "Newsfeed"
    }
    
    private func setupSubviews() {
        view.backgroundColor = UIColor.app.background
        view.addSubview(newsTableView)
        view.addSubview(testButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            newsTableView.bottomAnchor.constraint(equalTo: testButton.topAnchor, constant: -10),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            testButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10
            ),
            testButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            testButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
            ])
    }
    
    @objc private func goToTest() {
        performSegue(withIdentifier: goTestSegue, sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "info: Info":
            let info: Info = sender as! Info
            let vc: InfoViewController = segue.destination
                as! InfoViewController
            vc.info = info
        default:
            break
        }
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsTableViewCell.self), for: indexPath) as! NewsTableViewCell
        let model = viewModel.newsCategoriesContent[indexPath.row]
        cell.setup(model: model)
        cell.handler = onSelect(categor:index:)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsCategoriesContent.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

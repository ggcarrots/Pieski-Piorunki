//
//  MainLaunchScreenView.swift
//  carrots
//
//  Created by Tomasz Lizer on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit
import EasyPeasy

protocol LaunchScreenDataProtocol {
    var title: String { get }
    var tableHeader: String { get }
    var categories: [NewsCategory] { get }
    var buttonTitle: String { get }
}

protocol MainLaunchScreenViewDelegate: class {
    func mainLaunchScreenView(selected: Bool, category: NewsCategory)
    func mainLaunchScreenView(tappedButton view: MainLaunchScreenView)
}

class MainLaunchScreenView: BoroView, CategoryTableViewDelegate {
    
    weak var delegate: MainLaunchScreenViewDelegate?
    
//    private let headerView: LaunchViewHeaderView = LaunchViewHeaderView()
    private let button: AppButton = AppButton()
    private let categoryTable: CategoryTableView = CategoryTableView()
    
    override func initialize() {
        [categoryTable, /*headerView,*/ button].forEach { addSubview($0) }
        
//        headerView.easy.layout(Left(), Top(), Right())
        categoryTable.easy.layout(
            Top()/*.to(headerView)*/, Bottom(),
            Left(), Right()
        )
        button.easy.layout(Left(12), Bottom(12), Right(12))
        
        categoryTable.viewDelegate = self
        categoryTable.showsVerticalScrollIndicator = false
        categoryTable.clipsToBounds = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.clipsToBounds = true
        
        backgroundColor = UIColor.app.background
        clipsToBounds = true
    }
    
    func display(data: LaunchScreenDataProtocol?) {
//        headerView.display(header: data?.title)
        categoryTable.display(categories: data?.categories ?? [],
                              header: data?.tableHeader)
        button.display(title: data?.buttonTitle)
    }
    
    func setButton(enabled: Bool) {
        button.isUserInteractionEnabled = enabled
    }
    
    @objc private func buttonTapped() {
        delegate?.mainLaunchScreenView(tappedButton: self)
    }
    
    // MARK: - CategoryTableViewDelegate
    func categoryTableView(selected: Bool, category: NewsCategory) {
        delegate?.mainLaunchScreenView(selected: selected, category: category)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bottomInset = bounds.height - button.frame.minY + 20
        categoryTable.contentInset.bottom = bottomInset
        categoryTable.inactiveBottomHeight = bottomInset
    }
    
}

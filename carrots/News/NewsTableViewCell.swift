//
//  NewsTableViewCell.swift
//  carrots
//
//  Created by Mateusz Orzoł on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


final class NewsTableViewCell: UITableViewCell {
    
    private var newsCategoryContent: NewsCategoryContent! = nil {
        didSet { newsCollectionView.reloadData() }
    }
    
    var handler: ((NewsCategory, Int) -> ())?
    
    let layout = UICollectionViewFlowLayout()
    
    private let categoryTitleView: CategoryView = {
        let view = CategoryView()
        view.backgroundColor = UIColor.app.czcionka
        view.lbl.textColor = UIColor.white
        view.lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newsCollectionView: UICollectionView = {
        layout.scrollDirection = .horizontal
        layout.itemSize.width = 200
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.app.background
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: NewsCollectionViewCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout.itemSize.height = newsCollectionView.frame.size.height
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setup(model: NewsCategoryContent) {
        categoryTitleView.display(category: model.category)
        newsCategoryContent = model
    }

    private func setupUI() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(categoryTitleView)
        addSubview(newsCollectionView)
        selectionStyle = .none
        backgroundColor = UIColor.app.background
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
                categoryTitleView.topAnchor.constraint(equalTo: topAnchor),
                categoryTitleView.leadingAnchor.constraint(equalTo: leadingAnchor),
                categoryTitleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
                newsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                newsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                newsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
                newsCollectionView.topAnchor.constraint(equalTo: categoryTitleView.bottomAnchor, constant: 5)
            ])
    }
}


extension NewsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsCategoryContent?.newsContent.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NewsCollectionViewCell.self), for: indexPath) as! NewsCollectionViewCell
        guard let model = newsCategoryContent?.newsContent[indexPath.row] else { return UICollectionViewCell() }
        cell.setup(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = newsCategoryContent else { return }
        handler?(model.category, indexPath.row)
    }
}

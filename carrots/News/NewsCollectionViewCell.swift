//
//  NewsCollectionViewCell.swift
//  carrots
//
//  Created by Mateusz Orzoł on 08/06/2019.
//  Copyright © 2019 Paweł Czerwiński. All rights reserved.
//

import UIKit


final class NewsCollectionViewCell: UICollectionViewCell {
    
    
    private let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.alpha = 0.75
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    private let blurView2: UIVisualEffectView = {
        let blur = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.alpha = 0.4
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    private let cloudIcon: UIImageView = {
        let cloudIcon = UIImageView()
        cloudIcon.image = #imageLiteral(resourceName: "cloud")
        cloudIcon.contentMode = .scaleAspectFit
        cloudIcon.translatesAutoresizingMaskIntoConstraints = false
        return cloudIcon
    }()
    
    private let minutes: UILabel = {
        let minutes = UILabel()
        minutes.textAlignment = .center
        minutes.layer.cornerRadius = 15
        minutes.backgroundColor = UIColor.app.czcionka
        minutes.textColor = UIColor.app.background
        minutes.layer.masksToBounds = true
        minutes.translatesAutoresizingMaskIntoConstraints = false
        return minutes
    }()
    
    private let mainView: UIImageView = {
        let mainView = UIImageView()
        mainView.contentMode = .scaleAspectFill
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    private let mainImage: UIImageView = {
        let mainImage = UIImageView()
        mainImage.contentMode = .scaleAspectFill
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        return mainImage
    }()
    
    private let finishedImage: UIImageView = {
        let finishedImage = UIImageView()
        finishedImage.image = #imageLiteral(resourceName: "done")
        finishedImage.contentMode = .scaleAspectFill
        finishedImage.translatesAutoresizingMaskIntoConstraints = false
        return finishedImage
    }()
    
    private let bottomView: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.app.tabBar
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.app.czcionka
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setup(model: NewsContent) {
        cloudIcon.isHidden = !model.isFromCloud
        minutes.text = "\(model.time)"
        mainView.image = model.image
        mainImage.image = model.newsType.image
        blurView.isHidden = !model.finished
        blurView2.isHidden = model.finished
        finishedImage.isHidden = !model.finished
        titleLabel.text = model.title
    }
    
    private func setupUI() {
        setupSubviews()
        setupConstraints()
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    
    private func setupSubviews() {
        addSubview(mainView)
        addSubview(bottomView)
        addSubview(titleLabel)
        addSubview(blurView2)
        addSubview(mainImage)
        addSubview(cloudIcon)
        addSubview(minutes)
        addSubview(blurView)
        addSubview(finishedImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cloudIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            cloudIcon.topAnchor.constraint(equalTo: topAnchor, constant: -8),
            cloudIcon.heightAnchor.constraint(equalToConstant: 50),
            cloudIcon.widthAnchor.constraint(equalToConstant: 50),

            minutes.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            minutes.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            minutes.heightAnchor.constraint(equalToConstant: 30),
            minutes.heightAnchor.constraint(equalTo: minutes.widthAnchor),
            
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            mainImage.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            mainImage.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            mainImage.heightAnchor.constraint(equalTo: mainImage.widthAnchor),
            mainImage.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.7),
            
            finishedImage.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            finishedImage.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            finishedImage.heightAnchor.constraint(equalTo: finishedImage.widthAnchor),
            finishedImage.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.8),
            
            blurView.topAnchor.constraint(equalTo: mainView.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            blurView2.topAnchor.constraint(equalTo: mainView.topAnchor),
            blurView2.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            blurView2.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            blurView2.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
            ])
    }
}

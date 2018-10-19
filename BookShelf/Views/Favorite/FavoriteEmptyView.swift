//
//  FavoriteEmptyView.swift
//  BookShelf
//
//  Created by Winston Maragh on 10/19/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit

class FavoriteEmptyView: UIView {

    lazy var favImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "searchMan")
        return iv
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.text = "There are no favorite books saved."
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .left
        label.layer.opacity = 0.9
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        addImageView()
        addDescriptionLabel()
    }
    
    private func addImageView() {
        addSubview(favImageView)
        favImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            favImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: -50),
            favImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
            favImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.95)
            ])
    }
    
    private func addDescriptionLabel() {
        addSubview(descLabel)
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: favImageView.bottomAnchor),
            descLabel.leadingAnchor.constraint(equalTo: favImageView.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: favImageView.trailingAnchor),
            descLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            ])
    }

}

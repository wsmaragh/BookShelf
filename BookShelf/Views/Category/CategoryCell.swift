//
//  CategoriesCell.swift
//  Books
//
//  Created by Winston Maragh on 10/18/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.layer.opacity = 0.9
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    static var cellID: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 6
        self.backgroundColor = UIColor.getRandomColor()
    }
    
    private func setupViews() {
        addLabel()
    }
    
    
    private func addLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                label.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
                label.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
            ])
        }

        else {
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: centerXAnchor),
                label.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
        }
    }
    
    func configureCell(category: NYTBookCategory) {
        self.label.text = category.displayName
    }

}

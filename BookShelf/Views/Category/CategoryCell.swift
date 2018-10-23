//
//  CategoriesCell.swift
//  Books
//
//  Created by Winston Maragh on 10/18/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit
import SkeletonView

class CategoryCell: UICollectionViewCell {

    lazy var label: UILabel = {
        let label = UILabel()
        label.text = " "
        label.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.layer.opacity = 0.9
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.isSkeletonable = true
        return label
    }()
    
    static var cellID: String {
        return String(describing: self)
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        isSkeletonable = true
        label.isSkeletonable = true
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
        self.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
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
        self.backgroundColor = UIColor.getRandomColor()
        removeBackgroundSkeleton()
    }
    
    func removeBackgroundSkeleton() {
        label.backgroundColor = self.backgroundColor
    }
    
}

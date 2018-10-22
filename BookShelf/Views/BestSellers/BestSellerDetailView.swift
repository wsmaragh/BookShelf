//
//  BestSellerDetailView.swift
//  Books
//
//  Created by Winston Maragh on 10/18/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit

class BestSellerDetailView: UIView {

    lazy var bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "bookCover")
        return iv
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Book Title"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.layer.opacity = 0.9
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = "By Author"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.layer.opacity = 0.9
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.text = "Rank: XX"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.layer.opacity = 0.9
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var weeksOnListLabel: UILabel = {
        let label = UILabel()
        label.text = "Weeks: XX"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.layer.opacity = 0.9
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description: XX"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.layer.opacity = 0.9
        label.textColor = UIColor.darkText
        label.numberOfLines = 0
        return label
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "like_empty"), for: .normal)
        button.tintColor = UIColor.init(red: 51/255, green: 102/255, blue: 204/255, alpha: 1.0)
        return button
    }()
    
    lazy var bookReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("  NYT Book Review  ", for: .normal)
        button.backgroundColor = UIColor.init(red: 51/255, green: 102/255, blue: 204/255, alpha: 1.0)
        button.tintColor = UIColor.darkGray
        button.isHidden = true
        return button
    }()
    
    lazy var amazonButton: UIButton = {
        let button = UIButton()
        button.setTitle("  Buy on Amazon  ", for: .normal)
        button.backgroundColor = UIColor.init(red: 76/255, green: 187/255, blue: 23/255, alpha: 1.0)
        button.tintColor = UIColor.darkGray
        button.isHidden = true
        return button
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
        amazonButton.layer.cornerRadius = 6
        amazonButton.layer.masksToBounds = true
        bookReviewButton.layer.cornerRadius = 6
        bookReviewButton.layer.masksToBounds = true
        setupViews()
    }
    
    private func setupViews() {
        addRankLabel()
        addWeeksOnListLabel()
        addTitleLabel()
        addSaveButton()
        addBookImageView()
        addAuthorLabel()
        addDescriptionLabel()
        addBookReviewButton()
        addAmazonButton()
    }
    
    private func addRankLabel() {
        addSubview(rankLabel)
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            rankLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            ])
    }
    
    private func addWeeksOnListLabel() {
        addSubview(weeksOnListLabel)
        weeksOnListLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weeksOnListLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 8),
            weeksOnListLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            ])
    }

    private func addTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: weeksOnListLabel.bottomAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            ])
    }
    
    private func addSaveButton() {
        addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8),
            saveButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            ])
    }
    
    private func addBookImageView() {
        addSubview(bookImageView)
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bookImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            bookImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            bookImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.55),
            bookImageView.heightAnchor.constraint(equalTo: bookImageView.widthAnchor, multiplier: 1.2),
            ])
    }
    
    private func addAuthorLabel() {
        addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: bookImageView.trailingAnchor)
            ])
    }
    
    private func addDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
    }
    
    private func addBookReviewButton() {
        addSubview(bookReviewButton)
        bookReviewButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bookReviewButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            bookReviewButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16)
            ])
    }
    
    private func addAmazonButton() {
        addSubview(amazonButton)
        amazonButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            amazonButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            amazonButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
    }
    
    func configureView(book: NYTBestSellerBook) {
        bookImageView.loadImage(imageURLString: "http://covers.openlibrary.org/b/isbn/\(book.isbn10)-M.jpg?default=false")
        titleLabel.text = book.title
        authorLabel.text = book.contributor
        rankLabel.text = "Rank: \(book.rank)"
        weeksOnListLabel.text = "Weeks: \(book.weeksOnList)"
        descriptionLabel.text = book.shortDescription
        amazonButton.isHidden = book.amazonURLString.isEmpty ? true : false
        bookReviewButton.isHidden = book.review.isEmpty ? true : false
        
        if FileManagerService.shared.isBookSaved(book: book) {
            saveButton.setImage(UIImage(named: "like_filled"), for: .normal)
        } else {
            saveButton.setImage(UIImage(named: "like_empty"), for: .normal)
        }
    }

}

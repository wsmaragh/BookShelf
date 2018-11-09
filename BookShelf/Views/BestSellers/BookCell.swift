//
//  BookCell.swift
//  Books
//
//  Created by Winston Maragh on 10/18/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit

final class BookCell: UITableViewCell {

    lazy var bookImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .left
        label.layer.opacity = 0.9
        label.textColor = UIColor.darkGray
        label.numberOfLines = 2
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .left
        label.layer.opacity = 0.9
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .left
        label.layer.opacity = 0.9
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var weeksOnListLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .left
        label.layer.opacity = 0.9
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        return label
    }()

    static var cellID: String {
        return String(describing: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        roundedCorners()
        addCustomSkeleton()
    }
    
    private func roundedCorners() {
        layer.masksToBounds = true
        layer.cornerRadius = 6
        bookImageView.layer.masksToBounds = true
        bookImageView.layer.cornerRadius = 6
    }
    
    private func addCustomSkeleton() {
        self.isUserInteractionEnabled = false
        bookImageView.backgroundColor = UIColor.skeletonColor
        titleLabel.backgroundColor = UIColor.skeletonColor
        authorLabel.backgroundColor = UIColor.skeletonColor
        rankLabel.backgroundColor = UIColor.skeletonColor
        weeksOnListLabel.backgroundColor = UIColor.skeletonColor
    }
    
    private func removeCustomSkeleton() {
        isUserInteractionEnabled = true
        bookImageView.backgroundColor = backgroundColor
        titleLabel.backgroundColor = backgroundColor
        authorLabel.backgroundColor = backgroundColor
        rankLabel.backgroundColor = backgroundColor
        weeksOnListLabel.backgroundColor = backgroundColor
    }
    
    private func setupViews() {
        addBookImageView()
        addTitleLabel()
        addAuthorLabel()
        addRankLabel()
        addWeeksOnListLabel()
    }
    
    private func addBookImageView() {
        addSubview(bookImageView)
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bookImageView.heightAnchor.constraint(equalToConstant: 100),
            bookImageView.widthAnchor.constraint(equalTo: bookImageView.heightAnchor),
            bookImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bookImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func addTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: bookImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
    }
    
    private func addAuthorLabel() {
        addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            authorLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])
    }
    
    private func addRankLabel() {
        addSubview(rankLabel)
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5),
            rankLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 8),
            rankLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }

    private func addWeeksOnListLabel() {
        addSubview(weeksOnListLabel)
        weeksOnListLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weeksOnListLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 5),
            weeksOnListLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 8),
            weeksOnListLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    func configureCell(book: NYTBestSellerBook) {
        titleLabel.text = book.title
        authorLabel.text = book.contributor
        rankLabel.text = "Rank: \(book.rank)"
        weeksOnListLabel.text = "Weeks: \(book.weeksOnList)"
        
        bookImageView.loadImage(imageURLString: book.imageStr, secondaryURLStr: "http://covers.openlibrary.org/b/isbn/\(book.isbn10)-S.jpg?default=false", localImageStr: "bookCover")
        removeCustomSkeleton()
    }

}

//
//  BestSellerDVC.swift
//  Books
//
//  Created by Winston Maragh on 10/18/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit

class BestSellerDVC: UIViewController {

    let bestSellerDetailView = BestSellerDetailView()
    
    var book: NYTBestSellerBook!

    init(book: NYTBestSellerBook) {
        super.init(nibName: nil, bundle: nil)
        self.book = book
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomView()
        setupNavBar()
        bestSellerDetailView.bookReviewButton.addTarget(self, action: #selector(bookReviewButtonPressed), for: .touchUpInside)
        bestSellerDetailView.amazonButton.addTarget(self, action: #selector(amazonButtonPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = book.categoryName
    }
    
    private func setupCustomView() {
        self.view = bestSellerDetailView
        bestSellerDetailView.configureView(book: book)
    }
    
    private func setupNavBar(){
        self.navigationItem.title = book.categoryName
    }
    
    @objc func amazonButtonPressed() {
        if !book.amazonURLString.isEmpty {
            let webVC = WebVC(link: book.amazonURLString)
            self.navigationController?.pushViewController(webVC, animated: true)
        }
    }
    
    @objc func bookReviewButtonPressed() {
        if !book.review.isEmpty {
            let webVC = WebVC(link: book.review)
            self.navigationController?.pushViewController(webVC, animated: true)
        }
    }
    
}

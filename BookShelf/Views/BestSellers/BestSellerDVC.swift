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
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = bestSellerDetailView
        bestSellerDetailView.configureView(book: book)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        addButtonTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = book.categoryName
    }
    
    private func setupNavBar(){
        navigationItem.title = book.categoryName
    }
    
    private func addButtonTargets() {
        bestSellerDetailView.bookReviewButton.addTarget(self, action: #selector(bookReviewButtonPressed), for: .touchUpInside)
        bestSellerDetailView.amazonButton.addTarget(self, action: #selector(amazonButtonPressed), for: .touchUpInside)
        bestSellerDetailView.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    
    @objc func amazonButtonPressed() {
        if !book.amazonURLString.isEmpty {
            let webVC = WebVC(link: book.amazonURLString)
            webVC.title = "Buy on Amazon"
            webVC.navigationItem.title = "Buy on Amazon"
            navigationController?.pushViewController(webVC, animated: true)
        }
    }
    
    @objc func bookReviewButtonPressed() {
        if !book.review.isEmpty {
            let webVC = WebVC(link: book.review)
            webVC.title = "NYTimes Review"
            webVC.navigationItem.title = "NYTimes Review"
            navigationController?.pushViewController(webVC, animated: true)
        }
    }
    
    @objc func saveButtonPressed() {
        if bestSellerDetailView.saveButton.image(for: .normal) == UIImage(named: "like_empty") {
            FileManagerService.shared.addFavoriteBook(book: book)
            bestSellerDetailView.saveButton.setImage(UIImage(named: "like_filled"), for: .normal)
            showBookAddedAlert()
        } else {
            FileManagerService.shared.deleteFavoriteBook(book: book)
            bestSellerDetailView.saveButton.setImage(UIImage(named: "like_empty"), for: .normal)
        }
    }
    
    private func showBookAddedAlert(){
        let alertController = UIAlertController(title: "Book Added", message: "Added to your favorites", preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAlert)
        present(alertController, animated: true, completion: nil)
    }
    
}

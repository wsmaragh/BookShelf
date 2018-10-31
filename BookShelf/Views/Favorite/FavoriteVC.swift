//
//  FavoriteVC.swift
//  BookShelf
//
//  Created by Winston Maragh on 10/19/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {
    
    let favoriteView = FavoriteView()
    let favoriteEmptyView = FavoriteEmptyView()
    
    let dataService = BookDataService()
    
    var books: [NYTBestSellerBook] = [] {
        didSet {
            reloadTableView()
        }
    }
    
    override func loadView() {
        view = favoriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupNavBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        books = FileManagerService.shared.getFavoriteBooks()
    }
    
    private func setupNavBar(){
        self.navigationItem.title = "Favorite Books"
        let rightBarButton = UIBarButtonItem(title: "Delete All", style: UIBarButtonItem.Style.plain, target: self, action:  #selector(deleteAllFavoritesPressed))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func deleteAllFavoritesPressed() {
        guard !books.isEmpty else {return}
        let alertController = UIAlertController(title: "Delete All", message: "Are you sure you want to delete all favorities?", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { (_) in
            FileManagerService.shared.deleteAllFavoriteBooks()
            self.books.removeAll()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupTableView() {
        favoriteView.tableView.delegate = self
        favoriteView.tableView.dataSource = self
        favoriteView.tableView.rowHeight = UITableView.automaticDimension
        favoriteView.tableView.estimatedRowHeight = 120
    }
    
    private func fetchData() {
        self.books = FileManagerService.shared.getFavoriteBooks()
        self.reloadTableView()
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async { [unowned self] in
            self.favoriteView.tableView.reloadData()
        }
    }
    
}

// MARK: Tableview Datasource
extension FavoriteVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if books.count == 0 {
            tableView.backgroundView = favoriteEmptyView
            tableView.separatorStyle = .none
            return 0
        } else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
            return books.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.cellID, for: indexPath) as! BookCell
        let book = books[indexPath.row]
        cell.configureCell(book: book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = books[indexPath.row]
            FileManagerService.shared.deleteFavoriteBook(book: book)
            books.remove(at: indexPath.row)
        }
    }
    
}

// MARK: Tableview Delegate
extension FavoriteVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = self.books[indexPath.row]
        let bestSellerDVC = BestSellerDVC(book: book)
        navigationController?.pushViewController(bestSellerDVC, animated: true)
    }
    
}

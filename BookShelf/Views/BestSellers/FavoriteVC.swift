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
    
    let dataService = BookDataService()
    
    var books: [NYTBestSellerBook] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupCustomView()
        setupNavBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        books = FileManagerService.shared.getFavoriteBooks()
    }
    
    private func setupCustomView() {
        self.view = favoriteView
    }
    
    private func setupNavBar(){
        self.navigationItem.title = "Favorite Books"
        let rightBarButton = UIBarButtonItem(title: "Delete All", style: UIBarButtonItem.Style.plain, target: self, action:  #selector(deleteAllFavoritesPressed))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func deleteAllFavoritesPressed() {
        let alertController = UIAlertController(title: "Delete All", message: "Are you sure you want to delete all favorities?", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { (_) in
            FileManagerService.shared.deleteAllFavoriteBooks()
            self.reloadTableView()
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
        DispatchQueue.main.async {
            self.favoriteView.tableView.reloadData()
        }
    }
    
}

// MARK: Tableview Datasource
extension FavoriteVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Best Sellers: "
    }
    
}

// MARK: Tableview Delegate
extension FavoriteVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = self.books[indexPath.row]
        let bestSellerDVC = BestSellerDVC(book: book)
        self.navigationController?.pushViewController(bestSellerDVC, animated: true)
    }
    
}

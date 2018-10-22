//
//  BestSellerVC.swift
//  Books
//
//  Created by Winston Maragh on 10/18/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit
import SkeletonView


class BestSellerVC: UIViewController {

    let bestSellerView = BestSellerView()
    let viewModel = CategoriesViewModel()
    let dataService = BookDataService()

    var category: NYTBookCategory!
    
    var books: [NYTBestSellerBook] = [] {
        didSet {
            self.reloadTableView()
        }
    }
    
    init(category: NYTBookCategory) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupCustomView()
        setupNavBar()
        setupSegmentedControl()
        setupTableView()
    }

    private func setupCustomView() {
        self.view = bestSellerView
    }
    
    private func setupNavBar(){
        self.navigationItem.title = category.displayName
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "settings"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(settingsButtonPressed))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }

    @objc func settingsButtonPressed() {
        let settingsVC = SettingsVC()
        settingsVC.modalPresentationStyle = .overCurrentContext
        settingsVC.modalTransitionStyle = .crossDissolve
        self.present(settingsVC, animated: true, completion: nil)
    }

    private func setupSegmentedControl() {
        bestSellerView.orderSegmentedControl.addTarget(self, action: #selector(segmentControlChanged), for: .valueChanged)
    }
    
    @objc private func segmentControlChanged(segment: UISegmentedControl) -> Void {
        if segment.selectedSegmentIndex == 1 {
            books = books.sorted(by: { (A, B) -> Bool in
                return A.weeksOnList > B.weeksOnList
            })
        } else {
            books = books.sorted(by: { (A, B) -> Bool in
                return A.rank < B.rank
            })
        }
        reloadTableView()
    }
    
    private func setupTableView() {
        bestSellerView.tableView.delegate = self
        bestSellerView.tableView.dataSource = self
        bestSellerView.tableView.rowHeight = UITableView.automaticDimension
        bestSellerView.tableView.estimatedRowHeight = 120
    }
    
    private func fetchData() {
        self.bestSellerView.tableView.showSkeleton()
        dataService.getBooks(fromCategory: category.searchName) { (error, bestSellerBooks) in            
            if let error = error {
                print("Error happedned in fetch. Error: \(error.localizedDescription)")
            }
            
            if let bestSellerBooks = bestSellerBooks {
                self.books = bestSellerBooks
                self.reloadTableView()
            }
        }
    }

    private func reloadTableView() {
        DispatchQueue.main.async {
            self.bestSellerView.tableView.reloadData()
            self.bestSellerView.tableView.hideSkeleton()
        }
    }
    
    private func showSkeleton() {
//        self.bestSellerView.tableView.
            if self.books.isEmpty {
                self.view.showAnimatedSkeleton()
            } else {
                self.view.hideSkeleton(reloadDataAfter: true)
            }
    }
    
    

}

// MARK: Tableview Datasource
extension BestSellerVC: UITableViewDataSource {
    
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
extension BestSellerVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = self.books[indexPath.row]
        let bestSellerDVC = BestSellerDVC(book: book)
        self.navigationController?.pushViewController(bestSellerDVC, animated: true)
    }
    
}

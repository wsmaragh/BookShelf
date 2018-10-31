//
//  BestSellerVC.swift
//  Books
//
//  Created by Winston Maragh on 10/18/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit


class BestSellerVC: UIViewController {

    let bestSellerView = BestSellerView()
    let dataService = BookDataService()

    var category: NYTBookCategory!
    
    var books: [NYTBestSellerBook] = []
    
    init(category: NYTBookCategory) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = bestSellerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupNavBar()
        setupSegmentedControl()
        setupTableView()
    }
    
    private func setupNavBar(){
        navigationItem.title = category.displayName
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "settings"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(settingsButtonPressed))
        navigationItem.rightBarButtonItem = rightBarButton
    }

    @objc func settingsButtonPressed() {
        let settingsVC = SettingsVC()
        settingsVC.modalPresentationStyle = .overCurrentContext
        settingsVC.modalTransitionStyle = .crossDissolve
        present(settingsVC, animated: true, completion: nil)
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
        dataService.getBooksInCategory(fromCategory: category.searchName) {[weak self] (error, bestSellerBooks) in
            guard let weakSelf = self else { return }
            if let error = error {
                print("Error happedned in fetch. Error: \(error.localizedDescription)")
            }
            
            if let bestSellerBooks = bestSellerBooks {
                weakSelf.books = bestSellerBooks
                weakSelf.reloadTableView()
            }
        }
    }

    private func reloadTableView() {
        DispatchQueue.main.async { [unowned self] in
            self.bestSellerView.tableView.reloadData()
        }
    }

}

// MARK: Tableview Datasource
extension BestSellerVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if books.isEmpty { return 10}
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.cellID, for: indexPath) as! BookCell
        
        if !books.isEmpty {
            let book = books[indexPath.row]
            cell.configureCell(book: book)
        }
        
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
        navigationController?.pushViewController(bestSellerDVC, animated: true)
    }
    
}

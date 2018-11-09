//
//  BestSellerView.swift
//  Books
//
//  Created by Winston Maragh on 10/18/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit

final class BestSellerView: UIView {

    lazy var orderSegmentedControl: UISegmentedControl = {
        let items = ["Rank", "Weeks on List"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = UIColor.darkGray
        return segmentedControl
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(BookCell.self, forCellReuseIdentifier: BookCell.cellID)
        return tv
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
        setupViews()
        autoConfigPrefferedOrder()
    }
    
    private func setupViews() {
        addOrderSegmentedControl()
        addTableView()
    }
    
    private func autoConfigPrefferedOrder() {
        let order = UserDefaultsService.shared.getPreferredOrder()
        orderSegmentedControl.selectedSegmentIndex = (order == PreferredOrder.weeksOnList) ? 1 : 0
    }
    
    private func addOrderSegmentedControl() {
        addSubview(orderSegmentedControl)
        orderSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            orderSegmentedControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            orderSegmentedControl.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            orderSegmentedControl.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5)
        ])
    }
    
    private func addTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: orderSegmentedControl.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

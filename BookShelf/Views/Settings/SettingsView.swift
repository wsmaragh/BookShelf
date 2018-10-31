//
//  SettingView.swift
//  BookShelf
//
//  Created by Winston Maragh on 10/19/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit

class SettingsView: UIView {
 
    static var viewID: String {
        return String(describing: self)
    }
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        return view
    }()
    
    lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.text = " Settings:  "
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
        label.layer.opacity = 1.0
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.init(red: 51/255, green: 102/255, blue: 204/255, alpha: 1.0)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.text = "Order: "
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.layer.opacity = 1.0
        label.textColor = UIColor.darkGray
        label.numberOfLines = 1
        return label
    }()
    
    lazy var orderSegmentedControl: UISegmentedControl = {
        let items = ["Rank", "Weeks on List"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        segmentedControl.tintColor = UIColor.darkGray
        return segmentedControl
    }()
    
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Done ", for: .normal)
        button.backgroundColor = UIColor.init(red: 51/255, green: 102/255, blue: 204/255, alpha: 1.0)
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
        backgroundColor = .clear
        container.layer.masksToBounds = true
        container.layer.cornerRadius = 15
        doneButton.layer.cornerRadius = 6
        doneButton.layer.masksToBounds = true
        settingsLabel.clipsToBounds = true
        settingsLabel.layer.masksToBounds = true
        setupViews()
        autoConfigPrefferedOrder()
    }
    
    private func setupViews() {
        addContainer()
        addSettingsLabel()
        addOrderSegmentedControl()
        addRankLabel()
        addDoneButton()
    }
    
    private func autoConfigPrefferedOrder() {
        let order = UserDefaultsService.shared.getPreferredOrder()
        orderSegmentedControl.selectedSegmentIndex = (order == PreferredOrder.weeksOnList) ? 1 : 0
    }
    
    
    private func addContainer() {
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 55),
            container.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            container.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            container.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1)
            ])
    }
    
    private func addSettingsLabel() {
        addSubview(settingsLabel)
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsLabel.topAnchor.constraint(equalTo: container.topAnchor),
            settingsLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            settingsLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            settingsLabel.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.15)
            ])
    }
    
    private func addOrderSegmentedControl() {
        addSubview(orderSegmentedControl)
        orderSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            orderSegmentedControl.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 16),
            orderSegmentedControl.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: 20),
            orderSegmentedControl.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.7)
            ])
    }
    
    private func addRankLabel() {
        addSubview(orderLabel)
        orderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            orderLabel.centerYAnchor.constraint(equalTo: orderSegmentedControl.centerYAnchor),
            orderLabel.trailingAnchor.constraint(equalTo: orderSegmentedControl.leadingAnchor, constant: -5)
            ])
    }
    
    private func addDoneButton() {
        addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doneButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            doneButton.centerXAnchor.constraint(equalTo: container.centerXAnchor)
            ])
    }


    
    
    
}

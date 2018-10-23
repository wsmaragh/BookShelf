//
//  SettingsVC.swift
//  BookShelf
//
//  Created by Winston Maragh on 10/19/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit


class SettingsVC: UIViewController {

    let settingsView = SettingsView()
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightText
        view.layer.opacity = 0.5
        settingsView.doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
    }
    

    
    @objc func doneButtonPressed(){
        dismiss(animated: true) {
            let orderPreferrence = self.settingsView.orderSegmentedControl.selectedSegmentIndex == 0 ? PreferredOrder.rank: PreferredOrder.weeksOnList
            UserDefaultsService.shared.setPreferredOrder(order: orderPreferrence)
        }
    }

}

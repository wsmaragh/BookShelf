//
//  UserDefaultsService.swift
//  Books
//
//  Created by Winston Maragh on 10/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation


enum PreferredOrder: String {
    case rank
    case weeksOnList
}

struct UserDefaultsService {
    
    private init() {}
    static let shared = UserDefaultsService()
    
    let defaults = UserDefaults.standard
    
    
    // Preferred Order
    private let preferredOrder = "preferredOrder"
    
    func setPreferredOrder(order: PreferredOrder){
        defaults.set(order.rawValue, forKey: preferredOrder)
    }
    
    func getPreferredOrder() -> PreferredOrder {
        guard let order = defaults.string(forKey: preferredOrder) else {
            return PreferredOrder.rank
        }
        return order == "rank" ? PreferredOrder.rank : PreferredOrder.weeksOnList
    }

    // Category
    private let categoryUpdated = "categoryUpdated"
    
    func setCategoryUpdated(date: Date){
        defaults.set(date, forKey: categoryUpdated)
    }
    
    func getCategoryUpdated() -> Date? {
        return defaults.object(forKey: categoryUpdated) as? Date
    }

}

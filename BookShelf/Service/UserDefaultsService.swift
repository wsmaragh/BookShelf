//
//  UserDefaultsService.swift
//  Books
//
//  Created by Winston Maragh on 10/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation

struct UserDefaultsService {
    
    private init() {}
    static let manager = UserDefaultsService()
    
    let savedBookCategory = "savedBookCategory"
    
    let defaults = UserDefaults.standard
    
    func setCategory(row: Int){
        defaults.set(row, forKey: savedBookCategory)
    }
    
    func getCategoryIndex() -> Int? {
        return defaults.integer(forKey: savedBookCategory)
    }

}

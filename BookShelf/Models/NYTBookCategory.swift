//
//  NYTBookCategory.swift
//  Books
//
//  Created by Winston Maragh on 10/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation

struct NYTBookCategoriesJSON: Codable {
    let results: [NYTBookCategory]
    let status: String //"OK"
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case results, status
        case count = "num_results"
    }
}

struct NYTBookCategory: Codable {
    let searchName: String
    let displayName: String
    let updated: String //"WEEKLY" or "MONTHLY"
    let lastPublishedDate: String //"2018-10-28"
    let earliestPublishedDate: String
    
    enum CodingKeys: String, CodingKey {
        case searchName = "list_name_encoded"
        case displayName = "display_name"
        case updated
        case lastPublishedDate = "newest_published_date"
        case earliestPublishedDate = "oldest_published_date"
        
    }
}

//
//  GoogleBook.swift
//  Books
//
//  Created by Winston Maragh on 10/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation

struct GoogleBookJSON: Codable {
    let items: [Items]  //.first
}

struct Items: Codable {
    let volumeInfo: GoogleBook
}

struct GoogleBook: Codable {
    let title: String?
    let longDescription: String?
    private let imageLinks: ImageLinks?
    
    var imageStr: String? {
        get{
            return imageLinks?.thumbnail
        }
        set(newValue) {
            
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case longDescription = "description"
        case imageLinks
    }
    
    init(title: String, longDescription: String, imageLinks: ImageLinks? = nil) {
        self.title = title
        self.longDescription = longDescription
        self.imageLinks = imageLinks
    }
    
}

struct ImageLinks: Codable {
    let thumbnail: String?
}

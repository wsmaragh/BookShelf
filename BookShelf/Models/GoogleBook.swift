//
//  GoogleBook.swift
//  Books
//
//  Created by Winston Maragh on 10/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation

struct GoogleBookJSON: Codable {
    let items: [Items]
}

struct Items: Codable {
    let volumeInfo: GoogleBook
}

struct GoogleBook: Codable {
    let title: String?
    let longDescription: String?
    private let imageLinks: ImageLinks?
    let publishedDate: String?
    
    var imageStr: String? {
        return imageLinks?.thumbnail
    }

    enum CodingKeys: String, CodingKey {
        case title
        case longDescription = "description"
        case imageLinks
        case publishedDate
    }
}

struct ImageLinks: Codable {
    let thumbnail: String?
}


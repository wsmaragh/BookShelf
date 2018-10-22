//
//  MasterBook.swift
//  Books
//
//  Created by Winston Maragh on 10/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation

struct MasterBook: Codable {
    
    let categoryName: String
    let rank: Int
    let weeksOnList: Int
    let amazonURLString: String
    var title: String
    var shortDescription: String
    var author: String
    var contributor: String
    var price: Double
    var publisher: String
    var isbn10: String
    var isbn13: String
    var review: String    
    var longDescription: String
    var imageStr: String
    var publishedDate: String
    
    init(nytBook: NYTBestSellerBook, googleBook: GoogleBook){
        self.categoryName = nytBook.categoryName
        self.rank = nytBook.rank
        self.weeksOnList = nytBook.weeksOnList
        self.amazonURLString = nytBook.amazonURLString
        self.title = nytBook.title
        self.shortDescription = nytBook.shortDescription
        self.author = nytBook.author
        self.contributor = nytBook.contributor
        self.price = nytBook.price
        self.publisher = nytBook.publisher
        self.isbn10 = nytBook.isbn10
        self.isbn13 = nytBook.isbn13
        self.review = nytBook.review
        self.longDescription = googleBook.longDescription ?? ""
        self.imageStr = googleBook.imageStr ?? ""
        self.publishedDate = googleBook.publishedDate ?? ""
    }
}

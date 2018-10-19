//
//  MasterBook.swift
//  Books
//
//  Created by Winston Maragh on 10/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation

struct MasterBook: Codable {
    
    //From NYTBook
    let categoryName: String
    let rank: Int
    let weeksOnList: Int
    var shortDescription: String? = ""
    let author: String
    let price: Double
    let publisher: String
    let isbn10: String
    let isbn13: String
    
    //From GoogleBook
    var title: String? = ""
    var longDescription: String? = ""
    var imageStr: String? = ""
    
    init(categoryName: String, rank: Int, weeksOnList: Int, shortDescription: String, author: String, price: Double, publisher: String, isbn10: String, isbn13: String, title: String, longDescription: String, imageStr: String){
        self.categoryName = categoryName
        self.rank = rank
        self.weeksOnList = weeksOnList
        self.shortDescription = shortDescription
        self.author = author
        self.price = price
        self.publisher = publisher
        self.isbn10 = isbn10
        self.isbn13 = isbn13
        self.title = title
        self.longDescription = longDescription
        self.imageStr = imageStr
    }
}







//
//  NYTBook.swift
//  Books
//
//  Created by Winston Maragh on 10/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation

struct NYTBookJSON: Codable {
    let results: [NYTBestSellerBook]
    let status: String //"OK"
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case results, status
        case count = "num_results"
    }
}

struct NYTBestSellerBook: Codable {
    let categoryName: String
    let rank: Int
    let weeksOnList: Int
    let amazonURLString: String
    private let bookDetails: [NYTBookDetails]
    private let reviews: [BookReviews]
    
    var title: String {
        return bookDetails[0].title
    }
    
    var shortDescription: String {
        return bookDetails[0].shortDescription
    }
    
    var author: String {
        return bookDetails[0].author
    }
    
    var contributor: String {
        return bookDetails[0].contributor
    }
    
    var price: Double {
        return bookDetails[0].price
    }
    
    var publisher: String {
        return bookDetails[0].publisher
    }
    
    var isbn10: String {
        return bookDetails[0].isbn10
    }
    
    var isbn13: String {
        return bookDetails[0].isbn13
    }
    
    var review: String {
        return reviews[0].bookReviewLink
    }
    
    enum CodingKeys: String, CodingKey {
        case categoryName = "display_name"
        case rank
        case weeksOnList = "weeks_on_list"
        case amazonURLString = "amazon_product_url"
        case bookDetails = "book_details"
        case reviews
    }
}

struct NYTBookDetails: Codable {
    let title: String
    let shortDescription: String
    let author: String
    let contributor: String
    let price: Double
    let publisher: String
    let isbn10: String
    let isbn13: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case shortDescription = "description"
        case author
        case contributor
        case price
        case publisher
        case isbn10 = "primary_isbn10"
        case isbn13 = "primary_isbn13"
    }
}

struct BookReviews: Codable {
    let bookReviewLink: String
    let firstChapterLink: String
    let sundayReviewLink: String
    let articleChapterLink: String
    
    enum CodingKeys: String, CodingKey {
        case bookReviewLink = "book_review_link"
        case firstChapterLink = "first_chapter_link"
        case sundayReviewLink = "sunday_review_link"
        case articleChapterLink = "article_chapter_link"
    }
}

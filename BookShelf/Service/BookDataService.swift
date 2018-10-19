//
//  DataService.swift
//  Books
//
//  Created by Winston Maragh on 10/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation

enum NetworkError {
    case badURL
    case other(Error)
    case badStatusCode(Int)
    case noResponse
    case couldNotParseJSON(Error)
    case noDataReceived
}


struct BookDataService {
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    
    func getBookCategories(completion: @escaping (NetworkError?, [NYTBookCategory]?)->Void) {
        
        let endpointForCategories = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(APIKeys.NYTBookApiKey)"
        
        guard let url = URL(string: endpointForCategories) else {
            completion(NetworkError.badURL, nil)
            return
        }
        
        let task =  session.dataTask(with: url, completionHandler: { (data, response, error) in
           
            if let error = error {
                completion(NetworkError.other(error), nil)
            }
                
            if let response = response {
                let statusCode = (response as! HTTPURLResponse).statusCode
                if statusCode != 200 {
                    completion(NetworkError.badStatusCode(statusCode), nil)
                    return
                }
            } else {
                completion(NetworkError.noResponse, nil)
            }
            
            
            if let data = data {
                do {
                    let categoriesJson = try JSONDecoder().decode(NYTBookCategoriesJSON.self, from: data)
                    let categoryNames = categoriesJson.results.sorted(by: {$0.displayName < $1.displayName})
                    completion(nil, categoryNames)
                } catch let jsonError {
                    completion(NetworkError.couldNotParseJSON(jsonError), nil)
                }
            } else {
                completion(NetworkError.noDataReceived, nil)
            }
            
        })
        
        task.resume()
    }
    
    
    func getBooks(fromCategory categoryName: String, completion: @escaping (Error?, [NYTBestSellerBook]?) -> Void) {
                
        let endpointForBooksInCategory = "https://api.nytimes.com/svc/books/v3/lists.json?api-key=\(APIKeys.NYTBookApiKey)&list=\(categoryName)"
        
        guard let urlForNYTBooks = URL(string: endpointForBooksInCategory) else {return}
        
        let task =  URLSession.shared.dataTask(with: urlForNYTBooks, completionHandler: { (data, response, error) in
            
            if let error = error {
                completion(error, nil)
            }
                
            else if let data = data {
                do {
                    
                    let nytBooksInCategoryJson = try JSONDecoder().decode(NYTBookJSON.self, from: data)
                    let nytBooksInCategory = nytBooksInCategoryJson.results.sorted(by: {$0.rank < $1.rank})
                    completion(nil, nytBooksInCategory)
                }
                catch {
                    print("Creating Custom Books - Decoding Error: \(error.localizedDescription)")}
            }
            
        })
        
        task.resume()
    }
    
    //    //Get GoogleBook
    //    func getGoogleBook(fromISBN isbn10: String, isbn13: String, completion: @escaping (Error?, GoogleBook?) -> Void) {
    //
    //        //        let endpoint = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn10)"
    //
    //        let endpoint = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn10)&key=\(APIKeys.GoogleBookApiKey)"
    //
    //        guard let googleBookDataUrl = URL(string: endpoint) else {return}
    //
    //        let task =  URLSession.shared.dataTask(with: googleBookDataUrl, completionHandler: { (data, response, error) in
    //
    //            if let error = error {
    //                completion(error, nil)
    //            }
    //
    //            else if let data = data {
    //                do {
    //                    let googleBookJson = try JSONDecoder().decode(GoogleBookJSON.self, from: data)
    //                    let googleBookData = googleBookJson.items[0].volumeInfo
    //                    completion(nil, googleBookData)
    //                }
    //                catch {
    //
    //                    print("Google Book - Doesnt Exist - using default info instead.  Code: \(error.localizedDescription)")
    //
    //                    let book = GoogleBook()
    //                    completion(nil, googleBookData)
    //                }
    //            }
    //
    //        })
    //
    //        task.resume()
    //    }
    
}

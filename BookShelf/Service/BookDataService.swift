//
//  DataService.swift
//  Books
//
//  Created by Winston Maragh on 10/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation
import PromiseKit

enum NetworkError {
    case badURL
    case other(Error)
    case badStatusCode(Int)
    case noResponse
    case couldNotParseJSON(Error)
    case noDataReceived
}


typealias BooksDict = [String: [NYTBestSellerBook]]

struct BookDataService {
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    
    func getBooksForAllCategories(completion: @escaping ([NYTBookCategory], BooksDict)->Void){
        var categories = [NYTBookCategory]()
        var allBooks = BooksDict()
        
        getBookCategories { (error, onlineCategories) in
            if let onlineCategories = onlineCategories {
                categories = onlineCategories
            }
        }
        
        let dispatchGroup = DispatchGroup()
        
        
        for i in 0..<categories.count {
                
            let category = categories[i]
            
            dispatchGroup.enter()
            getBooksInCategory(fromCategory: category.searchName) { (error, bestSellerBooks) in
                if let error = error {
                    print("Error happedned in fetch. Error: \(error.localizedDescription)")
                }
                
                if let bestSellerBooks = bestSellerBooks {
                    allBooks[category.searchName] = bestSellerBooks
                    print(category, " loaded")
                    dispatchGroup.leave()
                }
            }
            
        }
        
   
        dispatchGroup.notify(queue: .main) {
            print("Finished all requests.")
            completion(categories, allBooks)
        }
    }
    
    
    func getBookCategories(completion: @escaping (NetworkError?, [NYTBookCategory]?)->Void) {
        
        let endpointForCategories = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(APIKeys.NYTBookApiKey)"
        
        guard let url = URL(string: endpointForCategories) else {
            completion(NetworkError.badURL, nil)
            return
        }
        
        if let savedCategories = FileManagerService.shared.getCategories() {
            completion(nil, savedCategories)
            return
        }
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
           
            if let error = error {
                completion(NetworkError.other(error), nil)
                return
            }
                
            if let response = response {
                let statusCode = (response as! HTTPURLResponse).statusCode
                if statusCode != 200 {
                    completion(NetworkError.badStatusCode(statusCode), nil)
                    return
                }
            } else {
                completion(NetworkError.noResponse, nil)
                return
            }
            
            
            if let data = data {
                do {
                    let categoriesJson = try JSONDecoder().decode(NYTBookCategoriesJSON.self, from: data)
                    let categoryNames = categoriesJson.results.sorted(by: {$0.displayName < $1.displayName})
                    completion(nil, categoryNames)
                    FileManagerService.shared.saveCategories(categories: categoryNames)
                    return
                } catch let jsonError {
                    completion(NetworkError.couldNotParseJSON(jsonError), nil)
                    return
                }
            } else {
                completion(NetworkError.noDataReceived, nil)
                return
            }
            
        })
        
        task.resume()
    }
    
    
    func getBooksInCategory(fromCategory categoryName: String, completion: @escaping (Error?, [NYTBestSellerBook]?) -> Void) {
                
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
                } catch {
                    print()
                    print("Error decoding \(categoryName) books.")
                    print("Error: \(error.localizedDescription)")
                    print()
                }
            }
        })
        
        task.resume()
    }

    
    

    func getGoogleBook(fromISBN isbn10: String, completion: @escaping (Error?, GoogleBook?) -> Void) {
        
        let endpoint = "https://www.googleapis.com/books/v1/volumes?key=AIzaSyAfTT11DwiNy9y_6gwISzynUN_jRESns3Q&q=isbn:\(isbn10)"

        guard let googleBookDataUrl = URL(string: endpoint) else {
            print("Error getting book url")
            return
        }

        let task =  URLSession.shared.dataTask(with: googleBookDataUrl, completionHandler: { (data, response, error) in

            if let error = error {
                completion(error, nil)
            }

            else if let data = data {
                do {
                    let googleBookJson = try JSONDecoder().decode(GoogleBookJSON.self, from: data)
                    let googleBookData = googleBookJson.items[0].volumeInfo
                    completion(nil, googleBookData)
                }
                catch {
                    print("Google Book - Doesnt Exist. Error Code: \(error.localizedDescription)")
                }
            }

        })
        task.resume()
    }
    
}

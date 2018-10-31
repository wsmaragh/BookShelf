//
//  FileManagerService.swift
//  Books
//
//  Created by Winston Maragh on 10/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation
import UIKit

class FileManagerService {
    
    private init(){}
    static let shared = FileManagerService()
    
    
    static let kFavorites = "FavoriteBooks.plist"
    static let kCategories = "Categories.plist"
    static let kBooks = "Books.plist"

    
    private var categories = [NYTBookCategory]()
    private var booksDict = [String: [NYTBestSellerBook]]()
    private var favoriteBooks = [NYTBestSellerBook]() {
        didSet {
            saveFavoriteBooks()
        }
    }
    
    
    private func dataFilePath(pathName: String)->URL {
        let path = FileManagerService.shared.documentDirectory()
        return path.appendingPathComponent(pathName)
    }
    
    private func documentDirectory()->URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    


    
    private func saveFavoriteBooks(){
        do {
            let data = try PropertyListEncoder().encode(favoriteBooks)
            let path = dataFilePath(pathName: FileManagerService.kFavorites)
            try data.write(to: path, options: .atomic)
        }
        catch {print("encoder error: \(error.localizedDescription)")}
    }
    
    private func loadFavoriteBooks(){
        do {
            let path = dataFilePath(pathName: FileManagerService.kFavorites)
            let data = try Data.init(contentsOf: path)
            let savedBooks = try PropertyListDecoder().decode([NYTBestSellerBook].self, from: data)
            favoriteBooks = savedBooks
        }
        catch {print("decoder error: \(error.localizedDescription)")}
    }
    
    
    // MARK: create Book
    
    func addFavoriteBook(book: NYTBestSellerBook) {
        if favoriteBooks.contains(where: {$0.isbn10 == book.isbn10}) {
            return
        } else {
            favoriteBooks.append(book)
        }
    }
    
    func addFavoriteBook(book: NYTBestSellerBook, andImage image: UIImage) -> Bool  {
        if favoriteBooks.contains(where: {$0.isbn10 == book.isbn10}) {
            return false
        } else {
            favoriteBooks.append(book)
            saveBookImage(book: book, image: image)
            return true
        }
    }
    

    // MARK: Read Book
    
    func getFavoriteBooks() -> [NYTBestSellerBook]{
        loadFavoriteBooks()
        return favoriteBooks
    }
    
    func isBookSaved(book: NYTBestSellerBook) -> Bool {
        loadFavoriteBooks()
        if favoriteBooks.contains(where: {$0.isbn10 == book.isbn10}) {
            return true
        }
        return false
    }
    
    // MARK: Update
    
    func updateFavoriteBook(book: NYTBestSellerBook){
        //get book
        //change attributes
        //save
    }
    
    
    // MARK: Delete Book(s)
    
    func deleteFavoriteBook(book: NYTBestSellerBook) {
        if let index = favoriteBooks.index(where: { $0.isbn10 == book.isbn10 }) {
            favoriteBooks.remove(at: index )
        }
        removeBookImage(book: book)
    }
    
    func deleteAllFavoriteBooks() {
        favoriteBooks.forEach { removeBookImage(book: $0) }
        favoriteBooks.removeAll()
    }
    
    
    // MARK: Save-Delete Book Image
    
    func saveBookImage(book: NYTBestSellerBook, image: UIImage) {
        let imageData = image.pngData()
        guard let imageStr = book.imageStr else {return}
        let url = dataFilePath(pathName: imageStr)
        do {
            try imageData?.write(to: url)
        }
        catch {print(error.localizedDescription)}
    }
    
    func getBookImage(book: NYTBestSellerBook) -> UIImage? {
        do {
            guard let imageStr = book.imageStr else {return nil}
            let url = dataFilePath(pathName: imageStr)
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        }
        catch { print(error.localizedDescription); return nil}
    }
    
    func updateBookImage(book: NYTBestSellerBook) -> Bool {
        
        return false
    }
    
    private func removeBookImage(book: NYTBestSellerBook) {
        let imageURL = FileManagerService.shared.dataFilePath(pathName: "\(book.imageStr)")
        do {
            try FileManager.default.removeItem(at: imageURL)
        }
        catch {
            print(error)
        }
    }
    
    
    
    func saveUIImage(with urlStr: String, image: UIImage) {
        let imageData = image.pngData()
        let url = dataFilePath(pathName: urlStr)
        do {
            try imageData?.write(to: url)
        }
        catch {print(error)}
    }
    
    func getUIImage(with urlStr: String) -> UIImage? {
        do {
            let url = dataFilePath(pathName: urlStr)
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        }
        catch {print(error); return nil}
    }
    
    func RemoveImageFromDisk(with key: String)->Bool {
        let imageURL = FileManagerService.shared.dataFilePath(pathName: key)
        do {
            try FileManager.default.removeItem(at: imageURL)
            return true
        }
        catch {print("error removing: \(error)"); return false}
    }
    
    

    // Categories
    func saveCategories(categories: [NYTBookCategory]) {
        do {
            let data = try PropertyListEncoder().encode(categories)
            let path = dataFilePath(pathName: FileManagerService.kCategories)
            try data.write(to: path, options: .atomic)
        } catch {
            print("encoder error: \(error.localizedDescription)")
        }
    }
    
     func getCategories() -> [NYTBookCategory]? {
        do {
            let path = dataFilePath(pathName: FileManagerService.kCategories)
            let data = try Data.init(contentsOf: path)
            let savedCategories = try PropertyListDecoder().decode([NYTBookCategory].self, from: data)
            return (savedCategories)
        }
        catch {
            return (nil)
        }
    }
    
}








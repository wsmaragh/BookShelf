//
//  FileManagerService.swift
//  Books
//
//  Created by Winston Maragh on 10/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation
import UIKit

class FileManagerService{
    
    private init(){}
    static let manager = FileManagerService()
    
    static let kPathName = "FavoriteBooks.plist"
    
    private var favoriteBooks = [MasterBook]() {
        didSet {
            saveFavoriteBooks()
        }
    }
    
    func dataFilePath(pathName: String)->URL {
        let path = FileManagerService.manager.documentDirectory()
        return path.appendingPathComponent(pathName)
    }

    func documentDirectory()->URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0] //the 0 is the document folder
    }
    
    func saveFavoriteBooks(){
        do {
            let data = try PropertyListEncoder().encode(favoriteBooks)
            let path = dataFilePath(pathName: FileManagerService.kPathName)
            try data.write(to: path, options: .atomic)
        }
        catch {print("encoder error: \(error.localizedDescription)")}
    }
    
    func loadFavoriteBooks(){
        do {
            let path = dataFilePath(pathName: FileManagerService.kPathName)
            let data = try Data.init(contentsOf: path)
            let savedBooks = try PropertyListDecoder().decode([MasterBook].self, from: data)
            favoriteBooks = savedBooks
        }
        catch {print("decoder error: \(error.localizedDescription)")}
    }
    
    func addBookToFavoriteBooks(book: MasterBook) {
        if favoriteBooks.contains(where: {$0.isbn10 == book.isbn10}) {return} //do not add duplicate
        else {favoriteBooks.append(book)}
    }
    
    func addBookToFavoriteBooks(book: MasterBook, andImage image: UIImage) -> Bool  {
        if favoriteBooks.contains(where: {$0.isbn10 == book.isbn10}) {
            return false
        }
            
        else {
            favoriteBooks.append(book)
            
            guard let imageData = image.pngData() else { return false }
            let  imagePathNameURL = FileManagerService.manager.dataFilePath(pathName: "\(book.imageStr!)")
            do {
                try imageData.write(to:  imagePathNameURL); return true
            }
            catch {
                print("image saving error: \(error.localizedDescription)");
                return false
            }
        }
    }
    
    func deleteBookFromFavoriteBooks(fromIndex index: Int){
        favoriteBooks.remove(at: index)
    }
    
    func deleteFavoriteBook(fromIndex index: Int, andBookImage book: MasterBook) -> Bool {
        favoriteBooks.remove(at: index)
        let imageURL = FileManagerService.manager.dataFilePath(pathName: "\(book.imageStr!)")
        do {
            try FileManager.default.removeItem(at: imageURL)
            return true
        }
        catch {
            print("error removing: \(error.localizedDescription)")
            return false
        }
    }
    
    func deleteAllFavoriteBooks() {
        for book in favoriteBooks {
            let imageURL = FileManagerService.manager.dataFilePath(pathName: "\(book.imageStr!)")
            do {
                try FileManager.default.removeItem(at: imageURL)
            }
            catch {print("error removing: \(error.localizedDescription)")}
        }
        favoriteBooks.removeAll()
    }
    
    
    func getAllFavoriteBooks() -> [MasterBook]{
        loadFavoriteBooks()
        return favoriteBooks
    }
    
    func saveImage(with book: MasterBook, image: UIImage) {
        let imageData = image.pngData()
        let imagePathNameURL = book.imageStr?.components(separatedBy: "/").last!
        let url = dataFilePath(pathName: imagePathNameURL!)
        do {
            try imageData?.write(to: url)
        }
        catch {print(error.localizedDescription)}
    }
    
    func getImage(with book: MasterBook) -> UIImage? {
        do {
            let imagePathName =  book.imageStr?.components(separatedBy: "/").last!
            let url = dataFilePath(pathName: imagePathName!)
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        }
        catch { print(error.localizedDescription); return nil}
    }
    
}








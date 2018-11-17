//
//  ImageService.swift
//  Books
//
//  Created by Winston Maragh on 10/17/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation
import UIKit

final class ImageService {
    
    private init() {}
    static let shared = ImageService()
    
    func getImage(from urlStr: String,
                  completionHandler: @escaping (UIImage?) -> Void) {
        
        if let savedImage = FileManagerService.shared.getUIImage(with: urlStr) {
            completionHandler(savedImage)
            return
        }
        
        if let cacheImage = ImageCacheService.shared.getImageFromCache(string: urlStr) {
            completionHandler(cacheImage)
            return
        }
        
        DispatchQueue.global().async {
            guard let url = URL(string: urlStr) else {print("Bad URL used in ImageService"); return }
            guard let data = try? Data(contentsOf: url) else {return}
            guard let image = UIImage(data: data) else {return}
            ImageCacheService.shared.saveImageToCache(with: urlStr, image: image)
            completionHandler(image)
        }
    }
}


final class ImageCacheService {
    
    private init() {}
    static let shared = ImageCacheService()
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    func getImageFromCache(string: String) -> UIImage? {
        return imageCache.object(forKey: string as NSString)
    }
    
    func saveImageToCache(with urlStr: String, image: UIImage) {
        self.imageCache.setObject(image, forKey: urlStr as NSString)
    }
    
}

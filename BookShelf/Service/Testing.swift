//
//  Testing.swift
//  BookShelf
//
//  Created by Winston Maragh on 10/21/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation


////Saving UIImage To Disk, with filepath as key
//func saveUIImage(with urlStr: String, image: UIImage) {
//    let imageData = UIImagePNGRepresentation(image) //turn image to data
//    let imagePathName = urlStr.components(separatedBy: "/").last! //use url string as file name to save
//    let url = dataFilePath(pathName: imagePathName) //turn into URL
//    do {
//        try imageData?.write(to: url)
//    }
//    catch {print(error)}
//}
//
////Retrieve UIImage from Disk, with filepath as key
//func getUIImage(with urlStr: String) -> UIImage? {
//    do {
//        let imagePathName = urlStr.components(separatedBy: "/").last!
//        let url = dataFilePath(pathName: imagePathName)
//        let data = try Data(contentsOf: url)
//        return UIImage(data: data)
//    }
//    catch {print(error); return nil}
//}
//
////    Remove Image from Documents directory
//func RemoveImageFromDisk(with key: String)->Bool {
//    let imageURL = FileManagerHelper.manager.dataFilePath(pathName: key)
//    do {
//        try FileManager.default.removeItem(at: imageURL)
//        return true
//    }
//    catch {print("error removing: \(error)"); return false}
//}

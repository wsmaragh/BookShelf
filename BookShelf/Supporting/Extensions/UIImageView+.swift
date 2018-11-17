//
//  UIImageView+.swift
//  BookShelf
//
//  Created by Winston Maragh on 11/9/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit.UIImageView

extension UIImageView {
    
    func loadGif(imageURLString: String) {
        guard let image = UIImage.gifImageWithName(imageURLString) else {return}
        self.image = image
    }
    
    func loadImage(imageURLString: String?, secondaryURLStr: String?, localImageStr: String = "noImage") {
        
        if let imageStr = imageURLString {
            if imageStr.contains("http") {
                ImageService.shared.getImage(from: imageStr) { (image) in
                    
                    DispatchQueue.main.async {
                        let spinner: UIActivityIndicatorView = {
                            let spinner = UIActivityIndicatorView()
                            spinner.style = .white
                            return spinner
                        }()
                        
                        self.addSubview(spinner)
                        spinner.translatesAutoresizingMaskIntoConstraints = false
                        NSLayoutConstraint.activate([
                            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                            ])
                        
                        spinner.startAnimating()
                        spinner.isHidden = false
                        self.image = image
                        spinner.stopAnimating()
                        spinner.isHidden = true
                        return
                    }
                }
            } else if imageStr != "" {
                self.image =  UIImage(named: imageStr)
                return
            }
        }
        
        
        if let secondaryImageStr = secondaryURLStr {
            if secondaryImageStr.contains("http") {
                ImageService.shared.getImage(from: secondaryImageStr) { (image) in
                    
                    DispatchQueue.main.async {
                        let spinner: UIActivityIndicatorView = {
                            let spinner = UIActivityIndicatorView()
                            spinner.style = .white
                            return spinner
                        }()
                        
                        self.addSubview(spinner)
                        spinner.translatesAutoresizingMaskIntoConstraints = false
                        NSLayoutConstraint.activate([
                            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                            ])
                        
                        spinner.startAnimating()
                        spinner.isHidden = false
                        self.image = image
                        spinner.stopAnimating()
                        spinner.isHidden = true
                        return
                    }
                }
            } else if secondaryImageStr != "" {
                self.image =  UIImage(named: secondaryImageStr)
                return
            }
        }
        
        
        self.image = UIImage(named: localImageStr)
    }
    
}




//
//  UIColor+.swift
//  Books
//
//  Created by Winston Maragh on 10/18/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func getRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    static var randomColor: UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }
    
}

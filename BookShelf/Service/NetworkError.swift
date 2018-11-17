//
//  NetworkError.swift
//  BookShelf
//
//  Created by Winston Maragh on 11/9/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation

enum NetworkError {
    case badURL
    case other(Error)
    case badStatusCode(Int)
    case noResponse
    case couldNotParseXML(Error)
    case couldNotParseJSON(Error)
    case noDataReceived
}

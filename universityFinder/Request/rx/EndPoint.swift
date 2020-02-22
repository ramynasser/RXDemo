//
//  EndPoint.swift
//  universityFinder
//
//  Created by Ramy Nasser on 10/21/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import Foundation
enum EndPoint {
    case search
    
}
extension EndPoint {
    
    var absolutePath:String {
        switch self {
        case .search:
            return "search"
        }
    }
}


enum UrlsPath {
    case search
    
}
extension UrlsPath {
    
    var absolutePath:String {
        switch self {
        case .search:
            return "search"
        }
    }
}

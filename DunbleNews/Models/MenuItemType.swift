//
//  MenuItemType.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 14.03.2023.
//

import Foundation

enum MenuItemType {
    case home
    case search
    case discover
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .discover:
            return "Discover"
        }
    }
    
    var imageName: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .discover:
            return "safari"
        }
    }
}

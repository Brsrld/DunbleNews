//
//  Categories.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 31.03.2023.
//

import Foundation

enum NewsCategories: CaseIterable {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
    
    var title: String {
        switch self {
        case .business:
            return "Business"
        case .entertainment:
            return "Entertainment"
        case .general:
            return "General"
        case .health:
            return "Health"
        case .science:
            return "Science"
        case .sports:
            return "Sports"
        case .technology:
            return "Technology"
        }
    }
    
    var imageName:String {
        switch self {
        case .business:
            return "bs"
        case .entertainment:
            return "ent"
        case .general:
            return "gen"
        case .health:
            return "he"
        case .science:
            return "sci"
        case .sports:
            return "spr"
        case .technology:
            return "tec"
        }
    }
}

extension NewsCategories: Identifiable {
    var id: UUID {
        return UUID()
    }
}

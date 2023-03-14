//
//  Countries.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 14.03.2023.
//

import Foundation

enum Countries {
    case tr
    case us
    case de
    case fr
    case gb
    case gr
    case ru
    
    var code: String {
        switch self {
        case .tr:
            return "tr"
        case .us:
            return "us"
        case .de:
            return "de"
        case .fr:
            return "fr"
        case .gb:
            return "gb"
        case .gr:
            return "gr"
        case .ru:
            return "ru"
        }
    }
}

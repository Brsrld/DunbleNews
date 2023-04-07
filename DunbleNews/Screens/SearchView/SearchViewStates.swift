//
//  SearchViewStates.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 1.04.2023.
//

import Foundation

enum SearchViewStates: ViewStateProtocol, Equatable {
    case ready
    case loading
    case finished
    case error(error: String)
    case empty
}

//
//  SelectedDiscoverViewStates.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 31.03.2023.
//

import Foundation

enum SelectedDiscoverViewStates: ViewStateProtocol {
    case ready
    case loading
    case finished
    case error(error: String)
    case empty
}

extension SelectedDiscoverViewStates: Equatable {}

//
//  HomeViewStates.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 29.03.2023.
//

import Foundation

enum HomeViewStates: ViewStateProtocol {
case ready
case loading
case finished
case error(error: String)
}

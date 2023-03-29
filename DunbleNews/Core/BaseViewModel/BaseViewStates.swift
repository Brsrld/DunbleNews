//
//  BaseViewStates.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 29.03.2023.
//

import Foundation
 
protocol ViewStateProtocol {
    static var ready: Self { get }
}

protocol ViewStatable {
    associatedtype ViewState: ViewStatable = DefaultViewState
}

enum DefaultViewState: ViewStateProtocol {
    case ready
}

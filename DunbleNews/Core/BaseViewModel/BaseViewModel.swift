//
//  BaseViewModel.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 29.03.2023.
//

import Foundation

import Foundation

class BaseViewModel<E: ViewStateProtocol>: ObservableObject {
    @Published var states: E = .ready
    
    func changeState(_ state: E) {
        DispatchQueue.main.async { [weak self] in
            self?.states = state
            debugPrint("State changed to \(state)")
        }
    }
}

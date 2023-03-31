//
//  DiscoveryViewModel.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 31.03.2023.
//

import Foundation

final class DiscoveryViewModel: BaseViewModel<DiscoveryViewStates> {
        private(set) var defaultCategory: NewsCategories

    override init() {
        self.defaultCategory = .general
    }
}



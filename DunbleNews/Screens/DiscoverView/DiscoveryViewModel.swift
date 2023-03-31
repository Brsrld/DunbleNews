//
//  DiscoveryViewModel.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 31.03.2023.
//

import Foundation

final class DiscoveryViewModel: BaseViewModel<DiscoveryViewStates> {
    
    var defaultCategory: NewsCategories
    var allCategories: NewsCategories.AllCases
    
    override init() {
        self.defaultCategory = NewsCategories.general
        self.allCategories = NewsCategories.allCases.filter { $0.title != NewsCategories.allCases.first?.title }
    }
}



//
//  DiscoveryViewModel.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 31.03.2023.
//

import Foundation

final class DiscoverViewModel: BaseViewModel<DiscoveryViewStates> {
    
    let service: NewsServiceable
    var defaultCategory: NewsCategories
    var allCategories: NewsCategories.AllCases
    
    init(service: NewsServiceable) {
        self.defaultCategory = NewsCategories.general
        self.allCategories = NewsCategories.allCases.filter { $0.title != NewsCategories.allCases.first?.title }
        self.service = service
    }
}



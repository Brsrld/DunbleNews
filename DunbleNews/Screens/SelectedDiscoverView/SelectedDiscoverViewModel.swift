//
//  SelectedDiscoverViewModel.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 31.03.2023.
//

import Foundation

final class SelectedDiscoverViewModel: BaseViewModel<SelectedDiscoverViewStates> {
    private let service: NewsServiceable
    var showingAlert: Bool
    
    @Published private(set) var news: [Article]
    private(set) var category: NewsCategories
   
    init(category: NewsCategories, service: NewsServiceable) {
        self.service = service
        self.news = []
        self.showingAlert = false
        self.category = category
    }
    
    func serviceInitialize() {
        fetchNews()
    }
    
    func changeStateToEmpty() {
        changeState(.empty)
    }
    
    private func fetchNews() {
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service.fetchNewsByCategory(country: .us, category: category.title.lowercased())
            self.changeState(.finished)
            switch result {
            case .success(let success):
                guard let articles = success.articles else { return }
                DispatchQueue.main.async {
                    self.news = articles
                }
            case .failure(let failure):
                self.changeState(.error(error: failure.localizedDescription))
                self.showingAlert.toggle()
            }
        }
    }
}

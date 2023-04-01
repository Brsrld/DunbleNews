//
//  SearchViewModel.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 1.04.2023.
//

import Foundation

final class SearchViewModel: BaseViewModel<SearchViewStates> {
    private let service: NewsServiceable
    var showingAlert: Bool
    @Published var isloading: Bool
    @Published var searchQuery: String
    @Published private(set) var news: [Article]
   
    override init() {
        self.service = NewsService()
        self.news = []
        self.showingAlert = false
        self.isloading = false
        self.searchQuery = ""
    }
    
    func serviceInitialize() {
        fetchNews()
    }
    
    func changeStateToEmpty() {
        news = []
        changeState(.empty)
    }
    
    private func fetchNews() {
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service.fetchSearchedNews(query: searchQuery)
            self.changeState(.finished)
            switch result {
            case .success(let success):
                guard let articles = success.articles else { return }
                DispatchQueue.main.async {
                    self.news = articles
                    if articles.count < 1 {
                        self.changeState(.empty)
                    }
                }
            case .failure(let failure):
                self.changeState(.error(error: failure.localizedDescription))
                self.showingAlert.toggle()
            }
        }
    }
}

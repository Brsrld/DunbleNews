//
//  HomeViewModel.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 29.03.2023.
//

import Foundation

final class HomeViewModel: BaseViewModel<HomeViewStates> {
    private let service: NewsServiceable
    var showingAlert: Bool
    
    @Published private(set) var allNews: [Article]
    @Published var isloading:Bool = false
    
    override init() {
        self.service = NewsService()
        self.allNews = []
        self.showingAlert = false
    }
    
    func serviceInitialize() {
        fetchNews()
    }
    
    func changeStateToReady() {
        allNews = []
        changeState(.ready)
    }
    
    func loadMoreContent(item: Article?) {
        guard let lastTitle = allNews.last?.title,
        let itemTitle = item?.title else { return }
        
        if lastTitle == itemTitle {
            fetchNews()
        }
    }
    
    private func fetchNews() {
        if allNews.isEmpty {
            changeState(.loading)
        }
        Task { [weak self] in
            guard let self = self else { return }
            let result = await service.fetchAllNews(country: .us)
            changeState(.finished)
            switch result {
            case .success(let success):
                guard let articles = success.articles else { return }
                if self.allNews.isEmpty {
                    self.allNews = articles
                } else {
                    self.allNews.append(contentsOf: articles)
                }
            case .failure(let failure):
                self.changeState(.error(error: failure.localizedDescription))
                self.showingAlert.toggle()
            }
        }
    }
}

//
//  HomeViewModel.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 29.03.2023.
//

import Foundation

final class HomeViewModel: BaseViewModel<HomeViewStates> {
    private let service: NewsServiceable
    private(set) var allNews: [
        Article]
    var showingAlert: Bool
    
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
    
    private func fetchNews() {
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            let result = await service.fetchAllNews(country: .us)
            changeState(.finished)
            switch result {
            case .success(let success):
                guard let articles = success.articles else { return }
                self.allNews = articles
            case .failure(let failure):
                self.changeState(.error(error: failure.localizedDescription))
                self.showingAlert.toggle()
            }
        }
    }
}

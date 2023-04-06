//
//  HomeViewModel.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 29.03.2023.
//

import Foundation

final class HomeViewModel: BaseViewModel<HomeViewStates> {
    let service: NewsServiceable
    var showingAlert: Bool
    
    @Published private(set) var allNews: [Article]
    @Published var isloading:Bool = false
    
    init(service: NewsServiceable) {
        self.service = service
        self.allNews = []
        self.showingAlert = false
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
            let result = await self.service.fetchAllNews(country: .us)
            self.changeState(.finished)
            switch result {
            case .success(let success):
                guard let articles = success.articles else { return }
                DispatchQueue.main.async {
                    self.allNews = articles
                }
            case .failure(let failure):
                self.changeState(.error(error: failure.localizedDescription))
                self.showingAlert.toggle()
            }
        }
    }
}

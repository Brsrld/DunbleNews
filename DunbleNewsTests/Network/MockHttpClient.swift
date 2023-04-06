//
//  MockHttpClient.swift
//  DunbleNewsTests
//
//  Created by Barış ŞARALDI on 4.04.2023.
//

import Foundation
@testable import DunbleNews

final class MockHttpClient: NewsServiceable, Mockable {
    let filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    func fetchAllNews(country: DunbleNews.Countries) async -> Result<DunbleNews.ServiceModel, DunbleNews.RequestError> {
        return await loadJson(filename: filename,
                              extensionType: .json,
                              responseModel: DunbleNews.ServiceModel.self)
    }
    
    func fetchSearchedNews(query: String) async -> Result<DunbleNews.ServiceModel, DunbleNews.RequestError> {
        return await loadJson(filename: filename,
                              extensionType: .json,
                              responseModel: DunbleNews.ServiceModel.self)
    }
    
    func fetchNewsByCategory(country: DunbleNews.Countries, category: String) async -> Result<DunbleNews.ServiceModel, DunbleNews.RequestError> {
        return await loadJson(filename: filename,
                              extensionType: .json,
                              responseModel: DunbleNews.ServiceModel.self)
    }
}

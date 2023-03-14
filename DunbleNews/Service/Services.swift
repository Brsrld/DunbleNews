//
//  Services.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 14.03.2023.
//

import Foundation
import SwiftUI

protocol NewsServiceable {
    func fetchAllNews(country: Countries) async -> Result<ServiceModel, RequestError>
    func fetchSearchedNews(query: String) async -> Result<ServiceModel, RequestError>
}

struct NewsService: HTTPClient, NewsServiceable {
    func fetchSearchedNews(query: String) async -> Result<ServiceModel, RequestError> {
        return await sendRequest(endpoint: NewsEndpoint.searchNews(query: query), responseModel: ServiceModel.self)
    }
    
    func fetchAllNews(country: Countries) async -> Result<ServiceModel, RequestError> {
        return await sendRequest(endpoint: NewsEndpoint.allNews(country: .us), responseModel: ServiceModel.self)
    }
}

//
//  Endpoints.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 14.03.2023.
//

import Foundation
import SwiftUI

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "newsapi.org"
    }
}


enum NewsEndpoint {
    case allNews(country: Countries)
    case searchNews(query: String)
    case newsByCategory(category: String, country: Countries)
}

extension NewsEndpoint: Endpoint {
    var queryItems: [URLQueryItem] {
        switch self {
        case .allNews(let country):
            return [URLQueryItem(name: "country", value: country.code)]
        case .searchNews(let query):
            return [URLQueryItem(name: "q", value: query)]
        case .newsByCategory(let category, let country):
            return [URLQueryItem(name: "country", value: country.code),
                    URLQueryItem(name: "category", value: category)]
        }
    }
    
    var query: String {
        switch self {
        case .allNews(let country):
            return "country=\(country)"
        case .searchNews(let query):
            return "q=\(query)"
        case .newsByCategory(category: let category):
            return "category=\(category)"
        }
    }
    
    var path: String {
        switch self {
        case .searchNews:
            return "/v2/everything"
        case .allNews, .newsByCategory:
            return "/v2/top-headlines"
        }
    }

    var method: RequestMethod {
        switch self {
        case .allNews, .searchNews, .newsByCategory:
            return .get
        }
    }

    var header: [String : String]? {
        let accessToken = "bb69b1ef681a4120ad0bde1a1ff38530"
        
        switch self {
        case .allNews, .searchNews, .newsByCategory:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .allNews, .searchNews, .newsByCategory:
            return nil
        }
    }
}

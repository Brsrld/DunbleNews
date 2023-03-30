//
//  ServiceModel.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 14.03.2023.
//

import Foundation

// MARK: - ServiceModels
struct ServiceModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}

// MARK: - Article Extension
extension Article: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.title == rhs.title
    }
}

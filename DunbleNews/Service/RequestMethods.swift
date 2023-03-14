//
//  RequestMethods.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 14.03.2023.
//

import Foundation

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

enum DataType {
    case image
    case json
}

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    case badImage
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        case .badImage:
            return "Bad Image"
        default:
            return "Unknown error"
        }
    }
}

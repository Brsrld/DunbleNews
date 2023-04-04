//
//  MockHttpClient.swift
//  DunbleNewsTests
//
//  Created by Barış ŞARALDI on 4.04.2023.
//

import Foundation
@testable import DunbleNews

final class MockHttpClient: HTTPClient, Mockable {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        return await loadJson(filename: "News", extensionType: .json, responseModel: T.self)
    }
}

//
//  HttpClientTest.swift
//  DunbleNewsTests
//
//  Created by Barış ŞARALDI on 7.04.2023.
//

import XCTest
@testable import DunbleNews

class HttpClientTest: XCTestCase, Mockable, HTTPClient {
    var urlSession: URLSession!
    var endpoint: Endpoint!
    
    let mockString =
    """
    {
        "status": "ok",
        "totalResults": 11085,
        "articles": [
            {
                "source": {
                    "id": null,
                    "name": "Ambcrypto.com"
                },
                "author": "Ishika Kumari",
                "title": "TinyTesla (TINT): The revolutionary token electrifying the crypto world",
                "description": "Are you tired of the same old cryptocurrencies with no real-world use cases? Do you want to invest in a token that has the potential to disrupt entire industries? Look no further than TinyTesla (TINT), the revolutionary new token that’s taking the crypto worl…",
                "url": "https://ambcrypto.com/tinytesla-tint-the-revolutionary-token-electrifying-the-crypto-world-2/",
                "urlToImage": "https://statics.ambcrypto.com/wp-content/uploads/2023/04/Screenshot-2023-04-03-at-5.01.13-PM-1000x600.png",
                "publishedAt": "2023-04-03T11:45:00Z",
                "content": "Are you tired of the same old cryptocurrencies with no real-world use cases? Do you want to invest in a token that has the potential to disrupt entire industries? Look no further than TinyTesla (TINT… [+2935 chars]"
            }
        ]
    }
    """
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        urlSession = URLSession(configuration: config)
        endpoint = NewsEndpoint.allNews(country: .us)
    }
    
    override func tearDown() {
        urlSession = nil
        endpoint = nil
        super.tearDown()
    }
    
    func test_Get_Data_Success() async throws {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        
        let response = HTTPURLResponse(url: urlComponents.url!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        Task {
            let result = await sendRequest(endpoint: endpoint,
                                           responseModel: ServiceModel.self,
                                           urlSession: urlSession)
            switch result {
            case .success(let success):
                XCTAssertEqual(success.articles?.first?.title,"TinyTesla (TINT): The revolutionary token electrifying the crypto world")
                XCTAssertEqual(success.articles?.count, 1)
                expectation.fulfill()
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
        }
        await fulfillment(of: [expectation], timeout: 2)
    }
    
    func test_News_BadResponse() {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        
        let response = HTTPURLResponse(url: urlComponents.url!,
                                       statusCode: 400,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        Task {
            let result = await sendRequest(endpoint: endpoint,
                                           responseModel: ServiceModel.self,
                                           urlSession: urlSession)
            switch result {
            case .success(_):
                XCTAssertThrowsError("Fatal Error")
            case .failure(let failure):
                XCTAssertEqual(RequestError.unexpectedStatusCode, failure)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func test_News_EncodingError() {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        
        let response = HTTPURLResponse(url: urlComponents.url!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        Task {
            let result = await sendRequest(endpoint: endpoint,
                                           responseModel: [ServiceModel].self,
                                           urlSession: urlSession)
            switch result {
            case .success(_):
                XCTAssertThrowsError("Fatal Error")
            case .failure(let failure):
                XCTAssertEqual(RequestError.decode, failure)
                expectation.fulfill()
            }
        }
    }
}

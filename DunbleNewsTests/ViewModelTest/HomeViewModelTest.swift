//
//  HomeViewModelTest.swift
//  DunbleNewsTests
//
//  Created by Barış ŞARALDI on 4.04.2023.
//

import XCTest
@testable import DunbleNews

class HomeViewModelTest: XCTestCase {
    var homeViewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        
        homeViewModel = HomeViewModel(service: MockHttpClient())
    }
    
    override func tearDown() {
        homeViewModel = nil
        
        super.tearDown()
    }
    
    func test_news_Success() {
        let exp = expectValue(of: homeViewModel.$allNews.eraseToAnyPublisher(),
                              expectationDescription: "Fetched News",
                              equals: [{ $0.count == 1}])
        homeViewModel.serviceInitialize()
        wait(for: [exp.expectation], timeout: 1)
    }
}

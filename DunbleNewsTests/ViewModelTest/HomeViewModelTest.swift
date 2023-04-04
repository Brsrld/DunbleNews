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
    
    let fetchNewsExpectation = XCTestExpectation(description: "Fetched News")
    let fetchedWithErrorExpectation = XCTestExpectation(description: "Fetched Error")
    
    override func setUp() {
        super.setUp()
        
        homeViewModel = HomeViewModel(service: MockHttpClient())
    }
    
    override func tearDown() {
        homeViewModel = nil
        
        super.tearDown()
    }
    
    func test_news_Success() async {
        homeViewModel.serviceInitialize()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            XCTAssertEqual(self.homeViewModel.allNews.count, 1)
            fetchNewsExpectation.fulfill()
        }
    }
}

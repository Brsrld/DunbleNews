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
        
        homeViewModel = HomeViewModel()
    }
    
    override func tearDown() {
        homeViewModel = nil
        
        super.tearDown()
    }
    
    func test_news_Success() async {
        await homeViewModel.service.fetchAllNews(country: .us)
        await fulfillment(of: [fetchNewsExpectation])
    }
    
}

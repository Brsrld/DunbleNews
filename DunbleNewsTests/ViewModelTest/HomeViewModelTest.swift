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
    private var filename = "NewsResponse"
    let isloadingExpectation = XCTestExpectation(description: "isLoading true")
    
    override func setUp() {
        super.setUp()
        
        homeViewModel = HomeViewModel(service: MockHttpClient(filename: filename))
    }
    
    override func tearDown() {
        homeViewModel = nil
        
        super.tearDown()
    }
    
    func test_ready_State() {
        let expectation = expectValue(of: homeViewModel.$states.eraseToAnyPublisher(),
                                      expectationDescription: "is state ready",
                                      equals: [{ $0 == .ready}])
        wait(for: [expectation.expectation], timeout: 1)
    }
    
    func test_finished_State() {
        let expectation = expectValue(of: homeViewModel.$states.eraseToAnyPublisher(),
                                      expectationDescription: "is state finished",
                                      equals: [{ $0 == .finished}])
        homeViewModel.serviceInitialize()
        wait(for: [expectation.expectation], timeout: 1)
    }
    
    func test_loading_State() {
        let expectation = expectValue(of: homeViewModel.$states.eraseToAnyPublisher(),
                                      expectationDescription: "is state loading",
                                      equals: [{ $0 == .loading}])
        homeViewModel.serviceInitialize()
        wait(for: [expectation.expectation], timeout: 1)
    }
    
    func test_error_State() {
        filename = "error"
        setUp()
        let expectation = expectValue(of: homeViewModel.$states.eraseToAnyPublisher(),
                                      expectationDescription: "is state error",
                                      equals: [{ $0 == .error(error: RequestError.invalidURL.localizedDescription)}])
        homeViewModel.serviceInitialize()
        wait(for: [expectation.expectation], timeout: 1)
    }
    
    func test_ShowingAlert() {
        filename = "error"
        setUp()
        homeViewModel.serviceInitialize()
        
        let exp = homeViewModel.objectWillChange.eraseToAnyPublisher().sink { _ in
            XCTAssertEqual(self.homeViewModel.showingAlert, true)
            self.isloadingExpectation.fulfill()
        }
        wait(for: [isloadingExpectation], timeout: 1)
    }
    
    func test_empty_State() {
        let expectation = expectValue(of: homeViewModel.$states.eraseToAnyPublisher(),
                                      expectationDescription: "is state empty",
                                      equals: [{ $0 == .empty}])
        homeViewModel.changeStateToEmpty()
        wait(for: [expectation.expectation], timeout: 1)
    }
    
    
    func test_news_Success() {
        let expectation = expectValue(of: homeViewModel.$allNews.eraseToAnyPublisher(),
                                      expectationDescription: "Fetched News",
                                      equals: [{ $0.count == 1}])
        homeViewModel.serviceInitialize()
        wait(for: [expectation.expectation], timeout: 1)
    }
}

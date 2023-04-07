//
//  SearchViewModelTest.swift
//  DunbleNewsTests
//
//  Created by Barış ŞARALDI on 7.04.2023.
//

import Foundation

import XCTest
import Combine
@testable import DunbleNews

class SearchViewModelTest: XCTestCase {
    private var searchViewModel: SearchViewModel!
    
    private var filename = "NewsResponse"
    private var searchQuerySuccesses = "Half Life"
    private var searchQueryFail = " "
    
    private let searchQuerySuccessesExpectation = XCTestExpectation(description: "search query is valid")
    private let searchQueryFailExpectation = XCTestExpectation(description: "search query does not valid")
    
    override func setUp() {
        super.setUp()
        
        searchViewModel = SearchViewModel(service: MockHttpClient(filename: filename))
    }
    
    override func tearDown() {
        searchViewModel = nil
        
        super.tearDown()
    }
    
    func test_Search_Query_Valid() {
        XCTAssertEqual(searchQuerySuccesses.isValid(), false)
        searchQuerySuccessesExpectation.fulfill()
        wait(for: [searchQuerySuccessesExpectation], timeout: 1)
    }
    
    func test_Search_Query_Invalid() {
        XCTAssertEqual(searchQueryFail.isValid(), true)
        searchQueryFailExpectation.fulfill()
        wait(for: [searchQueryFailExpectation], timeout: 1)
    }
    
    func test_ready_State() {
       let expectation = expectValue(of: searchViewModel.$states.eraseToAnyPublisher(),
                                     expectationDescription: "is state ready",
                                     equals: [{ $0 == .ready}])
       wait(for: [expectation.expectation], timeout: 1)
   }
   
    func test_finished_State() {
       let expectation = expectValue(of: searchViewModel.$states.eraseToAnyPublisher(),
                                     expectationDescription: "is state finished",
                                     equals: [{ $0 == .finished}])
        searchViewModel.searchQuery = searchQuerySuccesses
        searchViewModel.checkValidation()
       wait(for: [expectation.expectation], timeout: 1)
   }
   
    func test_loading_State() {
       let expectation = expectValue(of: searchViewModel.$states.eraseToAnyPublisher(),
                                     expectationDescription: "is state loading",
                                     equals: [{ $0 == .loading}])
        searchViewModel.searchQuery = searchQuerySuccesses
        searchViewModel.checkValidation()
       wait(for: [expectation.expectation], timeout: 1)
   }
   
    func test_error_State() {
       let expectation = expectValue(of: searchViewModel.$states.eraseToAnyPublisher(),
                                     expectationDescription: "is state error",
                                     equals: [{ $0 == .error(error: "Search string not valid")}])
        searchViewModel.searchQuery = searchQueryFail
        searchViewModel.checkValidation()
       wait(for: [expectation.expectation], timeout: 1)
   }
    
    func test_empty_State() {
       let expectation = expectValue(of: searchViewModel.$states.eraseToAnyPublisher(),
                                     expectationDescription: "is state empty",
                                     equals: [{ $0 == .empty}])
       searchViewModel.changeStateToEmpty()
       wait(for: [expectation.expectation], timeout: 1)
   }
   
}

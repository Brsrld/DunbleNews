//
//  SelectedDiscoverViewModelTest.swift
//  DunbleNewsTests
//
//  Created by Barış ŞARALDI on 7.04.2023.
//

import Foundation
import XCTest
import Combine
@testable import DunbleNews

class SelectedDiscoverViewModelTest: XCTestCase {
    private var selectedDiscoverViewModel: SelectedDiscoverViewModel!
    private var cancellable: AnyCancellable?
    
    private var filename = "NewsResponse"
    private var selectedCategoryTitleSuccess = "Business"
    
    private let selectedCategorySuccessExpectation = XCTestExpectation(description: "selected category success")
    private let isloadingExpectation = XCTestExpectation(description: "isLoading true")
    
    override func setUp() {
        super.setUp()
        
        selectedDiscoverViewModel = SelectedDiscoverViewModel(category: .business,
                                                              service: MockHttpClient(filename: filename))
    }
    
    override func tearDown() {
        selectedDiscoverViewModel = nil
        
        super.tearDown()
    }
    
    func test_selected_Category_Success() {
        XCTAssertEqual(selectedDiscoverViewModel.category.title, selectedCategoryTitleSuccess)
        selectedCategorySuccessExpectation.fulfill()
        wait(for: [selectedCategorySuccessExpectation], timeout: 1)
    }
    
    func test_ready_State() {
        let expectation = expectValue(of: selectedDiscoverViewModel.$states.eraseToAnyPublisher(),
                                      expectationDescription: "is state ready",
                                      equals: [{ $0 == .ready}])
        wait(for: [expectation.expectation], timeout: 1)
    }
    
    func test_finished_State() {
        let expectation = expectValue(of: selectedDiscoverViewModel.$states.eraseToAnyPublisher(),
                                      expectationDescription: "is state finished",
                                      equals: [{ $0 == .finished}])
        selectedDiscoverViewModel.serviceInitialize()
        wait(for: [expectation.expectation], timeout: 1)
    }
    
    func test_loading_State() {
        let expectation = expectValue(of: selectedDiscoverViewModel.$states.eraseToAnyPublisher(),
                                      expectationDescription: "is state loading",
                                      equals: [{ $0 == .loading}])
        selectedDiscoverViewModel.serviceInitialize()
        wait(for: [expectation.expectation], timeout: 1)
    }
    
    func test_error_State() {
        filename = "error"
        setUp()
        
        let expectation = expectValue(of: selectedDiscoverViewModel.$states.eraseToAnyPublisher(),
                                      expectationDescription: "is state error",
                                      equals: [{ $0 == .error(error: RequestError.invalidURL.localizedDescription)}])
        selectedDiscoverViewModel.serviceInitialize()
        wait(for: [expectation.expectation], timeout: 1)
    }
    
    func test_empty_State() {
        let expectation = expectValue(of: selectedDiscoverViewModel.$states.eraseToAnyPublisher(),
                                      expectationDescription: "is state empty",
                                      equals: [{ $0 == .empty}])
        selectedDiscoverViewModel.changeStateToEmpty()
        wait(for: [expectation.expectation], timeout: 1)
    }
    
    func test_ShowingAlert() {
        filename = "error"
        setUp()
        selectedDiscoverViewModel.serviceInitialize()
        
        cancellable = selectedDiscoverViewModel.objectWillChange.eraseToAnyPublisher().sink { _ in
            XCTAssertEqual(self.selectedDiscoverViewModel.showingAlert, true)
            self.isloadingExpectation.fulfill()
        }
        wait(for: [isloadingExpectation], timeout: 1)
    }
}

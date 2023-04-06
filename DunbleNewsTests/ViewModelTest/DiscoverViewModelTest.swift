//
//  DiscoverViewModelTest.swift
//  DunbleNewsTests
//
//  Created by Barış ŞARALDI on 7.04.2023.
//

import XCTest
import Combine
@testable import DunbleNews

class DiscoverViewModelTest: XCTestCase {
    private var discoverViewModel: DiscoverViewModel!
    private var allCategories = NewsCategories.allCases.filter { $0.title != NewsCategories.allCases.first?.title }
    private var cancellable: AnyCancellable?
    
    private let defaultCategoryExpectation = XCTestExpectation(description: "is default category general")
    private let allCategoriesExpectation = XCTestExpectation(description: "all categories")
    
    override func setUp() {
        super.setUp()
        
        discoverViewModel = DiscoverViewModel()
    }
    
    override func tearDown() {
        discoverViewModel = nil
        
        super.tearDown()
    }
    
    func test_Default_Category() {
        XCTAssertEqual(self.discoverViewModel.defaultCategory, .general)
        self.defaultCategoryExpectation.fulfill()
        
        wait(for: [defaultCategoryExpectation], timeout: 1)
    }
    
    func test_All_Categories() {
        XCTAssertEqual(self.discoverViewModel.allCategories, self.allCategories)
        self.defaultCategoryExpectation.fulfill()
        wait(for: [defaultCategoryExpectation], timeout: 1)
    }
}

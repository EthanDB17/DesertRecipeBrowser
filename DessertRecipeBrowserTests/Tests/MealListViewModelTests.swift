//
//  MealListViewModelTests.swift
//  DessertRecipeBrowserTests
//
//  Created by Ethan Borrowman on 8/29/24.
//

import XCTest
@testable import DessertRecipeBrowser

final class MealListViewModelTests: XCTestCase {

    var sut: MealListViewModel!
    
    @MainActor
    func testDataResponse() async throws {
        sut = MealListViewModel(mealFetchService: MealFetchServiceMock())
        sut.fetchMealList()
        
        // Need to wait for meal fetch to complete
        try await Task.sleep(for: .seconds(0.2))
        
        guard case .loaded = sut.state else {
            XCTFail("Incorrect state")
            return
        }
        
        XCTAssert(sut.mealList.count == 5)
        XCTAssert(sut.mealList[0].id == "123")
        XCTAssert(sut.mealList.last?.id == "567")
    }
    
    @MainActor
    func testEmptyResponse() async throws {
        sut = MealListViewModel(mealFetchService: MealFetchServiceMock(responseType: .emptyData))
        sut.fetchMealList()
        
        // Need to wait for meal fetch to complete
        try await Task.sleep(for: .seconds(0.2))
        
        guard case .loaded = sut.state else {
            XCTFail("Incorrect state")
            return
        }
        
        XCTAssert(sut.mealList.isEmpty)
    }
    
    @MainActor
    func testErrorState() async throws {
        sut = MealListViewModel(mealFetchService: MealFetchServiceMock(responseType: .exception))
        sut.fetchMealList()
        
        // Need to wait for meal fetch to complete
        try await Task.sleep(for: .seconds(0.2))
        
        guard case .error(_) = sut.state else {
            XCTFail("Incorrect state")
            return
        }
        
        XCTAssert(sut.mealList.isEmpty)
    }
}

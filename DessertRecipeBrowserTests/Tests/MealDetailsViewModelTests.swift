//
//  MealDetailsViewModelTests.swift
//  DessertRecipeBrowserTests
//
//  Created by Ethan Borrowman on 8/29/24.
//

import XCTest
@testable import DessertRecipeBrowser

final class MealDetailsViewModelTests: XCTestCase {

    var sut: MealDetailsViewModel!
    
    @MainActor
    func testMealDetailsFetch() async throws {
        sut = MealDetailsViewModel(meal: .init(id: "123", meal: "Meal", thumb: "Thumb"), mealFetchService: MealFetchServiceMock())
        sut.fetchMealDetails()
        
        // Need to wait for meal fetch to complete
        try await Task.sleep(for: .seconds(0.2))
        
        guard case .loaded = sut.state else {
            XCTFail("Incorrect state")
            return
        }
        
        XCTAssertNotNil(sut.mealDetails)
        XCTAssert(sut.mealDetails?.id == "123")
        XCTAssert(sut.mealDetails?.mealName == "Apple & Blackberry Crumble")
        XCTAssert(sut.mealDetails?.ingredients.count == 3)
    }
    
    @MainActor
    func testMealDetailsException() async throws {
        sut = MealDetailsViewModel(meal: .init(id: "123", meal: "Meal", thumb: "Thumb"), mealFetchService: MealFetchServiceMock(responseType: .exception))
        sut.fetchMealDetails()
        
        // Need to wait for meal fetch to complete
        try await Task.sleep(for: .seconds(0.2))
        
        guard case .error(_) = sut.state else {
            XCTFail("Incorrect state")
            return
        }
        
        XCTAssertNil(sut.mealDetails)
    }
}

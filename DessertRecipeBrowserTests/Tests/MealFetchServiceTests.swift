//
//  MealFetchServiceTests.swift
//  DessertRecipeBrowserTests
//
//  Created by Ethan Borrowman on 8/30/24.
//

import XCTest
@testable import DessertRecipeBrowser

final class MealFetchServiceTests: XCTestCase {

    var sut: MealFetchService!
    
    func testMealListFetch() async throws {
        sut = MealFetchService(apiExecutor: APIExecutorMock(responseType: .mealList))
        do {
            let meals = try await sut.fetchMealList()
            XCTAssert(!meals.isEmpty)
            XCTAssert(meals.count == 5)
        } catch {
            XCTFail("Exception should not be thrown")
        }
    }
    
    
    func testEmptyMealListFetch() async throws {
        sut = MealFetchService(apiExecutor: APIExecutorMock(responseType: .emptyMealList))
         
        do {
            let meals = try await sut.fetchMealList()
            XCTAssert(meals.isEmpty)
        } catch {
            XCTFail("Exception should not be thrown")
        }
    }
    
    func testMealDetailsFetch() async throws {
        sut = MealFetchService(apiExecutor: APIExecutorMock(responseType: .mealDetails))
        
        do {
            let mealDetails = try await sut.fetchMealDetails(id: "123")
            XCTAssert(mealDetails.id == "1")
            XCTAssert(mealDetails.mealName == "Meal")
            XCTAssert(mealDetails.youtTube == nil)
            XCTAssert(mealDetails.ingredients.count == 2)
            XCTAssert(mealDetails.ingredients[0].index == 1)
            XCTAssert(mealDetails.ingredients[0].name == "One")
            XCTAssert(mealDetails.ingredients[0].measurement == "10")
        } catch  {
            XCTFail("Exception should not be thrown")
        }
    }
    
    func testExceptionOnFetch() async throws {
        sut = MealFetchService(apiExecutor: APIExecutorMock(responseType: .exception))
        
        do {
            let _ = try await sut.fetchMealList()
            XCTFail("An exception should have been thrown")
        } catch {
            // exception should be thrown
        }
    }
}

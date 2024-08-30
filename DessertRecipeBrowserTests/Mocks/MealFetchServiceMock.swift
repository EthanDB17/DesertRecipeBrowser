//
//  MealFetchServiceMock.swift
//  DessertRecipeBrowserTests
//
//  Created by Ethan Borrowman on 8/29/24.
//

import Foundation
@testable import DessertRecipeBrowser

/// Mock class for testing AnyMealFetchService responses
actor MealFetchServiceMock: AnyMealFetchService {
    
    /// Types of possible test responses
    enum ResponseType {
        case testData
        case emptyData
        case exception
    }
    
    /// Customizable property to determine response type
    ///
    /// Modifying this value will allow the caller of this class to
    /// test various different response types, including valid data
    /// and exceptions
    let responseType: ResponseType
    
    init(responseType: ResponseType = .testData) {
        self.responseType = responseType
    }
    
    func fetchMealList() async throws -> [Meal] {
        let meals: [Meal] = [
            .init(id: "123", meal: "Meal 1", thumb: "Meal 1 thumb"),
            .init(id: "234", meal: "Meal 2", thumb: "Meal 2 thumb"),
            .init(id: "345", meal: "Meal 3", thumb: "Meal 3 thumb"),
            .init(id: "456", meal: "Meal 4", thumb: "Meal 4 thumb"),
            .init(id: "567", meal: "Meal 5", thumb: "Meal 5 thumb")
        ]
        
        switch responseType {
        case .testData:
            return meals
        case .emptyData:
            return []
        case .exception:
            throw AppError(errorType: .missingData)
        }
    }
    
    func fetchMealDetails(id: String) async throws -> MealDetails {
        let details = MealDetails(id: "123", mealName: "Apple & Blackberry Crumble", drinkAlternate: "Test", area: "British", instructions: "", thumbImage: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg", youtube: "https://www.youtube.com/watch?v=4vhcOwVBDO4", source: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble", imageSource: nil, ingredients: [
            .init(index: 1, name: "Flour", measurement: "20g"),
            .init(index: 2, name: "Sugar", measurement: "10g"),
            .init(index: 3, name: "Eggs", measurement: "2")
            ])
        
        switch responseType {
        case .testData:
            return details
        case .exception, .emptyData:
            throw AppError(errorType: .missingData)
        }
    }
    
}

//
//  APIExecutorMock.swift
//  DessertRecipeBrowserTests
//
//  Created by Ethan Borrowman on 8/30/24.
//

import Foundation
@testable import DessertRecipeBrowser

actor APIExecutorMock: AnyAPIExecutor {
    
    /// Types of possible test responses
    enum ResponseType {
        case mealList
        case emptyMealList
        case mealDetails
        case exception
    }
    
    /// Customizable property to determine response type
    ///
    /// Modifying this value will allow the caller of this class to
    /// test various different response types, including valid data
    /// and exceptions
    let responseType: ResponseType
    
    init(responseType: ResponseType = .mealList) {
        self.responseType = responseType
    }
    
    func executeRequest(endpoint: any DessertRecipeBrowser.AnyAPIEndpoint) async throws -> Data {
        switch responseType {
        case .mealList:
            return mealListData()
        case .emptyMealList:
            return emptyMealData()
        case .mealDetails:
            return mealDetailsData()
        case .exception:
            throw AppError(errorType: .missingData)
        }
    }
    
    private func mealListData() -> Data {
        let meals: [Meal] = [
            .init(id: "1", meal: "Meal", thumb: "Thumb"),
            .init(id: "2", meal: "Meal", thumb: "Thumb"),
            .init(id: "3", meal: "Meal", thumb: "Thumb"),
            .init(id: "4", meal: "Meal", thumb: "Thumb"),
            .init(id: "5", meal: "Meal", thumb: "Thumb"),
        ]
        let mealList = MealList(meals: meals)
        let jsonData = try? JSONEncoder().encode(mealList)
        return jsonData!
    }
    
    private func emptyMealData() -> Data {
        let mealList = MealList(meals: [])
        let jsonData = try? JSONEncoder().encode(mealList)
        return jsonData!
    }
    
    private func mealDetailsData() -> Data {
        let details = APIMealDetails(idMeal: "1", strMeal: "Meal", strDrinkAlternate: nil, strArea: "US", strInstructions: "Ins", strMealThumb: "Thumb", strYoutube: nil, strIngredient1: "One", strIngredient2: "Two", strIngredient3: nil, strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: "10", strMeasure2: "20", strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil, strSource: nil, strImageSource: nil)
        let mealDetailsList = MealDetailList(meals: [details])
        
        let jsonData = try? JSONEncoder().encode(mealDetailsList)
        return jsonData!
    }
}

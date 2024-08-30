//
//  MealFetchService.swift
//  DessertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import Foundation

/// Handles calling endpoints and returning data as internal models
protocol AnyMealFetchService {
    /// Fetches list of meals from the API
    /// - returns: array of Meal objects
    /// - throws: error when fetch fails
    func fetchMealList() async throws -> [Meal]
    
    /// Fetches recipe details for a specific meal
    /// - parameter id: the id of the meal being fetched
    /// - returns: a MealDetails object
    /// - throws: error when fetch fails
    func fetchMealDetails(id: String) async throws -> MealDetails
}

actor MealFetchService: AnyMealFetchService {
    
    // MARK: - Properties -
    
    /// Service for providing the endpoints used in the API request
    private let endpointProvider: AnyEndpointProvider
    /// Service to execute API requests
    private let apiExecutor: AnyAPIExecutor
    /// Service to parse Data into models
    private let jsonDecoder: AnyJsonDecoder
    
    init(endpointProvider: AnyEndpointProvider = EndpointProvider(), apiExecutor: AnyAPIExecutor = APIExecutor(), jsonDecoder: AnyJsonDecoder = JsonDecoder()) {
        self.endpointProvider = endpointProvider
        self.apiExecutor = apiExecutor
        self.jsonDecoder = jsonDecoder
    }
    
    // MARK: - API Interaction -
    
    /// Fetches list of meals from the API
    /// - returns: array of Meal objects
    /// - throws: AppErrors returned from data fetch or parse attempts
    func fetchMealList() async throws -> [Meal] {
        let endpoint = endpointProvider.provideEndpoint(for: .allDesserts)
        
        do {
            let data = try await apiExecutor.executeRequest(endpoint: endpoint)
            let mealList: MealList = try jsonDecoder.decodeData(data)
            let sortedMeals = mealList.meals.sorted { $0.meal < $1.meal }
            return sortedMeals
        } catch {
            throw error
        }
    }
    
    /// Fetches recipe details for a specific meal
    /// - parameter id: the id of the meal being fetched
    /// - returns: a MealDetails object
    /// - throws: 
    ///     - AppErrors returned from data fetch or parse attempts
    ///     - 'AppError.missingData' if the meal details list is empty
    func fetchMealDetails(id: String) async throws -> MealDetails {
        let endpoint = endpointProvider.provideEndpoint(for: .mealDetails(id: id))
        
        do {
            let data = try await apiExecutor.executeRequest(endpoint: endpoint)
            let mealDetailsList: MealDetailList = try jsonDecoder.decodeData(data)
            guard let apiMealDetails = mealDetailsList.meals.first else {
                throw AppError(errorType: .missingData)
            }
            let mealDetails = MealDetails(apiMeal: apiMealDetails)
            return mealDetails
        } catch {
            throw error
        }
    }
}

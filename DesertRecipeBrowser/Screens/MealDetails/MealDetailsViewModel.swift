//
//  MealDetailsViewModel.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import Foundation
import Observation

@MainActor
@Observable
/// Manages the view state and meal data for teh MealDetailsView
final class MealDetailsViewModel {
    
    // MARK: - Types -
    
    /// Possible view states for MealDetailsView
    enum State {
        case loading
        case loaded
        case error(errorMessage: String)
    }
    
    // MARK: - Properties - 
    
    let meal: Meal
    let mealFetchService: AnyMealFetchService
    
    var state: State = .loading
    var mealDetails: MealDetails?
    
    init(meal: Meal, mealFetchService: AnyMealFetchService = MealFetchService()) {
        self.meal = meal
        self.mealFetchService = mealFetchService
        self.fetchMealDetails()
    }
    
    // MARK: - Data Management -
    
    /// Fetches the recipe details for a meal
    ///
    /// Function creates a task and utliized the AnyMealFetchService object to fetch
    /// the recipe details for the meal object used to initialize the class. The state is
    /// set to loaded upon a successful fetch or error if an exception is thrown
    func fetchMealDetails() {
        Task {
            do {
                let mealDetails = try await self.mealFetchService.fetchMealDetails(id: meal.id)
                await MainActor.run {
                    self.mealDetails = mealDetails
                    self.state = .loaded
                }
            } catch {
                await MainActor.run {
                    if let appError = error as? AppError {
                        self.state = .error(errorMessage: appError.errorMessage)
                    } else {
                        self.state = .error(errorMessage: error.localizedDescription)
                    }
                }
            }
        }
    }
}

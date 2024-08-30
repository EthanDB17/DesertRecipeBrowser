//
//  MealListViewModel.swift
//  DessertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import Foundation
import Observation

@MainActor
@Observable
/// Manages view state and data for MealListView
final class MealListViewModel {
    
    // MARK: - Types -
    
    /// Possible view states for the MealListView
    enum State {
        case loading
        case loaded
        case error(message: String)
    }
    
    // MARK: - Properties -
    
    let mealFetchService: AnyMealFetchService
    
    @ObservationIgnored var mealList: [Meal] = []
    var state: State = .loading
    var searchText: String = ""
    
    var filteredResults: [Meal] {
        if self.searchText.isEmpty {
            return self.mealList
        } else {
            return self.mealList.filter { $0.meal.lowercased().contains(self.searchText.lowercased()) }
        }
    }
    
    init(mealFetchService: AnyMealFetchService = MealFetchService()) {
        self.mealFetchService = mealFetchService
        
        // increase cache size to make sure all images can be cached
        URLCache.shared.memoryCapacity = 20_000_000 // ~20 MB memory space
        URLCache.shared.diskCapacity = 1_000_000_000 // ~1GB disk cache space
        
        self.fetchMealList()
    }
    
    // MARK: - Data Management -
    
    /// Fetches the list of meals to display
    ///
    /// Function creates a task and utilizes the AnyMealFetchService object to fetch
    /// the list of meals. If successful, the state value is set to loaded and the
    /// mealList array is populated. If the fetch fails, the state value is set to
    /// error and provided the message from the error that was thrown
    func fetchMealList() {
        self.state = .loading
        Task {
            do {
                let meals = try await self.mealFetchService.fetchMealList()
                await MainActor.run {
                    self.mealList = meals
                    self.state = .loaded
                }
            } catch {
                await MainActor.run {
                    if let appError = error as? AppError {
                        self.state = .error(message: appError.errorMessage)
                    } else {
                        self.state = .error(message: error.localizedDescription)
                    }
                }
            }
        }
    }
}

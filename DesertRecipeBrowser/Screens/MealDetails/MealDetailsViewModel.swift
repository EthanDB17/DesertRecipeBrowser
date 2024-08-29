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
    
    // MARK: - Properties - 
    
    let mealId: String
    let mealFetchService: AnyMealFetchService
    
    var mealDetails: MealDetails?
    
    init(mealId: String, mealFetchService: AnyMealFetchService = MealFetchService()) {
        self.mealId = mealId
        self.mealFetchService = mealFetchService
    }
}

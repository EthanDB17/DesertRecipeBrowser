//
//  ViewFactory.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import Foundation
import SwiftUI

@MainActor
/// Handles view creation for the various app routes
struct ViewFactory {
    
    /// Creates the meal details screen
    /// - parameter mealId: the id of the meal being fetched
    @ViewBuilder func mealDetailsView(meal: Meal) -> some View {
        MealDetailsView(viewModel: MealDetailsViewModel(meal: meal))
    }
}

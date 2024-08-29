//
//  MealIngredientsViewModel.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/29/24.
//

import Foundation

/// Manages the ingredient data for the MealIngredientsView
final class MealIngredientsViewModel {
    
    // MARK: - Properties -
    
    let ingredients: [Ingredient]
    
    init(ingredients: [Ingredient]) {
        self.ingredients = ingredients
    }
}

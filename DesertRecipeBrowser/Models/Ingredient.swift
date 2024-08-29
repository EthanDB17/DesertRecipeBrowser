//
//  Ingredient.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/29/24.
//

import Foundation

/// Container for ingredient information
///
/// Stores the type of ingredient, the ingredient
/// measurement, and the index the ingredient
/// appears on the recipe
struct Ingredient {
    let index: Int
    let name: String
    let measurement: String
}

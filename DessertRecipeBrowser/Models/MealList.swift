//
//  MealList.swift
//  DessertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/27/24.
//

import Foundation

/// Container used to consume the list of meals from the API
struct MealList: Codable {
    let meals: [Meal]
}

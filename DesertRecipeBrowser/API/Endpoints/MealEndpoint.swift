//
//  MealEndpoint.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/27/24.
//

import Foundation

/// Enum containing all meal endpoints used in the application
enum MealEndpoint {
    case allDesserts
    case mealDetails(id: String)
}

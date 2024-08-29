//
//  Route.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import Foundation

/// All possible navigation routes
enum Route: Hashable {
    case mealDetails(meal: Meal)
}

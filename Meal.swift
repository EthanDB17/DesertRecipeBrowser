//
//  Meal.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/27/24.
//

import Foundation

/// Lightweight object to hold the basic recipe details
struct Meal: Codable {
    let id: String
    let meal: String
    let thumb: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case meal = "strMeal"
        case thumb = "strMealThumb"
    }
}

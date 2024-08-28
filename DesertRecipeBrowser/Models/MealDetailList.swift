//
//  MealDetailList.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/27/24.
//

import Foundation

/// Container meant to consume the list of meal details from the API
struct MealDetailList: Codable {
    let meals: [APIMealDetails]
}

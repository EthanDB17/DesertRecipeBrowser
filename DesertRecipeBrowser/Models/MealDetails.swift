//
//  MealDetails.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/27/24.
//

import Foundation

/// Internal meal details object
///
/// Certain fields of the API model were renamed or consolidated
/// for easier consumption in the application
struct MealDetails {
    let id: String
    let mealName: String
    let drinkAlternate: String?
    let area: String
    let instructions: String
    let thumbImage: String?
    let youtTube: String?
    let source: String?
    let imageSource: String?
    
    /// Dictionary map of non-empty ingredient and measurement values
    /// from the API model
    let ingredientMap: [String:String]
    
    init(apiMeal: APIMealDetails) {
        self.id = apiMeal.idMeal
        self.mealName = apiMeal.strMeal
        self.drinkAlternate = apiMeal.strDrinkAlternate
        self.area = apiMeal.strArea
        self.instructions = apiMeal.strInstructions
        self.thumbImage = apiMeal.strMealThumb
        self.youtTube = apiMeal.strYoutube
        self.source = apiMeal.strSource
        self.imageSource = apiMeal.strImageSource
        
        var map: [String:String] = [:]
        if let ing = apiMeal.strIngredient1, !ing.isEmpty, let meas = apiMeal.strMeasure1, !meas.isEmpty {
            map[ing] = meas
        }
        
        if let ing2 = apiMeal.strIngredient2, !ing2.isEmpty, let meas2 = apiMeal.strMeasure2, !meas2.isEmpty {
            map[ing2] = meas2
        }

        if let ing3 = apiMeal.strIngredient3, !ing3.isEmpty, let meas3 = apiMeal.strMeasure3, !meas3.isEmpty {
            map[ing3] = meas3
        }

        if let ing4 = apiMeal.strIngredient4, !ing4.isEmpty, let meas4 = apiMeal.strMeasure4, !meas4.isEmpty {
            map[ing4] = meas4
        }

        if let ing5 = apiMeal.strIngredient5, !ing5.isEmpty, let meas5 = apiMeal.strMeasure5, !meas5.isEmpty {
            map[ing5] = meas5
        }

        if let ing6 = apiMeal.strIngredient6, !ing6.isEmpty, let meas6 = apiMeal.strMeasure6, !meas6.isEmpty {
            map[ing6] = meas6
        }

        if let ing7 = apiMeal.strIngredient7, !ing7.isEmpty, let meas7 = apiMeal.strMeasure7, !meas7.isEmpty {
            map[ing7] = meas7
        }

        if let ing8 = apiMeal.strIngredient8, !ing8.isEmpty, let meas8 = apiMeal.strMeasure8, !meas8.isEmpty {
            map[ing8] = meas8
        }

        if let ing9 = apiMeal.strIngredient9, !ing9.isEmpty, let meas9 = apiMeal.strMeasure9, !meas9.isEmpty {
            map[ing9] = meas9
        }

        if let ing10 = apiMeal.strIngredient10, !ing10.isEmpty, let meas10 = apiMeal.strMeasure10, !meas10.isEmpty {
            map[ing10] = meas10
        }

        if let ing11 = apiMeal.strIngredient11, !ing11.isEmpty, let meas11 = apiMeal.strMeasure11, !meas11.isEmpty {
            map[ing11] = meas11
        }

        if let ing12 = apiMeal.strIngredient12, !ing12.isEmpty, let meas12 = apiMeal.strMeasure12, !meas12.isEmpty {
            map[ing12] = meas12
        }

        if let ing13 = apiMeal.strIngredient13, !ing13.isEmpty, let meas13 = apiMeal.strMeasure13, !meas13.isEmpty {
            map[ing13] = meas13
        }

        if let ing14 = apiMeal.strIngredient14, !ing14.isEmpty, let meas14 = apiMeal.strMeasure14, !meas14.isEmpty {
            map[ing14] = meas14
        }

        if let ing15 = apiMeal.strIngredient15, !ing15.isEmpty, let meas15 = apiMeal.strMeasure15, !meas15.isEmpty {
            map[ing15] = meas15
        }

        if let ing16 = apiMeal.strIngredient16, !ing16.isEmpty, let meas16 = apiMeal.strMeasure16, !meas16.isEmpty {
            map[ing16] = meas16
        }

        if let ing17 = apiMeal.strIngredient17, !ing17.isEmpty, let meas17 = apiMeal.strMeasure17, !meas17.isEmpty {
            map[ing17] = meas17
        }

        if let ing18 = apiMeal.strIngredient18, !ing18.isEmpty, let meas18 = apiMeal.strMeasure18, !meas18.isEmpty {
            map[ing18] = meas18
        }

        if let ing19 = apiMeal.strIngredient19, !ing19.isEmpty, let meas19 = apiMeal.strMeasure19, !meas19.isEmpty {
            map[ing19] = meas19
        }

        if let ing20 = apiMeal.strIngredient20, !ing20.isEmpty, let meas20 = apiMeal.strMeasure20, !meas20.isEmpty {
            map[ing20] = meas20
        }

        self.ingredientMap = map
    }
}

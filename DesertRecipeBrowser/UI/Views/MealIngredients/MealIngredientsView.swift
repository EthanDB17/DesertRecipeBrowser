//
//  MealIngredientsView.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/29/24.
//

import SwiftUI

struct MealIngredientsView: View {
    
    var viewModel: MealIngredientsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(viewModel.ingredients, id: \.index) { ingredient in
                ThemedText("- \(ingredient.name): \(ingredient.measurement)", fontStyle: .headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
        }
        .background(Theme.current.primaryBackgroundColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

#Preview {
    MealIngredientsView(viewModel: MealIngredientsViewModel(ingredients: [
        .init(index: 1, name: "Plain Flour", measurement: "120g"),
        .init(index: 2, name: "Caster Sugar", measurement: "60g"),
        .init(index: 3, name: "Butter", measurement: "30g"),
        .init(index: 4, name: "Braeburn Apples", measurement: "120g"),
        .init(index: 5, name: "Demerara Sugar", measurement: "30g"),
        .init(index: 6, name: "Ice Cream", measurement: "to serve")
    ]))
}

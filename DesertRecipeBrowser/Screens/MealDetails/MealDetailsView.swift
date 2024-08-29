//
//  MealDetailsView.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import SwiftUI

@MainActor
struct MealDetailsView: View {
    
    @State var viewModel: MealDetailsViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MealDetailsView(viewModel: MealDetailsViewModel(mealId: "52893"))
}

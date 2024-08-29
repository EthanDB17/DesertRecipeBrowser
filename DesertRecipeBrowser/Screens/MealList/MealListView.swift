//
//  MealListView.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import SwiftUI

@MainActor
struct MealListView: View {
    @State var viewModel: MealListViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                loadingView()
                
            case .error(let message):
                errorView(errorMessage: message)
                
            case .loaded:
                if viewModel.mealList.isEmpty {
                    noMealsView()
                } else {
                    mealListView()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.current.primaryBackgroundColor)
        .preferredColorScheme(colorScheme)
    }
    
    @ViewBuilder private func mealListView() -> some View {

        List {
            ForEach(viewModel.mealList, id: \.id) { meal in
                MealCardView(meal: meal)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    .listRowBackground(Color.clear)
                
            }
        }
        .listStyle(.plain)
        .background(.clear)
    }
    
    @ViewBuilder private func loadingView() -> some View {
        HStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
                .tint(Theme.current.primaryFontColor)
            ThemedText("Loading Recipes...", fontStyle: .title3)
        }
    }
    
    @ViewBuilder private func errorView(errorMessage: String) -> some View {
        Button(action: {
            viewModel.fetchMealList()
        }, label: {
            VStack {
                ThemedText("An error occurred fetching the list of meals: ", fontStyle: .title3)
                ThemedText(errorMessage, fontStyle: .subheadline)
                ThemedText("Tap the screen to try again.", fontStyle: .subheadline)
                    .padding(.top, 16)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
    }
    
    @ViewBuilder private func noMealsView() -> some View {
        ContentUnavailableView("Unable to Find Meals", systemImage: "book.pages")
    }
}

#Preview {
    MealListView(viewModel: MealListViewModel())
}

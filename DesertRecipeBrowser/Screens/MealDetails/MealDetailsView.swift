//
//  MealDetailsView.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import SwiftUI

@MainActor
struct MealDetailsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var viewModel: MealDetailsViewModel
    @State var segmentSelection = 0
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                loadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded:
                if let details = viewModel.mealDetails {
                    mealDetailsView(mealDetails: details)
                }
                
            case .error(let errorMessage):
                errorView(errorMessage: errorMessage)
            }
        }
        .background(Theme.current.primaryBackgroundColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder private func mealDetailsView(mealDetails: MealDetails) -> some View {
        VStack {
            Picker(selection: $segmentSelection, label: ThemedText("Recipe")) {
                ThemedText("Overview").tag(0)
                ThemedText("Ingredients").tag(1)
                ThemedText("Instructions").tag(2)
            }
            .font(Theme.current.primaryFont(style: .body))
            .padding(.horizontal, 8)
            .background(Theme.current.primaryBackgroundColor)
            .pickerStyle(.segmented)
            
            ScrollView {
                switch segmentSelection {
                case 0:
                    MealOverviewView(viewModel: MealOverviewViewModel(mealDetails: mealDetails))
                        .padding(8)
                    
                case 1:
                    MealIngredientsView()
                    
                case 2:
                    MealInstructionsView()
                    
                default:
                    // Shouldn't get this
                    MealOverviewView(viewModel: MealOverviewViewModel(mealDetails: mealDetails))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Theme.current.primaryBackgroundColor)
        .frame(maxWidth: .infinity,  maxHeight: .infinity)
        .preferredColorScheme(colorScheme)
        .navigationTitle(viewModel.meal.meal)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder private func loadingView() -> some View {
        HStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
                .tint(Theme.current.primaryFontColor)
            ThemedText("Loading Recipe...", fontStyle: .title3)
        }
    }
    
    @ViewBuilder private func errorView(errorMessage: String) -> some View {
        RetryableErrorView(title: "An error occurred fetching the meal details:", message: errorMessage, action: {
            
        })
    }
}

#Preview {
    MealDetailsView(viewModel: MealDetailsViewModel(meal: .init(id: "52893", meal: "Apple & Blackberry Crumble", thumb: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg")))
}

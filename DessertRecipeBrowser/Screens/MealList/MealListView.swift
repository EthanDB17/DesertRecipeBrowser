//
//  MealListView.swift
//  DessertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import SwiftUI

@MainActor
struct MealListView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var viewModel: MealListViewModel
    @State var router = Router()
    
    init(viewModel: MealListViewModel) {
        self.viewModel = viewModel
        
        self.specifyUIElementFonts()
    }
    
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
        .background(Color.blue)
        .preferredColorScheme(colorScheme)
    }
    
    @ViewBuilder private func mealListView() -> some View {
        NavigationStack(path: $router.navPath) {
            List {
                if !viewModel.searchText.isEmpty, viewModel.filteredResults.isEmpty {
                    ContentUnavailableView.search
                } else {
                    ForEach(viewModel.filteredResults, id: \.id) { meal in
                        MealCardView(meal: meal)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                            .listRowBackground(Color.clear)
                            .onTapGesture {
                                router.navigate(to: Route.mealDetails(meal: meal))
                            }
                    }
                }
                
            }
            .searchable(text: $viewModel.searchText, placement: .automatic, prompt: "Search Desserts...")
            .listStyle(.plain)
            .background(Theme.current.primaryBackgroundColor)
            .navigationDestination(for: Route.self) { route in
                router.viewForRoute(route)
            }
            .navigationTitle("Dessert List")
        }
        .environment(router)
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
        RetryableErrorView(title: "An error occurred fetching the list of meals: ", message: errorMessage, action: {
            viewModel.fetchMealList()
        })
    }
    
    @ViewBuilder private func noMealsView() -> some View {
        ContentUnavailableView("Unable to Find Meals", systemImage: "book.pages")
    }
    
    /// Set navigation title fonts
    ///
    /// Make sure the navigation title uses the same font as the rest of the
    /// app when it is large and after scrolling. Use scaled fonts so the size
    /// of the font will increase and decrease dynamically to support the
    /// various accessibility text sizes
    private func specifyUIElementFonts() {
        // large title fonts
        let design = UIFontDescriptor.SystemDesign.serif
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle).withDesign(design)
        let smallDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).withDesign(design)
        if let descriptor {
            let font = UIFont(descriptor: descriptor, size: 48)
            let scaledFont = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: font)
            // set font for large title navigation bar
            UINavigationBar.appearance().largeTitleTextAttributes = [.font: scaledFont]
        }
        // body fonts
        if let smallDescriptor {
            let font = UIFont(descriptor: smallDescriptor, size: 17)
            let scaledFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
            // set font for standard nav title
            UINavigationBar.appearance().titleTextAttributes = [.font: scaledFont]
            // set font for nav back button
            UIBarButtonItem.appearance().setTitleTextAttributes([.font: scaledFont], for: .normal)
            // set font for segmentd control
            UISegmentedControl.appearance().setTitleTextAttributes([.font: scaledFont], for: .normal)
        }
    }
}

#Preview {
    MealListView(viewModel: MealListViewModel())
}

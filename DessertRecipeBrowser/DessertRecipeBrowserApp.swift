//
//  DessertRecipeBrowserApp.swift
//  DessertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/27/24.
//

import SwiftUI

@main
struct DessertRecipeBrowserApp: App {
    var body: some Scene {
        WindowGroup {
            MealListView(viewModel: MealListViewModel())
        }
    }
}

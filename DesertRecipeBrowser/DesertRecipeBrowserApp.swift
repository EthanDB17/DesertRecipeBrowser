//
//  DesertRecipeBrowserApp.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/27/24.
//

import SwiftUI

@main
struct DesertRecipeBrowserApp: App {
    var body: some Scene {
        WindowGroup {
            MealListView(viewModel: MealListViewModel())
        }
    }
}

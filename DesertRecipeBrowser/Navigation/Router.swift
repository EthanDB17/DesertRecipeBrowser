//
//  Router.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class Router {
    
    var navPath = NavigationPath()
    let factory = ViewFactory()
    
    func navigate(to route: Route) {
        navPath.append(route)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
    // MARK: - Route Building -
    
    /// Provides a view for the specified route
    /// - parameter route: the destination the user is being routed to
    @ViewBuilder func viewForRoute(_ route: Route) -> some View {
        switch route {
        case .mealDetails(let mealId):
            factory.mealDetailsView(mealId: mealId)
        }
    }
}

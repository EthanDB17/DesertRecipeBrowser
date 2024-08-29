//
//  EndpointProvider.swift
//  DessertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/27/24.
//

import Foundation

/// Service that produces an AnyAPIEndpoint object
protocol AnyEndpointProvider {
    /// Generates an AnyAPIEndpoint object
    /// - parameter endpoint: The type of endpoint that needs to be generated
    /// - returns: An AnyAPIEndpoint object built baed on the passed in endpoint
    func provideEndpoint(for endpoint: MealEndpoint) -> AnyAPIEndpoint
}

struct EndpointProvider: AnyEndpointProvider {
    
    func provideEndpoint(for endpoint: MealEndpoint) -> any AnyAPIEndpoint {
        switch endpoint {
        case .allDesserts: return APIEndpoint(endpoint: "filter.php", httpMethod: .get(parameters: ["c":"Dessert"]))
        case .mealDetails(let id): return APIEndpoint(endpoint: "lookup.php", httpMethod: .get(parameters: ["i":id]))
        }
    }
    
}

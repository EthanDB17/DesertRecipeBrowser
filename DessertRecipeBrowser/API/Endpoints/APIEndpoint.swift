//
//  APIEndpoint.swift
//  DessertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/27/24.
//

import Foundation

/// Element containing the data needed to call an API endpoint
protocol AnyAPIEndpoint {
    /// The complete url for the endpoint
    var url: String { get }
    /// The HTTP Method type for the endpoint
    var httpMethod: HttpMethodType { get }
}

struct APIEndpoint: AnyAPIEndpoint {
    private let baseUrl = "https://themealdb.com/api/json/v1/1/"
    
    let url: String
    let httpMethod: HttpMethodType
    
    init(endpoint: String, httpMethod: HttpMethodType) {
        self.url = baseUrl + endpoint
        self.httpMethod = httpMethod
    }
}

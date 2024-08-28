//
//  APIExecutor.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/27/24.
//

import Foundation

/// Executes API Requests
protocol AnyAPIExecutor {
    /// Performs an async API call for the provided endpoint
    /// - parameter endpoint: the endpoint being called
    /// - returns: the Data object returned from the endpoint
    /// - throws: errors when the URL or response is invalid
    func executeRequest(endpoint: AnyAPIEndpoint) async throws -> Data
}

actor APIExecutor: AnyAPIExecutor {
    
    /// Performs an async API call for the provided endpoint
    /// - parameter endpoint: the endpoint being called
    /// - returns: the Data object returned from the endpoint
    /// - throws:
    ///     - 'AppError.invalidUrl'
    ///     if the url provided in the endpoint parameter is invalid
    ///     - 'AppError.invalidHttpResponse'
    ///     if the status code from the response is not between 200 and 299
    ///     - 'AppError.missingData
    ///     if the data returned from the endpoint is empty
    func executeRequest(endpoint: AnyAPIEndpoint) async throws -> Data {
        guard let url = URL(string: endpoint.url) else {
            throw AppError(errorType: .invalidUrl)
        }
        
        let request: URLRequest
        do {
            switch endpoint.httpMethod {
            case .get(let parameters): request = try buildGetRequest(url: url, parameters: parameters )
            }
        } catch {
            throw error
        }
        
        let session = URLSession.shared
        
        do {
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200, httpResponse.statusCode <= 299 else {
                throw AppError(errorType: .invalidHttpResponse)
            }
            
            guard !data.isEmpty else {
                throw AppError(errorType: .missingData)
            }
            
            return data
        } catch {
            throw error
        }
    }
    
    /// Builds the URLRequest object for a GET request
    /// - parameter url: the base URL for the request
    /// - parameter parameters: an optional dictionary of query parameters to include in the request
    /// - returns: a URLRequest object built by combining the base URL with the parameters
    /// - throws: an 'AppError.invalidUrl' error if the url and parameters can't be combined into a url
    private func buildGetRequest(url: URL, parameters: [String:String]?) throws -> URLRequest {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw AppError(errorType: .invalidUrl)
        }
        
        if let parameters {
            components.queryItems = []
            for key in parameters.keys {
                components.queryItems?.append(URLQueryItem(name: key, value: parameters[key]))
            }
        }
        
        guard let componentUrl = components.url else {
            throw AppError(errorType: .invalidUrl)
        }
        
        var request = URLRequest(url: componentUrl)
        request.httpMethod = "GET"
        return request
    }
}

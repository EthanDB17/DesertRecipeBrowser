//
//  AppError.swift
//  DessertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/27/24.
//

import Foundation

/// Handles custom thrown errors in the application
struct AppError: Error {
    let errorType: AppErrorType
    
    var errorMessage: String {
        return errorType.errorMessage
    }
}

/// List of custom errors thrown in the app
enum AppErrorType {
    case invalidUrl
    case invalidHttpResponse
    case missingData
    case jsonDecodingFailed
    
    case flexible(message: String)
    
    public var errorMessage: String {
        switch self {
        case .invalidUrl: return "The URL provided is invalid."
        case .invalidHttpResponse: return "The API call returned a failure response."
        case .missingData: return "The response did not contain any data."
        case .jsonDecodingFailed: return "The data was unable to be read."
        case .flexible(let message): return message
        }
    }
}

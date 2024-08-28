//
//  HttpMethodType.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/27/24.
//

import Foundation

/// Enum containing HTTP Method Types for API requests
///
/// Currently only supporting GET requests since that is
/// the only type required for this application
enum HttpMethodType {
    case get(parameters: [String:String]?)
}

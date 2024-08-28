//
//  JsonDecoder.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import Foundation

/// Service to handle decoding data into a model
protocol AnyJsonDecoder {
    /// Decodes Data into a Decodable model
    /// - parameter data: the Data object to be decoded
    /// - returns: decoded object of type T where T
    /// - throws: exception when decoding fails
    func decodeData<T: Decodable>(_ data: Data) throws -> T
}

struct JsonDecoder: AnyJsonDecoder {
    /// Decodes Data into a Decodable model
    /// - parameter data: the Data object to be decoded
    /// - returns: decoded object of type T where T
    /// - throws: 'AppError.jsonDecodingFailed' when decoding to object of type T fails
    func decodeData<T>(_ data: Data) throws -> T where T : Decodable {
        do {
            let modelData = try JSONDecoder().decode(T.self, from: data)
            return modelData
        } catch {
            throw AppError(errorType: .jsonDecodingFailed)
        }
    }
}

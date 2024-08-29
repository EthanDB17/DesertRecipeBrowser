//
//  CachingImageDownloader.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import Foundation

protocol AnyCachingImageDownloader {
    /// Handles image downloading and fetching
    /// - parameter urlString: the image url
    /// - returns: the Data for the image
    /// - throws: - any exceptions thrown by the data fetch
    func fetchImage(urlString: String) async throws -> Data
}

actor CachingImageDownloader: AnyCachingImageDownloader {
    /// Handles image downloading and fetching
    ///
    /// If the image has not been cached, it is downloaded and cached. If it
    /// has already been cached, the cached data is returned
    ///
    /// - parameter urlString: the image url
    /// - returns: the Data for the image
    /// - throws:
    ///     - 'AppError.invalidUrl' if the url provided isn't valid
    ///     - any exceptions thrown by the data fetch
    func fetchImage(urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw AppError(errorType: .invalidUrl)
        }
        
        do {
            if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
                return cachedResponse.data
            } else {
                let (data, response) = try await URLSession.shared.data(from: url)
                URLCache.shared.storeCachedResponse(CachedURLResponse(response: response, data: data), for: URLRequest(url: url))
                return data
            }
        } catch {
            throw error
        }
    }
}

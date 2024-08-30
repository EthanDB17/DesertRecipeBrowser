//
//  CachingImageDownloaderMock.swift
//  DessertRecipeBrowserTests
//
//  Created by Ethan Borrowman on 8/30/24.
//

import Foundation
import UIKit
@testable import DessertRecipeBrowser

/// Mock class for testing async image fetch
actor CachingImageDownloaderMock: AnyCachingImageDownloader {
    
    /// Types of possible test responses
    enum ResponseType {
        case data
        case exception
    }
    
    /// Customizable property to determine response type
    ///
    /// Modifying this value will allow the caller of this class to
    /// test various different response types, including valid data
    /// and exceptions
    let responseType: ResponseType
    
    init(responseType: ResponseType = .data) {
        self.responseType = responseType
    }
    
    func fetchImage(urlString: String) async throws -> Data {
        switch self.responseType {
        case .data:
            let image = UIImage(systemName: "book.pages")!
            let data = image.pngData()!
            return data
        case .exception:
            throw AppError(errorType: .missingData)
        }
    }
    
}

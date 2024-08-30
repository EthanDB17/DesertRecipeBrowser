//
//  CachingImageDownloaderTests.swift
//  DessertRecipeBrowserTests
//
//  Created by Ethan Borrowman on 8/30/24.
//

import XCTest
@testable import DessertRecipeBrowser

final class CachingImageDownloaderTests: XCTestCase {

    let testImageURLString = "https://picsum.photos/200/300"
    var sut: CachingImageDownloader!
    
    override func setUp() async throws {
        sut = CachingImageDownloader()
    }
    
    func testImageCaching() async throws {
        do {
            let data = try await sut.fetchImage(urlString: testImageURLString)
            let image = UIImage(data: data)
            XCTAssertNotNil(image)
            
            // access image data from cache
            let urlRequest = URLRequest(url: URL(string: testImageURLString)!)
            let cachedData = URLCache.shared.cachedResponse(for: urlRequest)?.data
            XCTAssertNotNil(cachedData)
            XCTAssert(cachedData == data)
            let image2 = UIImage(data: cachedData!)
            XCTAssertNotNil(image2)
        } catch {
            XCTFail("Exception was thrown")
        }
    }
}

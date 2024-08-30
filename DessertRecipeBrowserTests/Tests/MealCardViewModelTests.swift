//
//  MealCardViewModelTests.swift
//  DessertRecipeBrowserTests
//
//  Created by Ethan Borrowman on 8/30/24.
//

import XCTest
@testable import DessertRecipeBrowser

final class MealCardViewModelTests: XCTestCase {

    var sut: MealCardViewModel!
    
    @MainActor
    func testImageFetch() async throws {
        sut = MealCardViewModel(imageUrl: "Test", imageDownloader: CachingImageDownloaderMock())
        sut.fetchImageData()
        
        // Need to wait for image fetch to complete
        try await Task.sleep(for: .seconds(0.2))
        guard let data = sut.imageData else {
            XCTFail("Image data was nil")
            return
        }
        let image = UIImage(data: data)
        XCTAssertNotNil(image)
    }
    
    @MainActor
    func testImageFetchFail() async throws {
        sut = MealCardViewModel(imageUrl: "Test", imageDownloader: CachingImageDownloaderMock(responseType: .exception))
        sut.fetchImageData()
        
        // Need to wait for image fetch to complete
        try await Task.sleep(for: .seconds(0.2))
        
        XCTAssertNil(sut.imageData)
    }
}

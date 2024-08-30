//
//  MealOverviewViewModelTests.swift
//  DessertRecipeBrowserTests
//
//  Created by Ethan Borrowman on 8/30/24.
//

import XCTest
@testable import DessertRecipeBrowser

final class MealOverviewViewModelTests: XCTestCase {

    var sut: MealOverviewViewModel!
    var mealDetails: MealDetails!
    
    @MainActor
    override func setUp() async throws {
        mealDetails = MealDetails(id: "123", mealName: "Apple & Blackberry Crumble", drinkAlternate: "Test", area: "British", instructions: "", thumbImage: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg", youtube: "https://www.youtube.com/watch?v=4vhcOwVBDO4", source: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble", imageSource: nil, ingredients: [
            .init(index: 1, name: "Flour", measurement: "20g"),
            .init(index: 2, name: "Sugar", measurement: "10g"),
            .init(index: 3, name: "Eggs", measurement: "2")
            ])
    }
        
    @MainActor
    func testImageFetch() async throws {
        sut = MealOverviewViewModel(mealDetails: mealDetails, imageDownloader: CachingImageDownloaderMock())
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
        sut = MealOverviewViewModel(mealDetails: mealDetails, imageDownloader: CachingImageDownloaderMock(responseType: .exception))
        sut.fetchImageData()
        
        // Need to wait for image fetch to complete
        try await Task.sleep(for: .seconds(0.2))
        
        XCTAssertNil(sut.imageData)
    }
    
}

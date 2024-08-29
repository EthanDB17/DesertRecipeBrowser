//
//  MealCardViewModel.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import Foundation
import Observation

@MainActor
@Observable
/// Manages the image data for the MealCardView
final class MealCardViewModel {
    
    // MARK: - Properties -
    
    let imageUrl: String
    let imageDownloader: AnyCachingImageDownloader
    
    var imageData: Data?
    
    init(imageUrl: String, imageDownloader: AnyCachingImageDownloader = CachingImageDownloader()) {
        self.imageUrl = imageUrl
        self.imageDownloader = imageDownloader
    }
    
    // MARK: - Image Fetch -
    
    /// Fetches the image data for the class imageUrl
    func fetchImageData() {
        Task {
            let data = try? await imageDownloader.fetchImage(urlString: imageUrl)
            await MainActor.run {
                self.imageData = data
            }
        }
    }
}

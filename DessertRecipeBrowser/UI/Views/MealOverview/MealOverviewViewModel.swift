//
//  MealOverviewViewModel.swift
//  DessertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/29/24.
//

import Foundation
import Observation

@MainActor
@Observable
/// Manages view data for the MealOverviewView
final class MealOverviewViewModel {
    
    // MARK: - Properties - 
    
    let mealDetails: MealDetails
    let imageDownloader: AnyCachingImageDownloader
    
    var imageData: Data?
    
    init(mealDetails: MealDetails, imageDownloader: AnyCachingImageDownloader = CachingImageDownloader()) {
        self.mealDetails = mealDetails
        self.imageDownloader = imageDownloader
    }
    
    /// Fetches the image data for the class meal
    func fetchImageData() {
        guard let thumbUrl = mealDetails.thumbImage else {
            return
        }
        
        Task {
            let data = try? await imageDownloader.fetchImage(urlString: thumbUrl)
            await MainActor.run {
                self.imageData = data
            }
        }
    }
}

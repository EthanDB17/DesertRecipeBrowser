//
//  MealCardView.swift
//  DessertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import SwiftUI
import UIKit

@MainActor
struct MealCardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var viewModel: MealCardViewModel
    
    let meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
        self.viewModel = MealCardViewModel(imageUrl: meal.thumb)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            if let data = viewModel.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65, height: 65)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 3)
            } else {
                ProgressView()
                    .scaleEffect(1.5)
                    .frame(width: 65, height: 65)
                    .tint(Theme.current.primaryFontColor)
            }
            ThemedText(meal.meal, fontStyle: .title2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(8)
        .background(Theme.current.cardBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 3)
        .preferredColorScheme(colorScheme)
        .onAppear {
            viewModel.fetchImageData()
        }
    }
}

#Preview {
    MealCardView(meal: .init(id: "234", meal: "Apple & Blackberry Crumble", thumb: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg"))
}

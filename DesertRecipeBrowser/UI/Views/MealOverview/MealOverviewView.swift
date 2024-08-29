//
//  MealOverviewView.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/29/24.
//

import SwiftUI

@MainActor
struct MealOverviewView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var viewModel: MealOverviewViewModel
    
    var body: some View {
        
        VStack(spacing: 16) {
            if viewModel.mealDetails.thumbImage != nil {
                if let data = viewModel.imageData, let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 3)
                        .frame(maxWidth: .infinity, maxHeight: 200, alignment: .leading)
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: 200, alignment: .leading)
                        .padding(.leading, 16)
                }
            }
            
            keyValueLabel(title: "Area", value: viewModel.mealDetails.area)
            if let drinkAlternate = viewModel.mealDetails.drinkAlternate {
                keyValueLabel(title: "Drink Alternate", value: drinkAlternate)
            }
            if let source = viewModel.mealDetails.source, let url = URL(string: source) {
                keyValueUrl(title: "Source", url: url)
            }
            if let youtube = viewModel.mealDetails.youtTube, let url = URL(string: youtube) {
                keyValueUrl(title: "YouTube", url: url)
            }
        }
        .background(Theme.current.primaryBackgroundColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .preferredColorScheme(colorScheme)
        .onAppear {
            viewModel.fetchImageData()
        }
    }
    
    @ViewBuilder private func keyValueLabel(title: String, value: String) -> some View {
        VStack {
            ThemedText(title + ":", fontStyle: .headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            ThemedText(value, fontStyle: .headline, fontWeight: .semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder private func keyValueUrl(title: String, url: URL) -> some View {
        VStack(alignment: .leading) {
            ThemedText(title + ":", fontStyle: .headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            Link(destination: url) {
                Text(url.absoluteString)
                    .multilineTextAlignment(.leading)
                    .font(Theme.current.primaryFont(style: .headline))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    MealOverviewView(viewModel: MealOverviewViewModel(mealDetails: MealDetails(id: "52893", mealName: "Apple & Blackberry Crumble", drinkAlternate: "Test", area: "British", instructions: "", thumbImage: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg", youtube: "https://www.youtube.com/watch?v=4vhcOwVBDO4", source: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble", imageSource: nil, ingredientMap: [:])))    
}

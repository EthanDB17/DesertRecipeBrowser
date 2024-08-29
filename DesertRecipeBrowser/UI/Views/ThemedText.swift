//
//  ThemedText.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import SwiftUI

/// Standard text element with themed font applied
struct ThemedText: View {
    @Environment(\.colorScheme) var colorScheme
    
    let text: String
    let fontStyle: Font.TextStyle
    let fontWeight: Font.Weight
    let fontColor: Color?
    
    init(_ text: String, fontStyle: Font.TextStyle = .body, fontWeight: Font.Weight = .regular, fontColor: Color? = nil) {
        self.text = text
        self.fontStyle = fontStyle
        self.fontWeight = fontWeight
        self.fontColor = fontColor
    }
    
    var body: some View {
        Text(text)
            .font(Theme.current.primaryFont(style: fontStyle))
            .fontWeight(fontWeight)
            .foregroundStyle(fontColor ?? Theme.current.primaryFontColor)
            .preferredColorScheme(colorScheme)
    }
}

#Preview {
    VStack {
        ThemedText("Regular Body Text")
        ThemedText("Semi-Bold Body Text", fontWeight: .semibold)
        ThemedText("Title Text", fontStyle: .title)
    }
    
}

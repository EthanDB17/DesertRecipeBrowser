//
//  LightTheme.swift
//  DessertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import Foundation
import SwiftUI

/// Theme values to be applied when the device is in light theme
struct LightTheme: ThemeElement {
    
    // MARK: - Background -
    
    var primaryBackgroundColor: Color {
        return Color(hex: "f4f4f4")
    }
    
    var cardBackgroundColor: Color {
        return Color(hex: "eae8e2")
    }
    
    // MARK: - Text Elements -
    
    var primaryFontColor: Color {
        return .black
    }
}

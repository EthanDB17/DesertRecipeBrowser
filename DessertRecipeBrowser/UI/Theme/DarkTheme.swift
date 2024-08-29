//
//  DarkTheme.swift
//  DessertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import Foundation
import SwiftUI

/// Theme values to be applied when the device is in dark theme
struct DarkTheme: ThemeElement {
    
    // MARK: - Background -
    
    var primaryBackgroundColor: Color {
        return Color(hex: "292a30")
    }
    
    var cardBackgroundColor: Color {
        return Color(hex: "464646")
    }
    
    // MARK: - Text Elements -
    
    var primaryFontColor: Color {
        return .white
    }
}

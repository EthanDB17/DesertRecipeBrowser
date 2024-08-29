//
//  Theme.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import Foundation
import SwiftUI

/// Protocol defining properties needed in a theme
protocol ThemeElement {
    var primaryBackgroundColor: Color { get }
    var cardBackgroundColor: Color { get }
    var primaryFontColor: Color { get }
}

/// Singelton providing access to application theme colors and fonts
struct Theme: ThemeElement {
    
    static let current = Theme()
    let lightTheme = LightTheme()
    let darkTheme = DarkTheme()
    
    private init() { }
    
    /// Provides an instance of LightTheme or DarkTheme based on the devices specified style
    private var currentTheme: ThemeElement {
        switch UITraitCollection.current.userInterfaceStyle {
        case .dark: 
            return self.darkTheme
        default: return self.lightTheme
        }
    }
    
    // MARK: - Background -
    
    /// Primary background color for app screens
    var primaryBackgroundColor: Color {
        return currentTheme.primaryBackgroundColor
    }
    
    /// Background color used for list card elements
    var cardBackgroundColor: Color {
        return currentTheme.cardBackgroundColor
    }
    
    // MARK: - Text Elements -
    
    /// Primary font color used for app Text elements
    var primaryFontColor: Color {
        return currentTheme.primaryFontColor
    }
    
    // MARK: - Font -
    
    /// Primary font used for text elements in the application
    /// - parameter style: The font style for the element
    /// - returns: a Font element using the provided style and the app's primary font design
    func primaryFont(style: Font.TextStyle) -> Font {
        return Font.system(style, design: .serif)
    }
}

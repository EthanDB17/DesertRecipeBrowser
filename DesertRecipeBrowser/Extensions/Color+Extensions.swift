//
//  Color+Extensions.swift
//  DesertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import Foundation
import SwiftUI

extension Color {
    /// Initialize a Color using a 6 or 8-digit hex string value and an opacity
    /// - parameter hex: the 6 or 8-digit hex value for the color
    /// - parameter opacity: the opacity of the color, defaulted to 1
    init(hex: String, opacity: Double = 1) {
        self.init(UIColor(hex: hex, opacity: CGFloat(opacity)))
    }
}

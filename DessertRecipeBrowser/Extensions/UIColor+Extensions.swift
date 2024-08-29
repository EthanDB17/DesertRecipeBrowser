//
//  UIColor+Extensions.swift
//  DessertRecipeBrowser
//
//  Created by Ethan Borrowman on 8/28/24.
//

import Foundation
import UIKit

extension UIColor {
    /// Initialize a UIColor using a 6 or 8-digit hex string and an opacity
    /// - parameter hex: the hex string to be converted to RBG values
    /// - parameter opacity: the opacity of the color, defaulted to 1
    public convenience init(hex: String, opacity: CGFloat = 1) {
        let r, g, b, a: CGFloat

        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hex.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
            
        if hexString.count == 8 {
            let scanner = Scanner(string: hexString)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255

                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        } else if hexString.count == 6 {
            let scanner = Scanner(string: hexString)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                b = CGFloat((hexNumber & 0x0000ff)) / 255

                self.init(red: r, green: g, blue: b, alpha: opacity)
                return
            }
        }

        // fallback color
        self.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return
    }
}

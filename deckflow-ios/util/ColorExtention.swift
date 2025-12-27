//
//  ColorExtention.swift
//  deckflow-ios
//
//  Created by shin takeuchi on 2025/12/27.
//

import SwiftUI

extension Color {
    init(hex: String, opacity: Double = 1.0) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        guard hex.count == 6 else {
            self.init(.sRGB, red: 0, green: 0, blue: 0, opacity: opacity)
            return
        }
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        guard scanner.scanHexInt64(&rgb) else {
            self.init(.sRGB, red: 0, green: 0, blue: 0, opacity: opacity)
            return
        }

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(.sRGB, red: r, green: g, blue: b, opacity: opacity)
    }
}

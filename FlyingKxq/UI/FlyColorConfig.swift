//
//  FlyColorConfig.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/17.
//

import SwiftUI

extension Color {
    static let flySecondaryBackground = Color(dynamicLight: "#F7F7F8", dark: "#1C1C1E")
    static let flyBackground = Color(dynamicLight: "#FFFFFF", dark: "#000000")
    static let flyTextGray = Color(dynamicLight: "#7F7F7F", dark: "#97989F")
    static let flyMainLight = Color(hex: "#28CCC3")
    static let flyMain = Color(hex: "#1EA59E")
    static let flyText = Color(dynamicLight: "#000000", dark: "#FFFFFF")
    static let flyDevider = Color(dynamicLight: "#F7F7F8", dark: "#1C1C1E")
    static let flyGray = Color(hex: "#B2B2B2")
    static let flyLightGray = Color(dynamicLight: "#DDDDDD", dark: "#1C1C1E")
    static let flyChipBackground = Color(dynamicLight: "#EBEDF0", dark: "#23242B")
}

fileprivate struct FlyDynamicColor {
    let light: String
    let dark: String
}

extension Color {
    // 用于防止Color -> UIColor时丢失darkColor
    private static var dynamicColorMap: [Color: FlyDynamicColor] = [:]
    
    init(dynamicLight lightHex: String, dark darkHex: String) {
        self = Color(UIColor { traitCollection in
            let lightColor = UIColor(hex: lightHex)
            let darkColor = UIColor(hex: darkHex)
            return traitCollection.userInterfaceStyle == .dark ? darkColor : lightColor
        })
        Color.dynamicColorMap[self] = FlyDynamicColor(light: lightHex, dark: darkHex)
    }
    
    func toHex(colorScheme: ColorScheme = .light) -> String? {
        if let dynamicColor = Color.dynamicColorMap[self] {
            let result = colorScheme == .dark ? dynamicColor.dark : dynamicColor.light
            return result
        }
        return nil
    }
}


//
//  Color+Config.swift
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
    static let flyDevider = Color(hex: "#D8D8D8")
}

extension Color {
    init(dynamicLight lightHex: String, dark darkHex: String) {
        self = Color(UIColor { traitCollection in
            let lightColor = UIColor(hex: lightHex)
            let darkColor = UIColor(hex: darkHex)
            return traitCollection.userInterfaceStyle == .dark ? darkColor : lightColor
        })
    }
}


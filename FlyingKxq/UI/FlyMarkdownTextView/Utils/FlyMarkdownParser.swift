//
//  FlyMarkdownParser.swift
//  FlySwiftUITest
//
//  Created by atom on 2025/4/1.
//
import Down
import SwiftUI

struct FlyMarkdownParserResult {
    let dark: NSAttributedString
    let light: NSAttributedString
}

class FlyMarkdownParser {
    private let down: Down
    private let markdown: String
    private let textColor: Color
    init(markdown: String, textColor: Color) {
        self.markdown = markdown
        down = Down(markdownString: markdown)
        self.textColor = textColor
    }
    
    func toDynamicNSAttributedString() -> FlyMarkdownParserResult {
        func generateAttributedString(colorScheme: ColorScheme) -> NSAttributedString {
            let screenWidth = UIScreen.main.bounds.width
            let textColorHex = textColor.toHex(colorScheme: colorScheme) ?? "#000000"
            let css = FlyMarkdownCSSGenerator.generateCSS(textColorHex: textColorHex, screenWidth: screenWidth)
            // 转换
            do {
                return try down.toAttributedString(stylesheet: css)
            } catch {
                return NSAttributedString(string: markdown)
            }
        }

        return FlyMarkdownParserResult(dark: generateAttributedString(colorScheme: .dark), light: generateAttributedString(colorScheme: .light))
    }
}

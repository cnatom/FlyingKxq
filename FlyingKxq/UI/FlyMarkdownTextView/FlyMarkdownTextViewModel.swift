//
//  FlyMarkdownTextViewModel.swift
//  FlySwiftUITest
//
//  Created by atom on 2025/4/1.
//

import SwiftUI

class FlyMarkdownTextViewModel: ObservableObject {
    let parser: FlyMarkdownParser
    private var cache: FlyMarkdownParserResult?

    init(markdown: String) {
        parser = FlyMarkdownParser(markdown: markdown, textColor: .flyText)
        parseAndCacheMarkdown() // 初始化时立即解析(开辟新线程)
    }

    func result(colorScheme: ColorScheme) -> NSAttributedString {
        guard let cache = cache else {
            return NSAttributedString(string: "")
        }
        switch colorScheme {
        case .light:
            return cache.light
        case .dark:
            return cache.dark
        @unknown default:
            return cache.light
        }
    }

    private func parseAndCacheMarkdown() {
        // 开一个新线程解析
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.cache = parser.toDynamicNSAttributedString()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.objectWillChange.send()
            }
        }
    }
}

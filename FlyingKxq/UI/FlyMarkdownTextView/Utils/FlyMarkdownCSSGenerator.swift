//
//  FlyMarkdownCSS.swift
//  FlySwiftUITest
//
//  Created by atom on 2025/4/1.
//
import SwiftUI
struct FlyMarkdownCSSGenerator {
    static func generateCSS(
        textColorHex: String,
        screenWidth: CGFloat
    ) -> String {
        return """
        /* 基础文本样式 */
        body {
            font-family: -apple-system, BlinkMacSystemFont;
            font-size: 17px;
            line-height: 1.6;
            color: \(textColorHex);
            width: \(screenWidth)px;
            -webkit-font-smoothing: antialiased;
            margin: 0;
            padding: 0;
        }

        /* 标题层级系统 */
        h1 {
            font-size: 34px;
            font-weight: 700;
            margin: 24px 0 16px;
            line-height: 1.2;
        }

        h1, h2, h3, h4, h5, h6 {
            color: \(textColorHex);
        }

        h2 {
            font-size: 28px;
            font-weight: 600;
            margin: 20px 0 14px;
            line-height: 1.25;
        }

        h3 {
            font-size: 22px;
            font-weight: 600;
            margin: 18px 0 12px;
            line-height: 1.3;
        }

        h4 {
            font-size: 20px;
            font-weight: 500;
            margin: 16px 0 10px;
        }

        h5 {
            font-size: 18px;
            font-weight: 500;
            margin: 14px 0 8px;
        }

        h6 {
            font-size: 16px;
            font-weight: 500;
            color: #6E6E73;
            margin: 12px 0 6px;
        }

        /* 段落与换行 */
        p {
            margin: 0 0 12px;
            word-wrap: break-word;
        }

        /* 列表系统 */
        ul, ol {
            margin: 12px 0;
            padding-left: 24px;
        }

        li {
            margin: 8px 0;
            padding-left: 4px;
        }

        ul {
            list-style-type: disc;
        }

        ol {
            list-style-type: decimal;
        }

        /* 代码块 */
        pre {
            background-color: #F5F5F7;
            border-radius: 12px;
            padding: 16px;
            margin: 16px 0;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        code {
            font-family: Menlo, Consolas, Monaco, monospace;
            font-size: 15px;
            background-color: #F5F5F7;
            padding: 2px 6px;
            border-radius: 6px;
        }

        pre code {
            background: none;
            padding: 0;
            border-radius: 0;
        }

        /* 引用块 */
        blockquote {
            border-left: 4px solid #D2D2D7;
            color: #6E6E73;
            margin: 16px 0;
            padding: 4px 0 4px 16px;
            font-style: italic;
        }

        /* 链接 */
        a {
            color: #007AFF;
            text-decoration: none;
            -webkit-tap-highlight-color: transparent;
        }

        a:active {
            opacity: 0.6;
        }

        /* 图片适配 */
        img {
            max-width: 100% !important;
            height: auto !important;
            display: block;
            margin: 24px 0;
            border-radius: 12px;
            background-color: #F5F5F7;
        }

        /* 表格系统 */
        table {
            border-collapse: collapse;
            margin: 16px 0;
            width: 100%;
        }

        th, td {
            padding: 12px;
            border: 1px solid #D2D2D7;
        }

        th {
            background-color: #F5F5F7;
            font-weight: 600;
        }

        /* 分隔线 */
        hr {
            border: none;
            border-top: 1px solid #E5E5EA;
            margin: 24px 0;
        }

        /* 强调文本 */
        strong {
            font-weight: 600;
        }

        em {
            font-style: italic;
        }

        """
    }
}

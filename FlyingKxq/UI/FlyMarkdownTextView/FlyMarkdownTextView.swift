//
//  FlyMarkdownTextView.swift
//  FlySwiftUITest
//
//  Created by atom on 2025/4/1.
//

import SwiftUI

struct FlyMarkdownTextView: View {
    @Environment(\.colorScheme) var colorScheme

    @StateObject var viewModel: FlyMarkdownTextViewModel

    init(markdown: String) {
        _viewModel = StateObject(wrappedValue: FlyMarkdownTextViewModel(markdown: markdown))
    }

    var body: some View {
        FlyUITextView(attributedText: viewModel.result(colorScheme: colorScheme))
    }
}

#Preview {
    ScrollView {
        FlyMarkdownTextView(markdown: """
        *italic*
        **bold**
        # Header 1
        ## Header 2
        ### Header 3
        #### Header 4
        ##### Header 5
        ###### Header 6
        text1 \n\n text2
        > Quote

        * List
        - List
        + List

        `code` or ```code```
        [Links](http://github.com/ivanbruel/MarkdownKit/)
        ![3123](https://cese.cumt.edu.cn/__local/2/F1/03/33FFF23A15BCD3CE42E1E931F04_2EF9B4DC_12E8BF.png)
        """)
    }
}

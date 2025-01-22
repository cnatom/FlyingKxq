//
//  FlyTextField.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/15.
//

import SwiftUI

struct FlyTextField: View {
    let placeHolderText: String
    @Binding var text: String
    init(placeHolderText: String = "请输入", text: Binding<String>) {
        self.placeHolderText = placeHolderText
        self._text = text
    }
    var body: some View {
        TextField(placeHolderText, text: $text)
            .padding(12)
            .background(Color.flySecondaryBackground)
            .cornerRadius(8)
    }
}

#Preview {
    FlyTextField(text: .constant(""))
}

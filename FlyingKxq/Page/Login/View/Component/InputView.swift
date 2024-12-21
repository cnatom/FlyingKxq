//
//  InputView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/17.
//
import SwiftUI

struct InputView: View {
    @Binding var text: String
    let textContentType: UITextContentType
    let placeHolder: String

    init(text: Binding<String> = .constant(""),
         textContentType: UITextContentType = .username,
         placeHolder: String = "用户名"
    ) {
        _text = text
        self.textContentType = textContentType
        self.placeHolder = placeHolder
    }

    var body: some View {
        Group {
            if self.textContentType == .password {
                SecureField(placeHolder, text: $text)
            } else {
                TextField(placeHolder, text: $text)
            }
        }
        .multilineTextAlignment(.center)
        .textContentType(textContentType)
        .font(.system(size: 16, weight: .medium))
        .padding(.vertical, 12)
        .background(Color.flySecondaryBackground)
        .cornerRadius(100)
    }
}

#Preview {
    InputView()
}

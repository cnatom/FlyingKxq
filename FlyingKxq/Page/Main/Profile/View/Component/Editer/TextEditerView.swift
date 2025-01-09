//
//  EditTextView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/7.
//

import SwiftUI

struct TextEditerView: View {
    @Environment(\.dismiss) var dismiss
    @State var text: String
    let appBarTitle: String
    let placeHolderText: String
    let maxLength: Int?
    let onSave: (String) -> Void
    @FocusState private var inputFocus: Bool
    init(text: String, appBarTitle: String = "", placeHolderText: String = "点击输入", maxLength: Int? = nil, onSave: @escaping (String) -> Void = { _ in }) {
        self.text = text
        self.appBarTitle = appBarTitle
        self.placeHolderText = placeHolderText
        self.onSave = onSave
        self.maxLength = maxLength
    }

    var body: some View {
        FlyScaffold {
            VStack(spacing: 12) {
                FlyAppBar(title: appBarTitle, actionView: AnyView(saveButton))
                ScrollView{
                    VStack(spacing:12) {
                        TextField(placeHolderText, text: $text)
                            .onAppear{
                                inputFocus = true
                            }
                            .focused($inputFocus)
                            .padding(12)
                            .background(Color.flySecondaryBackground)
                            .cornerRadius(8)
                            .onChange(of: text) { _ in
                                if let maxLength = maxLength {
                                    text = String(text.prefix(maxLength))
                                }
                            }
                        HStack {
                            Spacer()
                            Text(maxLength == nil ? "\(text.count) 字" : "\(text.count)/\(maxLength!)字")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(Color.flyTextGray)
                        }
                    }
                    .padding(.horizontal, 12)
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.inputFocus = false
        }
    }

    @ViewBuilder
    var saveButton: some View {
        Button(action: {
            text = text.trimmingCharacters(in: .whitespaces)
            onSave(text)
            dismiss()
        }, label: {
            Text("保存")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.flyText)
        })
    }
}

struct EditTextViewPreview: View {
    var body: some View {
        TextEditerView(text: "", appBarTitle: "编辑", maxLength: 36) { newValue in
            print(newValue)
        }
    }
}

#Preview {
    EditTextViewPreview()
}

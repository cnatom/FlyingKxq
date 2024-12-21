//
//  RegisterItemModel.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/19.
//
import SwiftUI

enum RegisterItemType {
    case Input
    case Button
}

typealias RegisterItemAction = () -> Void

class RegisterItemModel {
    let description: String         // 说明
    let type: RegisterItemType      // 类型
    let title: String               // 按钮标题或输入框提示语
    let buttonColor: Color?
    @Binding var inputText: String
    let action: RegisterItemAction?

    init(description: String,
         type: RegisterItemType,
         title: String,
         buttonColor: Color? = nil,
         inputText: Binding<String> = .constant(""),
         action: RegisterItemAction? = nil
    ) {
        self.description = description
        self.type = type
        self.title = title
        self.buttonColor = buttonColor
        self._inputText = inputText
        self.action = action
    }
}

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

class RegisterItemModel: ObservableObject {
    let description: String // 说明
    let type: RegisterItemType // 类型
    @Published var title: String // 按钮标题或输入框提示语
    @Published var value: String // 用户输入的值
    let action: (() -> Void)?
    var buttonColor: Color?

    init(description: String,
         type: RegisterItemType,
         title: String,
         value: String = "",
         buttonColor: Color? = nil,
         action: (() -> Void)? = nil
    ) {
        self.description = description
        self.type = type
        self.title = title
        self.value = value
        self.buttonColor = buttonColor
        self.action = action
    }
}

//
//  RegisterViewModel.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/19.
//

import Foundation
import SwiftUI

class RegisterViewModel: ObservableObject {
    
    @Published var schoolCertificationItem = RegisterItemModel(
        description: "请先点击下方按钮认证，证明您是矿大师生",
        type: .Button,
        title: "点我认证") {
            // 跳转到webview渲染的https://authserver.cumt.edu.cn/authserver/login页面并监听
            // 当webview的页面自动跳转到http://portal.cumt.edu.cn时
            // 退出webview，并获取webview期间所有的cookie
        }
    
    @Published var usernameItem = RegisterItemModel(
        description: "设置用户名（6-16位，英文数字下划线组成）",
        type: .Input,
        title: "用户名")

    @Published var passwordItem = RegisterItemModel(
        description: "设置密码（8-20位，无空格）",
        type: .Input,
        title: "密码")
    
    @Published var passwordConfirmItem = RegisterItemModel(
        description: "请重新输入刚刚的密码以确认",
        type: .Input,
        title: "确认密码")
    
    @Published var appleAccountBindItem = RegisterItemModel(
        description: "(可选)绑定Apple ID，下次可以直接用Apple登录",
        type: .Button,
        title: " 绑定",
        buttonColor: Color.flyText
    )
    
}

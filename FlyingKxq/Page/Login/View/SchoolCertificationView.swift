//
//  SchoolCertificationView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/19.
//

import SwiftUI

struct SchoolCertificationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let viewModel: RegisterViewModel
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        FlyScaffold {
            VStack {
                FlyAppBar(title: "认证")
                Text("在这个页面登录即可认证成功")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color.flyTextGray)
                    .padding(.vertical, 7)
                FlyWebView(url: URL(string: "https://authserver.cumt.edu.cn/authserver/login")!) { url, cookies in
                    Task {
                        let canDismiss = await viewModel.cookieHandler(url: url, cookies: cookies)
                        if canDismiss {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SchoolCertificationView(viewModel: RegisterViewModel())
}

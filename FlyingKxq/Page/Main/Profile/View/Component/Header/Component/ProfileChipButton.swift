//
//  ProfileChipButton.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/7.
//

import SwiftUI

struct ProfileChipButton: View {
    let title: String
    let primary: Bool
    let action: (() -> Void)?
    init(title: String, primary: Bool = true, action: (() -> Void)? = nil) {
        self.primary = primary
        self.title = title
        self.action = action
    }

    var body: some View {
        if let action = action {
            Button {
                action()
            } label: {
                contentView
            }
        } else {
            contentView
        }
    }

    var contentView: some View {
        Group {
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(primary ? .white : Color.flyMain)
                .padding(.vertical, 5)
                .padding(.horizontal, 15)
                .background {
                    Group {
                        if primary {
                            RoundedRectangle(cornerRadius: 100)
                        } else {
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.flyMain, lineWidth: 1)
                        }
                    }
                    .foregroundStyle(primary ? Color.flyMain : Color.clear)
                }
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    VStack {
        ProfileChipButton(title: "编辑资2222料")
        ProfileChipButton(title: "编辑资2222料", primary: false)
    }
}

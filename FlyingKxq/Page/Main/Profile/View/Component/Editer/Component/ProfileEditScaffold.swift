//
//  ProfileEditScaffold.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/9.
//

import SwiftUI

struct ProfileEditScaffold<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    let content: Content
    let onSave: () -> Void
    let title: String
    let showSaveButton: Bool
    init(title: String, showSaveButton: Bool = true, onSave: @escaping () -> Void = {}, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.onSave = onSave
        self.title = title
        self.showSaveButton = showSaveButton
    }

    var body: some View {
        FlyScaffold {
            VStack(spacing: 12) {
                FlyAppBar(title: title, actionView: showSaveButton ? AnyView(saveButton) : nil)
                content
            }
        }
    }

    @ViewBuilder
    var saveButton: some View {
        Button(action: {
            onSave()
            dismiss()
        }, label: {
            Text("保存")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.flyText)
        })
    }
}

#Preview {
    ProfileEditScaffold(title: "Hello") {
    }
}

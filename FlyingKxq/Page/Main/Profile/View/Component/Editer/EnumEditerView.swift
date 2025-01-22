//
//  EnumEditerView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/9.
//

import SwiftUI

protocol EnumEditerItemProtocol: Equatable {
    associatedtype T: Hashable
    associatedtype SelectedBody: View
    associatedtype UnselectedBody: View
    init(_ value: Self.T)
    var value: Self.T { get set }
    var selectedView: Self.SelectedBody { get }
    var unselectedView: Self.UnselectedBody { get }
}

extension EnumEditerItemProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.value == rhs.value
    }
}

struct EnumEditerView<T>: View where T: EnumEditerItemProtocol {
    @State var current: T
    let title: String
    let onSave: (T.T) -> Void
    let enums: [T]
    @Namespace var checkIconNamespace
    init(title: String, onSave: @escaping (T.T) -> Void, current: T, enums: [T.T]) {
        self.title = title
        self.onSave = onSave
        self.current = current
        self.enums = enums.map { T($0) }
    }

    var body: some View {
        ProfileEditScaffold(title: title) {
            onSave(current.value)
        } content: {
            LazyVStack(spacing: 0) {
                ForEach(enums, id: \.value) { value in
                    ZStack {
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                current = value
                            }
                        } label: {
                            Group {
                                if value == current {
                                    value.selectedView
                                } else {
                                    value.unselectedView
                                }
                            }
                            .padding(.vertical, 20)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(Color.flySecondaryBackground)
                            }
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                        }
                    }
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.flySecondaryBackground)
            }
            .padding(.horizontal, 12)
        }
    }
}

struct EnumEditerItemString: EnumEditerItemProtocol {
    var value: String
    init(_ value: String) {
        self.value = value
    }

    var selectedView: some View {
        ZStack {
            Text(value)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.flyMain)
            HStack {
                Spacer()
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .padding(.trailing,12)
            }
        }
    }

    var unselectedView: some View {
        Text(value)
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(Color.flyText)
    }
}

struct EnumEditerItemInt: EnumEditerItemProtocol {
    var value: Int
    init(_ value: Int) {
        self.value = value
    }
    var selectedView: some View{
        Text("\(value)")
            .foregroundStyle(Color.flyMain)
    }
    var unselectedView: some View{
        Text("\(value)")
            .foregroundStyle(Color.flyText)
    }
}

struct EnumEditerViewPreview: View {
    @State var currentItem: EnumEditerItemString = .init("男")
    @State var currentInt: EnumEditerItemInt = .init(1)
    var body: some View {
        VStack {
            EnumEditerView(title: "修改性别", onSave: { value in
                currentItem.value = value
            }, current: currentItem, enums: [
                "男", "女",
            ])
            EnumEditerView(title: "修改数字", onSave: { value in
                currentInt.value = value
            }, current: currentInt, enums: [
                1,2,3,4
            ])
        }
    }
}

#Preview {
    EnumEditerViewPreview()
}

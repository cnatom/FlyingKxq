//
//  FlyDialogView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/15.
//

import SwiftUI

extension View {
    func flyBaseDialog<Content: View>(
        isPresented: Binding<Bool>,
        onDismiss: @escaping () -> Void = {},
        @ViewBuilder content: () -> Content
    ) -> some View {
        modifier(FlyBaseDialogViewModifier(isPresented: isPresented, onDismiss: onDismiss, content: content()))
    }
}

struct FlyDialogExampleView: View {
    @State var showBase = false
    @State var showNestedDialog = false
    var body: some View {
        VStack {
            Text("Hello World")
            Button("toggle") {
                showBase.toggle()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color.flySecondaryBackground)
        }
        .flyBaseDialog(isPresented: $showBase, onDismiss: {
            showBase = false
        }, content: {
            VStack {
                FlyDialogHeaderView(show: $showBase, title: "标题", actionText: "确认") {
                    print("点击了确认")
                }
                Button("显示子视图") {
                    showNestedDialog.toggle()
                }
                .frame(height: 500)
            }

        })
    }
}

struct FlyBaseDialogViewModifier<ChildView: View>: ViewModifier {
    @State var offsetY = 0.0
    @Binding var show: Bool
    let view: ChildView
    @State var maxOffsetY: CGFloat = 100.0
    let onDismiss: () -> Void

    var scale: CGFloat {
        // offsetY:                             0 -> maxOffsetY
        // offsetY / maxOffsetY:                0 -> 1
        // 0.2 * (offsetY / maxOffsetY)         0.0 -> 0.2
        // 0.8 + 0.2 * (offsetY / maxOffsetY)   0.8 -> 1.0
        show ? max(0.5, min(1.0, 0.8 + 0.2 * (offsetY / maxOffsetY))) : 1.0
    }

    var backOpacity: CGFloat {
        min(0.6, 0.3 * (1 - offsetY / maxOffsetY))
    }

    init(isPresented: Binding<Bool>, onDismiss: @escaping () -> Void, content: ChildView) {
        _show = isPresented
        view = content
        self.onDismiss = onDismiss
    }

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .overlay {
                if show {
                    Spacer()
                        .background(Color.black)
                        .opacity(backOpacity)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            show = false
                            onDismiss()
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottom) {
                if show {
                    view
                        .background {
                            GeometryReader { proxy in
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(Color.flyBackground)
                                    .shadow(color: Color.flyLightGray, radius: 8)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: proxy.size.height + 400)
                                    .onAppear {
                                        maxOffsetY = proxy.size.height / 4
                                    }
                            }
                        }
                        .offset(y: offsetY)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let valueY = value.translation.height
                                    if valueY > 0 {
                                        offsetY = valueY
                                    } else {
                                        offsetY = valueY / 3
                                    }
                                }
                                .onEnded { value in
                                    let valueY = value.translation.height
                                    if valueY > maxOffsetY {
                                        offsetY = 0
                                        show = false
                                    } else {
                                        withAnimation {
                                            offsetY = 0
                                        }
                                    }
                                }
                        )
                        .transition(.move(edge: .bottom))
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .animation(.easeInOut, value: show)
            .onChange(of: scale) { newValue in
                print(newValue.description)
            }
    }
}

struct FlyDialogHeaderView: View {
    @Binding var show: Bool
    let title: String
    let cancelText: String
    let cancelTextColor: Color
    let cancel: () -> Void
    let actionText: String
    let action: () -> Void
    init(show: Binding<Bool>, title: String, cancelText: String = "取消", cancel: @escaping () -> Void = {},cancelTextColor: Color = Color.flyText, actionText: String, action: @escaping () -> Void) {
        self._show = show
        self.title = title
        self.cancelText = cancelText
        self.cancelTextColor = cancelTextColor
        self.cancel = cancel
        self.actionText = actionText
        self.action = action
    }

    var body: some View {
        HStack {
            Button {
                show = false
                cancel()
            } label: {
                Text(cancelText)
                    .foregroundStyle(cancelTextColor)
            }
            Spacer()
            Text(title)
                .foregroundStyle(Color.flyText)
            Spacer()
            Button {
                action()
            } label: {
                Text(actionText)
                    .foregroundStyle(Color.flyMain)
            }
        }
        .font(.system(size: 16, weight: .medium))
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
    }
}

#Preview {
    FlyDialogExampleView()
}

//
//  FlyDialogView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/15.
//

import SwiftUI

extension View {
    func flyNormalDialog<Content: View>(
        show: Binding<Bool>,
        title: String,
        actionText: String = "确定",
        action: @escaping () -> Void,
        @ViewBuilder view: () -> Content
    ) -> some View {
        modifier(FlyNormalDialogViewModifier(show: show, view: view(), title: title, actionText: actionText, action: action))
    }

    func flyBaseDialog<Content: View>(
        show: Binding<Bool>,
        @ViewBuilder view: () -> Content
    ) -> some View {
        modifier(FlyBaseDialogViewModifier(show: show, view: view()))
    }
}

struct FlyDialogExampleView: View {
    @State var showNormal = true
    @State var showBase = false
    var body: some View {
        VStack {
            Text("Hello World")
            Button("toggle") {
                showNormal.toggle()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color.flySecondaryBackground)
        }
        .flyNormalDialog(show: $showNormal, title: "修改状态") {
            print("Hello")
        } view: {
            Text("Hello")
                .frame(height: 200)
                .frame(maxWidth: .infinity)
        }
    }
}

struct FlyNormalDialogViewModifier<ChildView: View>: ViewModifier {
    @Binding var show: Bool
    let view: ChildView
    let title: String
    let actionText: String
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .flyBaseDialog(show: $show) {
                VStack {
                    HStack {
                        Button {
                            show = false
                        } label: {
                            Text("取消")
                                .foregroundStyle(Color.flyText)
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
                    view
                }
            }
    }
}

struct FlyBaseDialogViewModifier<ChildView: View>: ViewModifier {
    @State var offsetY = 0.0
    @Binding var show: Bool
    let view: ChildView
    @State var maxOffsetY: CGFloat = 0.0

    var scale: CGFloat {
        // offsetY:                             0 -> maxOffsetY
        // offsetY / maxOffsetY:                0 -> 1
        // 0.2 * (offsetY / maxOffsetY)         0.0 -> 0.2
        // 0.8 + 0.2 * (offsetY / maxOffsetY)   0.8 -> 1.0
        show ? min(1.0, 0.8 + 0.2 * (offsetY / maxOffsetY)) : 1.0
    }

    var backOpacity: CGFloat {
        min(0.6, 0.3 * (1 - offsetY / maxOffsetY))
    }

    init(show: Binding<Bool>, view: ChildView) {
        _show = show
        self.view = view
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
    }
}

#Preview {
    FlyDialogExampleView()
}

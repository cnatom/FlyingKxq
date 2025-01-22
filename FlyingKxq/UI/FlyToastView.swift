//
//  FlyToastView.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/9.
//

import SwiftUI

extension View {
    func flyToast(text: String?) -> some View {
        return modifier(FlyToastViewModifier(show: Binding(get: {
            text != nil
        }, set: { _ in
        }), text: text ?? "", type: .success, alignment: .top, duration: .seconds(2)))
    }

    func flyToast(
        show: Binding<Bool>,
        text: String,
        type: FlyToastViewType = .normal,
        alignment: Alignment = .top,
        duration: DispatchTimeInterval = .seconds(3)
    ) -> some View {
        let duration = type == .loading ? .never : duration
        return modifier(FlyToastViewModifier(show: show, text: text, type: type, alignment: alignment, duration: duration))
    }

    func flyToastLoading(
        loading: Binding<Bool>,
        loadSuccess: Bool,
        loadingText: String = "加载中……",
        successText: String = "加载成功",
        errorText: String = "加载失败",
        closeDelay: DispatchTimeInterval = .seconds(2)
    ) -> some View {
        return modifier(FlyToastViewModifier(loading: loading, loadSuccess: loadSuccess, loadingText: loadingText, successText: successText, errorText: errorText, closeDelay: closeDelay))
    }
}

enum FlyToastViewType {
    case success
    case error
    case warning
    case normal
    case loading
}

struct FlyToastIconView: View {
    let type: FlyToastViewType
    private var iconName: String {
        switch type {
        case .success:
            "checkmark"
        case .error:
            "xmark"
        case .warning:
            "exclamationmark"
        case .normal:
            "exclamationmark"
        case .loading:
            ""
        }
    }

    private var color: Color {
        switch type {
        case .success:
            Color.green
        case .error:
            Color.red
        case .warning:
            Color.orange
        case .normal:
            Color.blue
        case .loading:
            Color.clear
        }
    }

    var body: some View {
        if type == .loading {
            ProgressView()
                .frame(width: 20, height: 20)
        } else {
            RoundedRectangle(cornerRadius: 100)
                .fill(color)
                .frame(width: 20, height: 20)
                .mask {
                    Circle()
                        .overlay(
                            Image(systemName: iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .blendMode(.destinationOut) // 抠出对号区域
                        )
                }
        }
    }
}

struct FlyToastViewModifier: ViewModifier {
    @Binding var tempShow: Bool
    @State var realShow: Bool = false
    let delayClose: Bool
    @State private var offsetY: CGFloat = 0
    @State private var offsetX: CGFloat = 0
    private let text: String
    private let alignment: Alignment
    private let maxOffsetY = 20.0
    var type: FlyToastViewType
    private let duration: DispatchTimeInterval
    init(show: Binding<Bool>, text: String, type: FlyToastViewType, alignment: Alignment, duration: DispatchTimeInterval) {
        _tempShow = show
        realShow = show.wrappedValue
        self.text = text
        self.alignment = alignment
        self.type = type
        self.duration = duration
        delayClose = false
    }

    init(loading: Binding<Bool>, loadSuccess: Bool, loadingText: String, successText: String, errorText: String, closeDelay: DispatchTimeInterval) {
        type = .loading
        duration = closeDelay
        if loading.wrappedValue {
            text = loadingText
        } else {
            if loadSuccess {
                text = successText
                type = .success
            } else {
                text = errorText
                type = .error
            }
        }
        _tempShow = loading
        alignment = .top
        delayClose = true
    }

    func body(content: Content) -> some View {
        content
            .onChange(of: tempShow) {
                if $0 {
                    realShow = $0 // 立即显示
                    // 非loading延迟自动关闭
                    if type != .loading && !delayClose {
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation {
                                tempShow = false
                            }
                        }
                    }
                } else {
                    // 延迟关闭
                    if delayClose {
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation {
                                realShow = false
                            }
                        }
                    } else {
                        realShow = false
                    }
                }
            }
            .overlay(alignment: alignment) {
                if realShow {
                    HStack {
                        FlyToastIconView(type: type)
                        Text(text)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(Color.flyText)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 100)
                            .foregroundStyle(Color.flyBackground)
                            .overlay {
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.flySecondaryBackground, lineWidth: 2)
                            }
                    }
                    .padding(.horizontal, 12)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .opacity(offsetY > 0 ? 1.0 : max(1 - abs(offsetY / maxOffsetY), 0.8))
                    .offset(x: offsetX, y: offsetY)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                offsetY = value.translation.height
                                offsetX = value.translation.width
                            }
                            .onEnded({ value in
                                if value.translation.height < -maxOffsetY && type != .loading {
                                    realShow = false
                                    tempShow = false
                                    offsetY = 0
                                    offsetX = 0
                                } else {
                                    withAnimation {
                                        offsetY = 0
                                        offsetX = 0
                                    }
                                }
                            })
                    )
                }
            }
            .animation(.easeInOut, value: realShow)
            .animation(.easeInOut, value: text)
            .animation(.easeInOut, value: type)
    }
}

struct FlyToastViewExample: View {
    @State var showLoading = false
    @State var showSuccess = false
    @State var showError = false
    @State var showWarning = false
    @State var showNormal = false

    @State var loading = false
    @State var loadSuccess = false
    @State var randomResult = false

    func loadData() async -> Bool {
        loading = true
        randomResult.toggle()
        try? await Task.sleep(nanoseconds: 1000000000)
        loading = false
        return randomResult
    }

    var body: some View {
        VStack(spacing: 20) {
            Button("加载中") {
                showLoading.toggle()
            }
            Button("成功") {
                showSuccess.toggle()
            }
            Button("失败") {
                showError.toggle()
            }
            Button("警告") {
                showWarning.toggle()
            }
            Button("消息") {
                showNormal.toggle()
            }
            Divider()
            Button("加载异步操作") {
                Task {
                    loadSuccess = await loadData()
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .flyToast(show: $showLoading, text: "加载中", type: .loading)
        .flyToast(show: $showSuccess, text: "成功", type: .success)
        .flyToast(show: $showError, text: "失败", type: .error)
        .flyToast(show: $showWarning, text: "警告", type: .warning)
        .flyToast(show: $showNormal, text: "普通消息", type: .normal)
        .flyToastLoading(loading: $loading, loadSuccess: loadSuccess, successText: "加载成功！", errorText: "加载失败")
    }
}

#Preview {
    FlyToastViewExample()
}

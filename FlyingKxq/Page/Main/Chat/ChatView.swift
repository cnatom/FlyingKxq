//
//  ChatView.swift
//  FlyingKxq
//
//  Created by atom on 2024/12/23.
//

import SwiftUI

/// 聊天主视图
/// 包含侧边栏（聊天历史）和主聊天区域
struct ChatView: View {
    /// 视图模型，管理所有状态和业务逻辑
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    // MARK: - 顶栏
                    ChatTopBar(
                        onMenuTap: {
                            viewModel.toggleSidebar()
                        },
                        onNewChat: {
                            viewModel.createNewChat()
                        },
                        title: "ChatGPT 4.0"
                    )
                    
                    // MARK: - 主聊天区域
                    if viewModel.messages.isEmpty {
                        EmptyChatView()
                            .frame(width: geometry.size.width)
                    } else {
                        ChatArea(
                            messages: viewModel.messages,
                            isLoading: viewModel.isLoading,
                            onScrollToBottom: { }
                        )
                        .frame(width: geometry.size.width)
                    }
                    
                    // MARK: - 输入框
                    MessageInputView(
                        message: $viewModel.currentMessage,
                        isLoading: viewModel.isLoading,
                        onSend: {
                            Task {
                                await viewModel.sendMessage()
                            }
                        }
                    )
                }
                .overlay {
                    // MARK: - 半透明遮罩
                    Color.black.opacity(viewModel.sidebarOffsetProgress)
                        .ignoresSafeArea()
                        .onTapGesture {
                            if viewModel.isSidebarVisible {
                                viewModel.toggleSidebar()
                            }
                        }
                }
                
                // MARK: - 侧边栏
                ChatSidebar(
                    sessions: viewModel.chatSessions,
                    currentSessionId: viewModel.currentSessionId,
                    offset: viewModel.sidebarOffset,
                    onSessionSelect: { viewModel.selectSession($0) },
                    onCreateNewChat: { viewModel.createNewChat() }
                )
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            // MARK: - 手势处理
            .gesture(
                DragGesture()
                    .onChanged { value in
                        // 只在屏幕左侧四分之一区域响应手势
                        if !viewModel.isSidebarVisible && value.startLocation.x > geometry.size.width * 0.25 {
                            return
                        }
                        viewModel.handleDrag(value, screenWidth: geometry.size.width)
                    }
                    .onEnded { value in
                        viewModel.handleDragEnded(value, screenWidth: geometry.size.width)
                    }
            )
        }
    }
}

/// 预览提供器
#Preview {
    ChatView()
}

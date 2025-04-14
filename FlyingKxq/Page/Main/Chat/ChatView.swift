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
                // MARK: - 主聊天区域
                ChatArea(
                    messages: viewModel.messages,
                    currentMessage: viewModel.currentMessage,
                    isLoading: viewModel.isLoading,
                    onMessageChange: { viewModel.currentMessage = $0 },
                    onSendMessage: {
                        Task {
                            await viewModel.sendMessage()
                        }
                    },
                    onScrollToBottom: { }
                )
                .frame(width: geometry.size.width)
                
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

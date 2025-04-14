import Foundation
import SwiftUI

/// 聊天视图的数据模型，管理聊天界面的所有状态和业务逻辑
@MainActor
class ChatViewModel: ObservableObject {
    // MARK: - Published 属性

    /// 视图状态
    @Published private(set) var state: ChatViewState

    // MARK: - 私有属性

    private let networkService: ChatNetworkService
    private let storageService: ChatStorageService
    private let sidebarWidth: CGFloat = UIScreen.main.bounds.width * 0.6

    // MARK: - 初始化方法

    init(
        networkService: ChatNetworkService = DefaultChatNetworkService(),
        storageService: ChatStorageService = DefaultChatStorageService()
    ) {
        self.networkService = networkService
        self.storageService = storageService
        state = ChatViewState()

        // 加载保存的数据
        Task {
            await loadSavedData()
        }
    }

    // MARK: - 私有方法

    /// 加载保存的聊天数据
    private func loadSavedData() async {
        do {
            let sessions = try storageService.loadChatSessions()
            if !sessions.isEmpty {
                state.chatSessions = sessions
                // 选择最新的会话
                if let latestSession = sessions.max(by: { $0.lastUpdated < $1.lastUpdated }) {
                    state.currentSessionId = latestSession.id
                    state.messages = try storageService.loadMessages(forSession: latestSession.id)
                }
            } else {
                // 创建初始会话
                await setupInitialChats()
            }
        } catch {
            handleError(ChatError.storageError("无法加载保存的聊天数据"))
        }
    }

    /// 设置初始的示例聊天会话
    private func setupInitialChats() async {
        let session1 = ChatSession(
            title: "欢迎对话",
            messages: [
                Message(content: "你好！我是AI助手，很高兴见到你。", isUser: false, timestamp: Date().addingTimeInterval(-3600)),
                Message(content: "你好！我也很高兴见到你。", isUser: true, timestamp: Date().addingTimeInterval(-3500)),
            ],
            lastUpdated: Date().addingTimeInterval(-3500)
        )

        state.chatSessions = [session1]
        state.currentSessionId = session1.id
        state.messages = session1.messages

        // 保存初始数据
        do {
            try storageService.saveChatSessions(state.chatSessions)
            try storageService.saveMessages(session1.messages, forSession: session1.id)
        } catch {
            handleError(ChatError.storageError("无法保存初始聊天数据"))
        }
    }

    /// 处理错误
    private func handleError(_ error: ChatError) {
        state.error = error
        // TODO: 实现错误提示UI
        print("错误：\(error.localizedDescription)")
    }

    // MARK: - 公开方法

    /// 发送消息
    func sendMessage() async {
        guard !state.currentMessage.isEmpty else {
            handleError(.messageEmpty)
            return
        }

        guard state.currentSessionId != nil else {
            handleError(.invalidSession)
            return
        }

        // 创建用户消息
        let userMessage = Message(
            content: state.currentMessage,
            isUser: true,
            timestamp: Date()
        )

        // 清空输入
        state.currentMessage = ""

        do {
            // 添加用户消息
            state.messages.append(userMessage)
            state.scrollToBottom = true

            // 更新会话
            if let index = state.chatSessions.firstIndex(where: { $0.id == state.currentSessionId }) {
                state.chatSessions[index].messages.append(userMessage)
                state.chatSessions[index].lastUpdated = Date()

                // 保存更新
                try storageService.saveChatSessions(state.chatSessions)
                try storageService.saveMessages(state.messages, forSession: state.currentSessionId!)
            }

            // 获取 AI 回复
            state.isLoading = true
            let response = try await networkService.sendMessage(userMessage.content)

            // 创建 AI 消息
            let aiMessage = Message(
                content: response,
                isUser: false,
                timestamp: Date()
            )

            // 添加 AI 消息
            state.messages.append(aiMessage)
            state.scrollToBottom = true

            // 更新会话
            if let index = state.chatSessions.firstIndex(where: { $0.id == state.currentSessionId }) {
                state.chatSessions[index].messages.append(aiMessage)
                state.chatSessions[index].lastUpdated = Date()

                // 保存更新
                try storageService.saveChatSessions(state.chatSessions)
                try storageService.saveMessages(state.messages, forSession: state.currentSessionId!)
            }
        } catch {
            handleError(error as? ChatError ?? .unknown(error))
        }

        state.isLoading = false
    }

    /// 创建新的聊天会话
    func createNewChat() {
        let newSession = ChatSession(
            title: "新聊天",
            messages: [],
            lastUpdated: Date()
        )

        do {
            state.chatSessions.append(newSession)
            state.currentSessionId = newSession.id
            state.messages = []

            // 保存新会话
            try storageService.saveChatSessions(state.chatSessions)

            toggleSidebar() // 创建新聊天后关闭侧边栏
        } catch {
            handleError(ChatError.storageError("无法保存新的聊天会话"))
        }
    }

    /// 选择并切换到指定的会话
    func selectSession(_ session: ChatSession) {
        do {
            state.currentSessionId = session.id
            state.messages = try storageService.loadMessages(forSession: session.id)
            state.scrollToBottom = true
            toggleSidebar() // 选择会话后关闭侧边栏
        } catch {
            handleError(ChatError.storageError("无法加载会话消息"))
        }
    }

    /// 切换侧边栏的显示状态
    func toggleSidebar() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            state.isSidebarVisible.toggle()
            state.sidebarOffset = state.isSidebarVisible ? 0 : -sidebarWidth
        }
    }

    /// 处理拖动手势
    func handleDrag(_ value: DragGesture.Value, screenWidth: CGFloat) {
        let translation = value.translation.width

        if state.isSidebarVisible {
            // 已打开状态下的拖动
            if translation < 0 { // 向左滑动关闭
                let progress = -translation / sidebarWidth
                state.sidebarOffset = max(-sidebarWidth * progress, -sidebarWidth)
            }
        } else {
            // 未打开状态下的拖动
            if translation > 0 { // 向右滑动打开
                let progress = translation / sidebarWidth
                state.sidebarOffset = min(-sidebarWidth * (1 - progress), 0)
            }
        }
    }

    /// 处理拖动手势结束
    func handleDragEnded(_ value: DragGesture.Value, screenWidth: CGFloat) {
        let translation = value.translation.width
        let velocity = value.predictedEndLocation.x - value.location.x

        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            if state.isSidebarVisible {
                // 如果侧边栏已经打开
                if translation < -sidebarWidth * 0.2 || velocity < -500 {
                    // 关闭侧边栏（向左滑动超过20%或速度大于500）
                    state.isSidebarVisible = false
                    state.sidebarOffset = -sidebarWidth
                } else {
                    // 保持打开
                    state.sidebarOffset = 0
                }
            } else {
                // 如果侧边栏是关闭的
                if translation > sidebarWidth * 0.2 || velocity > 500 {
                    // 打开侧边栏（向右滑动超过20%或速度大于500）
                    state.isSidebarVisible = true
                    state.sidebarOffset = 0
                } else {
                    // 保持关闭
                    state.sidebarOffset = -sidebarWidth
                }
            }
        }
    }

    // MARK: - 状态访问器

    var currentMessage: String {
        get { state.currentMessage }
        set { state.currentMessage = newValue }
    }

    var messages: [Message] { state.messages }
    var chatSessions: [ChatSession] { state.chatSessions }
    var currentSessionId: UUID? { state.currentSessionId }
    var scrollToBottom: Bool { state.scrollToBottom }
    var sidebarOffset: CGFloat { state.sidebarOffset }
    var isSidebarVisible: Bool { state.isSidebarVisible }
    var isLoading: Bool { state.isLoading }
    var sidebarOffsetProgress: CGFloat {
        return min(1 + state.sidebarOffset / sidebarWidth, 0.5)
    }
}

import Foundation
import SwiftUI

/// 聊天视图的状态模型
struct ChatViewState {
    /// 是否正在加载
    var isLoading: Bool = false
    
    /// 当前错误
    var error: ChatError?
    
    /// 当前输入的消息
    var currentMessage: String = ""
    
    /// 侧边栏是否可见
    var isSidebarVisible: Bool = false
    
    /// 侧边栏偏移量
    var sidebarOffset: CGFloat = 0
    
    /// 主界面的灰度值
    var mainViewGrayScale: Double = 0
    
    /// 是否需要滚动到底部
    var scrollToBottom: Bool = false
    
    /// 当前选中的会话ID
    var currentSessionId: UUID?
    
    /// 所有聊天会话
    var chatSessions: [ChatSession] = []
    
    /// 当前会话的消息列表
    var messages: [Message] = []
    
    /// 获取当前选中的会话
    var currentSession: ChatSession? {
        chatSessions.first { $0.id == currentSessionId }
    }
} 

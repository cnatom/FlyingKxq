import Foundation

/// 聊天会话模型
struct ChatSession: Identifiable, Codable {
    /// 会话唯一标识
    let id: UUID
    /// 会话标题
    var title: String
    /// 会话中的消息列表
    var messages: [Message]
    /// 最后更新时间
    var lastUpdated: Date
    
    init(title: String, messages: [Message] = [], lastUpdated: Date = Date()) {
        self.id = UUID()
        self.title = title
        self.messages = messages
        self.lastUpdated = lastUpdated
    }
} 
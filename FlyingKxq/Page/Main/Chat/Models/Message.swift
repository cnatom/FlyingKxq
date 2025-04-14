import Foundation

/// 聊天消息模型
struct Message: Identifiable, Codable {
    /// 消息唯一标识
    let id: UUID
    /// 消息内容
    let content: String
    /// 是否是用户发送的消息
    let isUser: Bool
    /// 消息发送时间
    let timestamp: Date
    
    init(content: String, isUser: Bool, timestamp: Date = Date()) {
        self.id = UUID()
        self.content = content
        self.isUser = isUser
        self.timestamp = timestamp
    }
} 
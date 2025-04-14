import Foundation

/// 聊天存储服务接口
protocol ChatStorageService {
    /// 保存所有聊天会话
    func saveChatSessions(_ sessions: [ChatSession]) throws
    
    /// 加载所有聊天会话
    func loadChatSessions() throws -> [ChatSession]
    
    /// 保存指定会话的消息
    func saveMessages(_ messages: [Message], forSession sessionId: UUID) throws
    
    /// 加载指定会话的消息
    func loadMessages(forSession sessionId: UUID) throws -> [Message]
}

/// 默认的存储服务实现（使用 UserDefaults）
class DefaultChatStorageService: ChatStorageService {
    private let userDefaults = UserDefaults.standard
    private let sessionsKey = "chat_sessions"
    private let messagesKeyPrefix = "chat_messages_"
    
    func saveChatSessions(_ sessions: [ChatSession]) throws {
        let data = try JSONEncoder().encode(sessions)
        userDefaults.set(data, forKey: sessionsKey)
    }
    
    func loadChatSessions() throws -> [ChatSession] {
        guard let data = userDefaults.data(forKey: sessionsKey) else {
            return []
        }
        return try JSONDecoder().decode([ChatSession].self, from: data)
    }
    
    func saveMessages(_ messages: [Message], forSession sessionId: UUID) throws {
        let data = try JSONEncoder().encode(messages)
        userDefaults.set(data, forKey: messagesKeyPrefix + sessionId.uuidString)
    }
    
    func loadMessages(forSession sessionId: UUID) throws -> [Message] {
        guard let data = userDefaults.data(forKey: messagesKeyPrefix + sessionId.uuidString) else {
            return []
        }
        return try JSONDecoder().decode([Message].self, from: data)
    }
} 
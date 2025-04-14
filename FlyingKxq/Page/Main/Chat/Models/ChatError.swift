import Foundation

/// 聊天功能相关的错误类型
enum ChatError: LocalizedError {
    case networkError(String)
    case storageError(String)
    case invalidSession
    case messageEmpty
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .networkError(let message):
            return "网络错误：\(message)"
        case .storageError(let message):
            return "存储错误：\(message)"
        case .invalidSession:
            return "无效的会话"
        case .messageEmpty:
            return "消息不能为空"
        case .unknown(let error):
            return "未知错误：\(error.localizedDescription)"
        }
    }
} 
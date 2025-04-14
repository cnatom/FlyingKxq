import Foundation

/// 聊天网络服务接口
protocol ChatNetworkService {
    /// 发送消息到 AI 服务
    /// - Parameter message: 用户输入的消息
    /// - Returns: AI 的回复
    func sendMessage(_ message: String) async throws -> String
}

/// 默认的网络服务实现
class DefaultChatNetworkService: ChatNetworkService {
    func sendMessage(_ message: String) async throws -> String {
        // TODO: 实现真实的 AI API 调用
        // 目前返回模拟数据
        try await Task.sleep(nanoseconds: 1_000_000_000) // 模拟网络延迟
        return "这是 AI 的回复"
    }
} 